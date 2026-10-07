codeunit 80105 "ISE Posting Mgt."
{
    procedure GetSetup(var Setup: Record "ISE Setup")
    begin
        if not Setup.Get('SETUP')then begin
            Setup.Init();
            Setup."Primary Key":='SETUP';
            Setup.Insert(true);
        end;
    end;
    local procedure EnsureHasLinesToPost(HeaderNo: Code[20])
    var
        L: Record "ISE Customer Order Line";
    begin
        L.SetRange("Document No.", HeaderNo);
        L.SetFilter("Qty. to Post", '>0');
        //l.Setrange(Status, L.Status::Released);
        if not L.FindFirst()then Error('No lines to post for document %1.', HeaderNo);
    end;
    procedure ApproveAndPost(var OrderHdr: Record "ISE Customer Order Header")
    begin
        if not OrderHdr."Ship Alert Approved" then begin
            if(OrderHdr."Order Source" <> OrderHdr."Order Source"::Adhoc)then begin
                OrderHdr.Validate("Ship Alert Approved", true);
                OrderHdr.Validate("Ship Alert Approved By", UserId());
                OrderHdr.Validate("Ship Alert Approved DT", CurrentDateTime);
                OrderHdr.Validate("Direction Locked", true);
                OrderHdr.Modify(true);
            end;
        end;
        if OrderHdr."Order Request Type" <> OrderHdr."Order Request Type"::Receipt then if not OrderHdr."Receiving Approved" then begin
                OrderHdr.Validate("Receiving Approved", true);
                OrderHdr.Validate("Receiving Approved By", UserId());
                OrderHdr.Validate("Receiving Approved DT", CurrentDateTime);
                if OrderHdr."Order Source" = OrderHdr."Order Source"::Adhoc then OrderHdr.Validate("Direction Locked", true);
                OrderHdr.Modify(true);
            end;
        EnsureHasLinesToPost(OrderHdr."No.");
        PostOrder(OrderHdr);
    end;
    procedure GenerateInternalLot(): Code[20]var
        Setup: Record "ISE Setup";
        NoMgmt: Codeunit "No. Series";
        No: Code[20];
    begin
        GetSetup(Setup);
        if Setup."Internal Lot No. Series" = '' then Error('Internal Lot No. Series is not configured in ISE Setup.');
        No:=NoMgmt.GetNextNo(Setup."Internal Lot No. Series", WorkDate(), true);
        exit(No);
    end;
    local procedure EnsureOrderApprovals(var OrderHdr: Record "ISE Customer Order Header")
    begin
        if not OrderHdr."Receiving Approved" then Error('Receiving approval is required before posting.');
        if OrderHdr."Order Source" <> OrderHdr."Order Source"::Adhoc then if not OrderHdr."Ship Alert Approved" then Error('Ship Alert must be approved before posting.');
    end;
    procedure PostOrder(var OrderHdr: Record "ISE Customer Order Header")
    var
        Lines: Record "ISE Customer Order Line";
    begin
        if OrderHdr."Order Request Type" <> OrderHdr."Order Request Type"::Receipt then EnsureOrderApprovals(OrderHdr);
        Lines.SetRange("Document No.", OrderHdr."No.");
        //Lines.Setrange(Status, Lines.Status::Released); //Released can be posted
        if Lines.FindSet()then repeat if Lines."Qty. to Post" <= 0 then Error('Qty. to Post must be greater than zero on line %1.', Lines."Line No.");
                if Lines.Type = Lines.Type::Inventory then PostInventoryLine(Lines)
                else
                    PostNonInventoryLine(Lines);
            until Lines.Next() = 0;
        case OrderHdr."Order Request Type" of OrderHdr."Order Request Type"::Receipt: CreatePostedReceipt(OrderHdr);
        OrderHdr."Order Request Type"::Shipment: CreatePostedShipment(OrderHdr);
        end;
    //CreatePostedReceipt(OrderHdr);
    end;
    local procedure EffectiveType(var Hdr: Record "ISE Customer Order Header"): Enum "ISE Request Type" begin
        exit(Hdr."Order Request Type");
    end;
    local procedure GetBinOnHand(Line: Record "ISE Customer Order Line"; Eff: Enum "ISE Request Type"): Decimal var
        BinMgt: Codeunit "ISE Bin Ledger Mgt.";
        ILE: Record "Item Ledger Entry";
        q: Decimal;
    begin
        if Eff = Eff::Shipment then begin
            if Line."Bin Code" <> '' then exit(BinMgt.GetOnHand(Line."No.", Line."Location Code", Line."Bin Code", Line."Internal Lot No.", Line."Serial No."))
            else
            begin
                ILE.Reset();
                ILE.SetRange("Item No.", Line."No.");
                ILE.SetRange("Location Code", Line."Location Code");
                if Line."Internal Lot No." <> '' then ILE.SetRange("Lot No.", Line."Internal Lot No.");
                if Line."Serial No." <> '' then ILE.SetRange("Serial No.", Line."Serial No.");
                if ILE.FindSet()then repeat q+=ILE."Remaining Quantity" until ILE.Next() = 0;
                exit(q);
            end;
        end;
        exit(0);
    end;
    local procedure PostInventoryLine(var Line: Record "ISE Customer Order Line")
    var
        ItemJnlLine: Record "Item Journal Line";
        ItemJnlPost: Codeunit "Item Jnl.-Post";
        Setup: Record "ISE Setup";
        Hdr: Record "ISE Customer Order Header";
        Eff: Enum "ISE Request Type";
        onhand: Decimal;
        BinMgt: Codeunit "ISE Bin Ledger Mgt.";
        itemrec: Record Item;
    begin
        if not Hdr.Get(Line."Document No.")then Error('Order header not found for %1.', Line."Document No.");
        Eff:=EffectiveType(Hdr);
        if Line."Qty. to Post" > (Line.Quantity - Line."Qty. Received")then Error('Qty. to Post exceeds remaining to receive on line %1.', Line."Line No.");
        if Eff = Eff::Shipment then begin
            onhand:=GetBinOnHand(Line, Eff);
            if Line."Qty. to Post" > onhand then Error('Insufficient on-hand (%1) at %2/%3.', onhand, Line."Location Code", Line."Bin Code");
        end;
        GetSetup(Setup);
        itemrec.get(Line."No.");
        ItemJnlLine.Init();
        ItemJnlLine.Validate("Journal Template Name", Setup."Item Jnl. Template");
        ItemJnlLine.Validate("Journal Batch Name", Setup."Item Jnl. Batch");
        if Eff = Eff::Shipment then ItemJnlLine.Validate("Entry Type", ItemJnlLine."Entry Type"::"Negative Adjmt.")
        else
            ItemJnlLine.Validate("Entry Type", ItemJnlLine."Entry Type"::"Positive Adjmt.");
        ItemJnlLine."Item No.":=Line."No.";
        ItemJnlLine."Posting Date":=Today;
        ItemJnlLine."Document No.":=Line."Document No.";
        ItemJnlLine.Description:=itemrec.Description;
        ItemJnlLine."Gen. Prod. Posting Group":=itemrec."Gen. Prod. Posting Group";
        ItemJnlLine.Validate(Quantity, Line."Qty. to Post");
        ItemJnlLine.Validate("Location Code", Line."Location Code");
        if Line."Bin Code" <> '' then ItemJnlLine.Validate("Bin Code", Line."Bin Code");
        if Line."Internal Lot No." = '' then Line."Internal Lot No.":=GenerateInternalLot();
        ItemJnlLine.Validate("Lot No.", Line."Internal Lot No.");
        if Line."Serial No." <> '' then ItemJnlLine.Validate("Serial No.", Line."Serial No.");
        ItemJnlLine.Insert(true);
        ItemJnlPost.Run(ItemJnlLine);
        // Bin mirror (Zone-aware)
        if Eff = Eff::Shipment then BinMgt.AddMovementEx(Line."No.", Line."Location Code", Line."Zone Code", Line."Bin Code", Line."Internal Lot No.", Line."Serial No.", -Line."Qty. to Post", Line."Document No.", Line."Line No.")
        else
            BinMgt.AddMovementEx(Line."No.", Line."Location Code", Line."Zone Code", Line."Bin Code", Line."Internal Lot No.", Line."Serial No.", Line."Qty. to Post", Line."Document No.", Line."Line No.");
        Line."Qty. Received":=Line."Qty. Received" + Line."Qty. to Post";
        Line.Modify(true);
    end;
    local procedure PostNonInventoryLine(var Line: Record "ISE Customer Order Line")
    var
        Non: Record "ISE Non-Inv. Ledger Entry";
        Hdr: Record "ISE Customer Order Header";
        Eff: Enum "ISE Request Type";
        BinMgt: Codeunit "ISE Bin Ledger Mgt.";
    begin
        if not Hdr.Get(Line."Document No.")then Error('Order header not found for %1.', Line."Document No.");
        Eff:=EffectiveType(Hdr);
        if Line."Qty. to Post" > (Line.Quantity - Line."Qty. Received")then Error('Qty. to Post exceeds remaining to receive on line %1.', Line."Line No.");
        Non.Init();
        Non."Posting Date":=Today;
        Non."Document No.":=Line."Document No.";
        if Eff = Eff::Shipment then Non."Entry Type":=Non."Entry Type"::Shipment
        else
            Non."Entry Type":=Non."Entry Type"::Receipt;
        Non."No.":=Line."No.";
        Non.Description:=Line.Description;
        Non.Quantity:=Line."Qty. to Post";
        Non."Location Code":=Line."Location Code";
        Non."Bin Code":=Line."Bin Code";
        if Line."Internal Lot No." = '' then Line."Internal Lot No.":=GenerateInternalLot();
        Non."Internal Lot No.":=Line."Internal Lot No.";
        Non."Customer Lot No.":=Line."Customer Lot No.";
        Non."Serial No.":=Line."Serial No.";
        Non."Source Doc. No.":=Line."Document No.";
        Non."Source Line No.":=Line."Line No.";
        Non.Insert();
        if Eff = Eff::Shipment then BinMgt.AddMovementEx(Line."No.", Line."Location Code", Line."Zone Code", Line."Bin Code", Line."Internal Lot No.", Line."Serial No.", -Line."Qty. to Post", Line."Document No.", Line."Line No.")
        else
            BinMgt.AddMovementEx(Line."No.", Line."Location Code", Line."Zone Code", Line."Bin Code", Line."Internal Lot No.", Line."Serial No.", Line."Qty. to Post", Line."Document No.", Line."Line No.");
        Line."Qty. Received":=Line."Qty. Received" + Line."Qty. to Post";
        Line.Modify(true);
    end;
    local procedure CreatePostedReceipt(OrderHdr: Record "ISE Customer Order Header")
    var
        PRH: Record "ISE Posted Receipt Hdr";
        PRL: Record "ISE Posted Receipt Line";
        Lines: Record "ISE Customer Order Line";
        Setup: Record "ISE Setup";
        NoMgmt: Codeunit "No. Series";
        No: Code[20];
        LnNo: Integer;
    begin
        GetSetup(Setup);
        if Setup."Posted Receipt No. Series" = '' then Error('Posted Receipt No. Series is not configured in ISE Setup.');
        No:=NoMgmt.GetNextNo(Setup."Posted Receipt No. Series", WorkDate(), true);
        PRH.Init();
        PRH."No.":=No;
        PRH."Source Doc. No.":=OrderHdr."No.";
        PRH."Posting Date":=Today;
        PRH."Customer No.":=OrderHdr."Customer No.";
        PRH."Customer Name":=OrderHdr."Customer Name";
        PRH."Vendor/Customer":=OrderHdr."Vendor/Customer";
        PRH."Vendor/Customer":=OrderHdr."Vendor/Customer";
        PRH."Customer/Vendor No.":=OrderHdr."Customer/Vendor No.";
        PRH."Sender Company Name":=OrderHdr."Sender Company Name";
        PRH."Requestor/Sender Name":=OrderHdr."Requestor/Sender Name";
        PRH."Recipient/Attention To":=OrderHdr."Recipient/Attention To";
        PRH."Number of Packages":=OrderHdr."Number of Packages";
        PRH."ISE Destination Location":=OrderHdr."ISE Destination Location";
        PRH."Delivery Method":=OrderHdr."Delivery Method 2";
        PRH."Courier/Forwarder Name":=OrderHdr."Courier/Forwarder Name";
        PRH."Air Way Bill (AWB)":=OrderHdr."Air Way Bill (AWB)";
        PRH."Expected Date Time":=OrderHdr."Expected Date Time";
        PRH."Pick up Address":=OrderHdr."Pick up Address";
        PRH."Pick up Contact Person":=OrderHdr."Pick up Contact Person";
        PRH."Contact Phone Number":=OrderHdr."Contact Phone Number";
        PRH."Special Instructions":=OrderHdr."Special Instructions";
        PRH."Behalf of Customer":=OrderHdr."Behalf of Customer";
        PRH."Package Hardware":=OrderHdr."Package Hardware";
        PRH."Package Lot":=OrderHdr."Package Lot";
        PRH."Package Tray":=OrderHdr."Package Tray";
        PRH."Package Other":=OrderHdr."Package Other";
        PRH.Information:=OrderHdr.Information;
        PRH.Insert();
        Lines.SetRange("Document No.", OrderHdr."No.");
        if Lines.FindSet()then begin
            LnNo:=0;
            repeat if Lines."Qty. to Post" > 0 then begin
                    LnNo+=10000;
                    PRL.Init();
                    PRL."Document No.":=PRH."No.";
                    PRL."Line No.":=LnNo;
                    if Lines.Type = Lines.Type::Inventory then PRL.Type:=PRL.Type::Inventory
                    else
                        PRL.Type:=PRL.Type::NonInventory;
                    PRL."No.":=Lines."No.";
                    PRL.Description:=Lines.Description;
                    PRL.Quantity:=Lines."Qty. to Post";
                    PRL."Location Code":=Lines."Location Code";
                    PRL."Bin Code":=Lines."Bin Code";
                    PRL."Customer Lot No.":=Lines."Customer Lot No.";
                    PRL."Internal Lot No.":=Lines."Internal Lot No.";
                    PRL."Serial No.":=Lines."Serial No.";
                    PRL."Source Doc. No.":=Lines."Document No.";
                    PRL."Source Line No.":=Lines."Line No.";
                    PRL."Manual Line Type":=Lines."Manual Line Type";
                    PRL."Lot#":=Lines."Lot#";
                    PRL."Customer Lot":=Lines."Customer Lot#";
                    PRL.DeviceName:=Lines.DeviceName;
                    PRL.Expedite:=Lines.Expedite;
                    PRL."IQA Optional":=Lines."IQA Optional";
                    PRL."Lot Owner":=Lines."Lot Owner";
                    PRL."Date Code":=Lines."Date Code";
                    PRL.COO:=Lines.COO;
                    PRL.Hold:=Lines.Hold;
                    PRL."HW Details":=Lines."HW Details";
                    PRL."Tray Vendor":=Lines."Tray Vendor";
                    PRL."Tray Part":=Lines."Tray Part#";
                    PRL.Insert();
                end;
            until Lines.Next() = 0;
        end;
    end;
    local procedure CreatePostedShipment(OrderHdr: Record "ISE Customer Order Header")
    var
        PSH: Record "ISE Posted Shipment Hdr";
        PSL: Record "ISE Posted Shipment Line";
        Lines: Record "ISE Customer Order Line";
        Setup: Record "ISE Setup";
        NoSeries: Codeunit "No. Series";
        NewNo: Code[20];
        LnNo: Integer;
    begin
        GetSetup(Setup);
        if Setup."Posted Shipment No. Series" = '' then Error('Posted Shipment No. Series is not configured in ISE Setup.');
        NewNo:=NoSeries.GetNextNo(Setup."Posted Shipment No. Series", WorkDate(), true);
        PSH.Init();
        PSH."No.":=NewNo;
        PSH."Source Doc. No.":=OrderHdr."No.";
        PSH."Posting Date":=Today;
        PSH."Customer No.":=OrderHdr."Customer No.";
        PSH."Customer Name":=OrderHdr."Customer Name";
        PSH.Insert();
        Lines.SetRange("Document No.", OrderHdr."No.");
        if Lines.FindSet()then begin
            LnNo:=0;
            repeat if Lines."Qty. to Post" > 0 then begin
                    LnNo+=10000;
                    PSL.Init();
                    PSL."Document No.":=PSH."No.";
                    PSL."Line No.":=LnNo;
                    if Lines.Type = Lines.Type::Inventory then PSL.Type:=PSL.Type::Inventory
                    else
                        PSL.Type:=PSL.Type::NonInventory;
                    PSL."No.":=Lines."No.";
                    PSL.Description:=Lines.Description;
                    PSL.Quantity:=Lines."Qty. to Post";
                    PSL."Location Code":=Lines."Location Code";
                    PSL."Bin Code":=Lines."Bin Code";
                    PSL."Customer Lot No.":=Lines."Customer Lot No.";
                    PSL."Internal Lot No.":=Lines."Internal Lot No.";
                    PSL."Serial No.":=Lines."Serial No.";
                    PSL."Source Doc. No.":=Lines."Document No.";
                    PSL."Source Line No.":=Lines."Line No.";
                    PSL.Insert();
                end;
            until Lines.Next() = 0;
        end;
    end;
}
