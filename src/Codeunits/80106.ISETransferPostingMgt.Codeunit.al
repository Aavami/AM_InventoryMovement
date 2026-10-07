codeunit 80106 "ISE Transfer Posting Mgt."
{
    // === Helper: get setup ===
    procedure ValidateHeaderByType(var Hdr: Record "ISE Transfer Header")
    begin
        EnsureValidTransferType(Hdr);
        EnsureRequiredFieldsByType(Hdr);
        EnsureLinesExist(Hdr);
    end;
    local procedure EnsureValidTransferType(Hdr: Record "ISE Transfer Header")
    begin
        case Hdr."Transfer Type" of Hdr."Transfer Type"::Interlocation, Hdr."Transfer Type"::IntraLocation, Hdr."Transfer Type"::Subcontractor: ;
        else
            Error('Transfer Type must be selected before posting.');
        end;
    end;
    local procedure EnsureRequiredFieldsByType(Hdr: Record "ISE Transfer Header")
    begin
        case Hdr."Transfer Type" of Hdr."Transfer Type"::Interlocation: begin
            Hdr.TestField("From Location Code");
            Hdr.TestField("To Location Code");
        end;
        Hdr."Transfer Type"::IntraLocation: begin
            Hdr.TestField("From Location Code");
            Hdr.TestField("To Location Code");
        //Hdr.TestField("From Bin Code");
        //Hdr.TestField("To Bin Code");
        end;
        Hdr."Transfer Type"::Subcontractor: begin
            Hdr.TestField("Subcon Vendor Location");
            Hdr.TestField("From Location Code");
        end;
        end;
    end;
    local procedure EnsureLinesExist(Hdr: Record "ISE Transfer Header")
    var
        Line: Record "ISE Transfer Line";
    begin
        Line.SetRange("Document No.", Hdr."No.");
        if not Line.FindFirst()then Error('There are no lines to post for document %1.', Hdr."No.");
    end;
    local procedure GetSetup(var Setup: Record "ISE Setup")
    begin
        if not Setup.Get('SETUP')then begin
            Setup.Init();
            Setup."Primary Key":='SETUP';
            Setup.Insert(true);
        end;
    end;
    // === Helper: post single Item Journal Line ===
    local procedure PostItemMovement(EntryIsNegative: Boolean; ItemNo: Code[20]; Qty: Decimal; Loc: Code[10]; Zone: Code[10]; Bin: Code[20]; Lot: Code[20]; Serial: Code[50])
    var
        Setup: Record "ISE Setup";
        ItemJnlLine: Record "Item Journal Line";
        ItemJnlPost: Codeunit "Item Jnl.-Post";
    begin
        if Qty = 0 then exit;
        GetSetup(Setup);
        Setup.TestField("Item Jnl. Template");
        Setup.TestField("Item Jnl. Batch");
        ItemJnlLine.Init();
        ItemJnlLine.Validate("Journal Template Name", Setup."Item Jnl. Template");
        ItemJnlLine.Validate("Journal Batch Name", Setup."Item Jnl. Batch");
        if EntryIsNegative then ItemJnlLine.Validate("Entry Type", ItemJnlLine."Entry Type"::"Negative Adjmt.")
        else
            ItemJnlLine.Validate("Entry Type", ItemJnlLine."Entry Type"::"Positive Adjmt.");
        ItemJnlLine.Validate("Item No.", ItemNo);
        ItemJnlLine.Validate(Quantity, Qty);
        if Loc <> '' then ItemJnlLine.Validate("Location Code", Loc);
        if Bin <> '' then ItemJnlLine.Validate("Bin Code", Bin);
        if Lot <> '' then ItemJnlLine.Validate("Lot No.", Lot);
        if Serial <> '' then ItemJnlLine.Validate("Serial No.", Serial);
        ItemJnlLine.Insert(true);
        ItemJnlPost.Run(ItemJnlLine);
    end;
    // === Helper: bin mirror ===
    local procedure MirrorBinMovement(Positive: Boolean; ItemNo: Code[20]; Qty: Decimal; Loc: Code[10]; Zone: Code[10]; Bin: Code[20]; Lot: Code[20]; Serial: Code[50]; SourceDoc: Code[20]; SourceLine: Integer)
    var
        BinMgt: Codeunit "ISE Bin Ledger Mgt.";
    begin
        if Positive then BinMgt.AddMovementEx(ItemNo, Loc, Zone, Bin, Lot, Serial, Qty, SourceDoc, SourceLine)
        else
            BinMgt.AddMovementEx(ItemNo, Loc, Zone, Bin, Lot, Serial, -Qty, SourceDoc, SourceLine);
    end;
    local procedure InstantReceiveOnShip(TransferType: Enum "ISE Transfer Type"): Boolean begin
        // Interlocation = two-step; Intralocation/Subcontractor = one-step
        if TransferType in[TransferType::Intralocation, TransferType::Subcontractor]then exit(true);
        exit(false);
    end;
    // === SHIP ===
    procedure PostTransferShip(var Hdr: Record "ISE Transfer Header")
    /* var
        Setup: Record "ISE Setup";
        NoMgmt: Codeunit "No. Series";
        PL: Record "ISE Transfer Line";
        PSH: Record "ISE Posted Transfer Ship Hdr";
        PSL: Record "ISE Posted Transfer Ship Line";
        LnNo: Integer;
        NewNo: Code[20];
        OneStep: Boolean;
        Non: Record "ISE Non-Inv. Ledger Entry";
    begin
        //  Hdr.TestField("Transfer Type");
        if not Hdr."Ship Approved" then
            Error('Ship must be approved.');

        GetSetup(Setup);
        Setup.TestField("Posted Trans-Ship No. Series");
        NewNo := NoMgmt.GetNextNo(Setup."Posted Trans-Ship No. Series", WorkDate(), true);

        PSH.Init();
        PSH."No." := NewNo;
        PSH."Source Transfer No." := Hdr."No.";
        PSH."Posting Date" := Today;
        PSH."From Location Code" := Hdr."From Location Code";
        PSH."In-Transit Location Code" := Hdr."In-Transit Location Code";
        PSH."Transfer Type" := Hdr."Transfer Type";
        PSH.Insert();

        OneStep := InstantReceiveOnShip(Hdr."Transfer Type");

        PL.SetRange("Document No.", Hdr."No.");
        LnNo := 0;
        if PL.FindSet() then
            repeat
                if PL."Qty. to Post" <= 0 then
                    Error('Qty. to Post must be greater than zero on line %1.', PL."Line No.");

                if PL.Type = PL.Type::Inventory then begin
                    // Negative FROM (IJ + Bin mirror)
                    PostItemMovement(true, PL."No.", PL."Qty. to Post", PL."From Location Code", PL."From Zone Code", PL."From Bin Code", PL."Internal Lot No.", PL."Serial No.");
                    MirrorBinMovement(false, PL."No.", PL."Qty. to Post", PL."From Location Code", PL."From Zone Code", PL."From Bin Code", PL."Internal Lot No.", PL."Serial No.", PL."Document No.", PL."Line No.");

                    // Positive TO on ship for one-step types (Intra/Subcon)
                    if OneStep then begin
                        PostItemMovement(false, PL."No.", PL."Qty. to Post", PL."To Location Code", PL."To Zone Code", PL."To Bin Code", PL."Internal Lot No.", PL."Serial No.");
                        MirrorBinMovement(true, PL."No.", PL."Qty. to Post", PL."To Location Code", PL."To Zone Code", PL."To Bin Code", PL."Internal Lot No.", PL."Serial No.", PL."Document No.", PL."Line No.");
                    end;
                end else begin
                    // Non-Inventory: TransferOut on SHIP
                    Non.Init();
                    Non."Posting Date" := Today;
                    Non."Document No." := Hdr."No.";
                    Non."Entry Type" := Non."Entry Type"::TransferOut;
                    Non."No." := PL."No.";
                    Non.Description := PL.Description;
                    Non.Quantity := PL."Qty. to Post";
                    Non."Location Code" := PL."From Location Code";
                    Non."Bin Code" := PL."From Bin Code";
                    Non."Internal Lot No." := PL."Internal Lot No.";
                    Non."Serial No." := PL."Serial No.";
                    Non."Source Doc. No." := PL."Document No.";
                    Non."Source Line No." := PL."Line No.";
                    Non.Insert();
                end;

                // Posted shipment line
                LnNo += 10000;
                PSL.Init();
                PSL."Document No." := PSH."No.";
                PSL."Line No." := LnNo;
                PSL.Type := (PL.Type = PL.Type::Inventory) ? PSL.Type::Inventory : PSL.Type::NonInventory;
                PSL."No." := PL."No.";
                PSL.Description := PL.Description;
                PSL.Quantity := PL."Qty. to Post";
                PSL."From Location Code" := PL."From Location Code";
                PSL."From Bin Code" := PL."From Bin Code";
                PSL."Internal Lot No." := PL."Internal Lot No.";
                PSL."Serial No." := PL."Serial No.";
                PSL."Source Doc. No." := PL."Document No.";
                PSL."Source Line No." := PL."Line No.";
                PSL.Insert();

                PL."Qty. Shipped" := PL."Qty. Shipped" + PL."Qty. to Post";
                //PL."Qty. to Post" := 0;
                PL.Modify(true);
            until PL.Next() = 0;

        // Status
        Hdr.Status := Hdr.Status::Shipped;
        Hdr.Modify(true); */
    var
        Line: Record "ISE Transfer Line";
        PShpHdr: Record "ISE Posted Transfer Ship Hdr";
        PShpLine: Record "ISE Posted Transfer Ship Line";
        Setup: Record "ISE Setup";
        NoSeries: Codeunit "No. Series";
        No: Code[20];
        LnNo: Integer;
        BinMgt: Codeunit "ISE Bin Ledger Mgt.";
        AnyLine: Boolean;
        Remaining: Decimal;
        OneStep: Boolean;
        Non: Record "ISE Non-Inv. Ledger Entry";
    begin
        if not Hdr."Ship Approved" then Error('Ship must be approved before posting.');
        Line.SetRange("Document No.", Hdr."No.");
        if not Line.FindSet()then Error('No lines on transfer %1.', Hdr."No.");
        repeat if Line.Type = Line.Type::Inventory then begin
                Remaining:=Line.Quantity - Line."Qty. Shipped";
                if(Line."Qty. to Ship" <= 0) and (Remaining > 0)then begin
                    Line.Validate("Qty. to Ship", Remaining);
                    Line.Modify(true);
                end;
                if Line."Qty. to Ship" <= 0 then Error('Qty. to Ship must be greater than zero on line %1.', Line."Line No.");
                if Line."Qty. to Ship" > Remaining then Error('Qty. to Ship exceeds remaining to ship on line %1.', Line."Line No.");
                Line.Validate("Qty. to Post", Line."Qty. to Ship");
                Line.Modify(true);
                AnyLine:=AnyLine or (Line."Qty. to Post" > 0);
            end
            else
            begin
                if(Line."Qty. to Ship" <= 0) and (Line."Qty. to Post" <= 0)then Error('Provide Qty. to Ship (or Qty. to Post) on non-inventory line %1.', Line."Line No.");
                if(Line."Qty. to Ship" > 0) and (Line."Qty. to Ship" > (Line.Quantity - Line."Qty. Shipped"))then Error('Qty. to Ship exceeds remaining to ship on line %1.', Line."Line No.");
                if(Line."Qty. to Ship" > 0)then begin
                    Line.Validate("Qty. to Post", Line."Qty. to Ship");
                    Line.Modify(true);
                end;
                AnyLine:=AnyLine or (Line."Qty. to Post" > 0);
            end;
        until Line.Next() = 0;
        if not AnyLine then Error('No lines to post.');
        if not Setup.Get('SETUP')then Error('ISE Setup not found.');
        if Setup."Posted Trans-Ship No. Series" = '' then Error('Posted Trans-Ship No. Series not configured in ISE Setup.');
        No:=NoSeries.GetNextNo(Setup."Posted Trans-Ship No. Series", WorkDate(), true);
        PShpHdr.Init();
        PShpHdr."No.":=No;
        PShpHdr."Source Transfer No.":=Hdr."No.";
        PShpHdr."Posting Date":=Today;
        PShpHdr."Transfer Type":=Hdr."Transfer Type";
        PShpHdr."From Location Code":=Hdr."From Location Code";
        //PShpHdr."To Location Code" := Hdr."To Location Code";
        PShpHdr.Insert();
        OneStep:=InstantReceiveOnShip(Hdr."Transfer Type");
        Line.Reset();
        Line.SetRange("Document No.", Hdr."No.");
        LnNo:=0;
        if Line.FindSet()then repeat if Line."Qty. to Post" > 0 then begin
                    LnNo+=10000;
                    PShpLine.Init();
                    PShpLine."Document No.":=PShpHdr."No.";
                    PShpLine."Line No.":=LnNo;
                    if Line.Type = Line.Type::Inventory then PShpLine.Type:=PShpLine.Type::Inventory
                    else
                        PShpLine.Type:=PShpLine.Type::NonInventory;
                    PShpLine."No.":=Line."No.";
                    PShpLine.Description:=Line.Description;
                    PShpLine.Quantity:=Line."Qty. to Post";
                    PShpLine."From Location Code":=Line."From Location Code";
                    PShpLine."From Bin Code":=Line."From Bin Code";
                    //PShpLine."To Location Code" := Line."To Location Code";
                    //PShpLine."To Bin Code" := Line."To Bin Code";
                    //PShpLine."Customer Lot No." := Line."Customer Lot No.";
                    PShpLine."Internal Lot No.":=Line."Internal Lot No.";
                    PShpLine."Serial No.":=Line."Serial No.";
                    PShpLine."Source Doc. No.":=Line."Document No.";
                    PShpLine."Source Line No.":=Line."Line No.";
                    PShpLine.Insert();
                    //if Line.Type = Line.Type::Inventory then BinMgt.AddMovement(Line."No.", Line."From Location Code", Line."From Bin Code", Line."Internal Lot No.", Line."Serial No.", -Line."Qty. to Post", Line."Document No.", Line."Line No.");
                    if Line.Type = Line.Type::Inventory then begin
                        // Negative FROM (IJ + Bin mirror)
                        PostItemMovement(true, Line."No.", Line."Qty. to Post", Line."From Location Code", line."From Zone Code", line."From Bin Code", line."Internal Lot No.", line."Serial No.");
                        MirrorBinMovement(false, line."No.", line."Qty. to Post", line."From Location Code", line."From Zone Code", line."From Bin Code", line."Internal Lot No.", line."Serial No.", line."Document No.", line."Line No.");
                        // Positive TO on ship for one-step types (Intra/Subcon)
                        if OneStep then begin
                            PostItemMovement(false, line."No.", line."Qty. to Post", line."To Location Code", line."To Zone Code", line."To Bin Code", line."Internal Lot No.", line."Serial No.");
                            MirrorBinMovement(true, line."No.", line."Qty. to Post", line."To Location Code", line."To Zone Code", line."To Bin Code", line."Internal Lot No.", line."Serial No.", line."Document No.", line."Line No.");
                        end;
                    end
                    else
                    begin
                        // Non-Inventory: TransferOut on SHIP
                        Non.Init();
                        Non."Posting Date":=Today;
                        Non."Document No.":=Hdr."No.";
                        Non."Entry Type":=Non."Entry Type"::TransferOut;
                        Non."No.":=line."No.";
                        Non.Description:=line.Description;
                        Non.Quantity:=line."Qty. to Post";
                        Non."Location Code":=line."From Location Code";
                        Non."Bin Code":=line."From Bin Code";
                        Non."Internal Lot No.":=line."Internal Lot No.";
                        Non."Serial No.":=line."Serial No.";
                        Non."Source Doc. No.":=line."Document No.";
                        Non."Source Line No.":=line."Line No.";
                        Non.Insert();
                    end;
                    Line.Validate("Qty. Shipped", Line."Qty. Shipped" + Line."Qty. to Post");
                    Line.Validate("Qty. to Post", 0);
                    Line.Modify(true);
                end;
            until Line.Next() = 0;
        Hdr.Status:=Hdr.Status::Shipped;
        Hdr.Modify(true);
        Message('Transfer Shipment Posted, Document No. %1', Hdr."No.");
    end;
    // === RECEIVE ===
    procedure PostTransferReceive(var Hdr: Record "ISE Transfer Header")
    /* var
        Setup: Record "ISE Setup";
        NoMgmt: Codeunit "No. Series";
        PL: Record "ISE Transfer Line";
        PRH: Record "ISE Posted Transfer Recv Hdr";
        PRL: Record "ISE Posted Transfer Recv Line";
        LnNo: Integer;
        NewNo: Code[20];
        Non: Record "ISE Non-Inv. Ledger Entry";
        Subcon: Boolean;
    begin
        //Hdr.TestField("Transfer Type");
        if not Hdr."Receive Approved" then
            Error('Receive must be approved.');

        Subcon := (Hdr."Transfer Type" = Hdr."Transfer Type"::Subcontractor);

        GetSetup(Setup);
        Setup.TestField("Posted Trans-Recv No. Series");
        NewNo := NoMgmt.GetNextNo(Setup."Posted Trans-Recv No. Series", WorkDate(), true);

        PRH.Init();
        PRH."No." := NewNo;
        PRH."Source Transfer No." := Hdr."No.";
        PRH."Posting Date" := Today;
        PRH."To Location Code" := Hdr."To Location Code";
        PRH."Transfer Type" := Hdr."Transfer Type";
        PRH.Insert();

        PL.SetRange("Document No.", Hdr."No.");
        LnNo := 0;
        if PL.FindSet() then
            repeat
                if PL."Qty. to Post" <= 0 then
                    Error('Qty. to Post must be greater than zero on line %1.', PL."Line No.");

                if PL.Type = PL.Type::Inventory then begin
                    if Subcon then begin
                        // SUBCON RETURN: Negative at vendor (From), Positive at plant (To)
                        PostItemMovement(true, PL."No.", PL."Qty. to Post", PL."From Location Code", PL."From Zone Code", PL."From Bin Code", PL."Internal Lot No.", PL."Serial No.");
                        MirrorBinMovement(false, PL."No.", PL."Qty. to Post", PL."From Location Code", PL."From Zone Code", PL."From Bin Code", PL."Internal Lot No.", PL."Serial No.", PL."Document No.", PL."Line No.");

                        PostItemMovement(false, PL."No.", PL."Qty. to Post", PL."To Location Code", PL."To Zone Code", PL."To Bin Code", PL."Internal Lot No.", PL."Serial No.");
                        MirrorBinMovement(true, PL."No.", PL."Qty. to Post", PL."To Location Code", PL."To Zone Code", PL."To Bin Code", PL."Internal Lot No.", PL."Serial No.", PL."Document No.", PL."Line No.");
                    end else begin
                        // INTERLOCATION two-step: Positive at TO on Receive
                        PostItemMovement(false, PL."No.", PL."Qty. to Post", PL."To Location Code", PL."To Zone Code", PL."To Bin Code", PL."Internal Lot No.", PL."Serial No.");
                        MirrorBinMovement(true, PL."No.", PL."Qty. to Post", PL."To Location Code", PL."To Zone Code", PL."To Bin Code", PL."Internal Lot No.", PL."Serial No.", PL."Document No.", PL."Line No.");
                    end;
                end else begin
                    // Non-Inventory: TransferIn on RECEIVE
                    Non.Init();
                    Non."Posting Date" := Today;
                    Non."Document No." := Hdr."No.";
                    Non."Entry Type" := Non."Entry Type"::TransferIn;
                    Non."No." := PL."No.";
                    Non.Description := PL.Description;
                    Non.Quantity := PL."Qty. to Post";
                    Non."Location Code" := PL."To Location Code";
                    Non."Bin Code" := PL."To Bin Code";
                    Non."Internal Lot No." := PL."Internal Lot No.";
                    Non."Serial No." := PL."Serial No.";
                    Non."Source Doc. No." := PL."Document No.";
                    Non."Source Line No." := PL."Line No.";
                    Non.Insert();
                end;

                // Posted receipt line
                LnNo += 10000;
                PRL.Init();
                PRL."Document No." := PRH."No.";
                PRL."Line No." := LnNo;
                PRL.Type := (PL.Type = PL.Type::Inventory) ? PRL.Type::Inventory : PRL.Type::NonInventory;
                PRL."No." := PL."No.";
                PRL.Description := PL.Description;
                PRL.Quantity := PL."Qty. to Post";
                PRL."To Location Code" := PL."To Location Code";
                PRL."To Bin Code" := PL."To Bin Code";
                PRL."Internal Lot No." := PL."Internal Lot No.";
                PRL."Serial No." := PL."Serial No.";
                PRL."Source Doc. No." := PL."Document No.";
                PRL."Source Line No." := PL."Line No.";
                PRL.Insert();

                PL."Qty. Received" := PL."Qty. Received" + PL."Qty. to Post";
                PL."Qty. to Post" := 0;
                PL.Modify(true);
            until PL.Next() = 0;

        Hdr.Status := Hdr.Status::Received;
        Hdr.Modify(true); */
    var
        Line: Record "ISE Transfer Line";
        PRcptHdr: Record "ISE Posted Transfer Recv Hdr";
        PRcptLine: Record "ISE Posted Transfer Recv Line";
        Setup: Record "ISE Setup";
        NoSeries: Codeunit "No. Series";
        No: Code[20];
        LnNo: Integer;
        BinMgt: Codeunit "ISE Bin Ledger Mgt.";
        AnyLine: Boolean;
        Remaining: Decimal;
        Non: Record "ISE Non-Inv. Ledger Entry";
        Subcon: Boolean;
    begin
        if not Hdr."Receive Approved" then Error('Receive must be approved before posting.');
        Line.SetRange("Document No.", Hdr."No.");
        if not Line.FindSet()then Error('No lines on transfer %1.', Hdr."No.");
        repeat if Line.Type = Line.Type::Inventory then begin
                Remaining:=Line.Quantity - Line."Qty. Received";
                if(Line."Qty. to Receive" <= 0) and (Remaining > 0)then begin
                    Line.Validate("Qty. to Receive", Remaining);
                    Line.Modify(true);
                end;
                if Line."Qty. to Receive" <= 0 then Error('Qty. to Receive must be greater than zero on line %1.', Line."Line No.");
                if Line."Qty. to Receive" > Remaining then Error('Qty. to Receive exceeds remaining on line %1.', Line."Line No.");
                Line.Validate("Qty. to Post", Line."Qty. to Receive");
                Line.Modify(true);
                AnyLine:=AnyLine or (Line."Qty. to Post" > 0);
            end
            else
            begin
                if(Line."Qty. to Receive" <= 0) and (Line."Qty. to Post" <= 0)then Error('Provide Qty. to Receive (or Qty. to Post) on non-inventory line %1.', Line."Line No.");
                if(Line."Qty. to Receive" > 0) and (Line."Qty. to Receive" > (Line.Quantity - Line."Qty. Received"))then Error('Qty. to Receive exceeds remaining on line %1.', Line."Line No.");
                if(Line."Qty. to Receive" > 0)then begin
                    Line.Validate("Qty. to Post", Line."Qty. to Receive");
                    Line.Modify(true);
                end;
                AnyLine:=AnyLine or (Line."Qty. to Post" > 0);
            end;
        until Line.Next() = 0;
        if not AnyLine then Error('No lines to post.');
        if not Setup.Get('SETUP')then Error('ISE Setup not found.');
        if Setup."Posted Trans-Recv No. Series" = '' then Error('Posted Trans-Recv No. Series not configured in ISE Setup.');
        No:=NoSeries.GetNextNo(Setup."Posted Trans-Recv No. Series", WorkDate(), true);
        PRcptHdr.Init();
        PRcptHdr."No.":=No;
        PRcptHdr."Source Transfer No.":=Hdr."No.";
        PRcptHdr."Posting Date":=Today;
        PRcptHdr."Transfer Type":=Hdr."Transfer Type";
        //PRcptHdr."From Location Code" := Hdr."From Location Code";
        PRcptHdr."To Location Code":=Hdr."To Location Code";
        PRcptHdr.Insert();
        Line.Reset();
        Line.SetRange("Document No.", Hdr."No.");
        LnNo:=0;
        if Line.FindSet()then repeat if Line."Qty. to Post" > 0 then begin
                    LnNo+=10000;
                    PRcptLine.Init();
                    PRcptLine."Document No.":=PRcptHdr."No.";
                    PRcptLine."Line No.":=LnNo;
                    if Line.Type = Line.Type::Inventory then PRcptLine.Type:=PRcptLine.Type::Inventory
                    else
                        PRcptLine.Type:=PRcptLine.Type::NonInventory;
                    PRcptLine."No.":=Line."No.";
                    PRcptLine.Description:=Line.Description;
                    PRcptLine.Quantity:=Line."Qty. to Post";
                    //PRcptLine."From Location Code" := Line."From Location Code";
                    //PRcptLine."From Bin Code" := Line."From Bin Code";
                    PRcptLine."To Location Code":=Line."To Location Code";
                    PRcptLine."To Bin Code":=Line."To Bin Code";
                    //PRcptLine."Customer Lot No." := Line."Customer Lot No.";
                    PRcptLine."Internal Lot No.":=Line."Internal Lot No.";
                    PRcptLine."Serial No.":=Line."Serial No.";
                    PRcptLine."Source Doc. No.":=Line."Document No.";
                    PRcptLine."Source Line No.":=Line."Line No.";
                    PRcptLine.Insert();
                    //if Line.Type = Line.Type::Inventory then 
                    //BinMgt.AddMovement(Line."No.", Line."To Location Code", Line."To Bin Code", Line."Internal Lot No.", Line."Serial No.", Line."Qty. to Post", Line."Document No.", Line."Line No.");
                    if Line.Type = Line.Type::Inventory then begin
                        if Subcon then begin
                            // SUBCON RETURN: Negative at vendor (From), Positive at Lineant (To)
                            PostItemMovement(true, Line."No.", Line."Qty. to Post", Line."From Location Code", Line."From Zone Code", Line."From Bin Code", Line."Internal Lot No.", Line."Serial No.");
                            MirrorBinMovement(false, Line."No.", Line."Qty. to Post", Line."From Location Code", Line."From Zone Code", Line."From Bin Code", Line."Internal Lot No.", Line."Serial No.", Line."Document No.", Line."Line No.");
                            PostItemMovement(false, Line."No.", Line."Qty. to Post", Line."To Location Code", Line."To Zone Code", Line."To Bin Code", Line."Internal Lot No.", Line."Serial No.");
                            MirrorBinMovement(true, Line."No.", Line."Qty. to Post", Line."To Location Code", Line."To Zone Code", Line."To Bin Code", Line."Internal Lot No.", Line."Serial No.", Line."Document No.", Line."Line No.");
                        end
                        else
                        begin
                            // INTERLOCATION two-step: Positive at TO on Receive
                            PostItemMovement(false, Line."No.", Line."Qty. to Post", Line."To Location Code", Line."To Zone Code", Line."To Bin Code", Line."Internal Lot No.", Line."Serial No.");
                            MirrorBinMovement(true, Line."No.", Line."Qty. to Post", Line."To Location Code", Line."To Zone Code", Line."To Bin Code", Line."Internal Lot No.", Line."Serial No.", Line."Document No.", Line."Line No.");
                        end;
                    end
                    else
                    begin
                        // Non-Inventory: TransferIn on RECEIVE
                        Non.Init();
                        Non."Posting Date":=Today;
                        Non."Document No.":=Hdr."No.";
                        Non."Entry Type":=Non."Entry Type"::TransferIn;
                        Non."No.":=Line."No.";
                        Non.Description:=Line.Description;
                        Non.Quantity:=Line."Qty. to Post";
                        Non."Location Code":=Line."To Location Code";
                        Non."Bin Code":=Line."To Bin Code";
                        Non."Internal Lot No.":=Line."Internal Lot No.";
                        Non."Serial No.":=Line."Serial No.";
                        Non."Source Doc. No.":=Line."Document No.";
                        Non."Source Line No.":=Line."Line No.";
                        Non.Insert();
                    end;
                    Line.Validate("Qty. Received", Line."Qty. Received" + Line."Qty. to Post");
                    Line.Validate("Qty. to Post", 0);
                    Line.Modify(true);
                end;
            until Line.Next() = 0;
        Hdr.Status:=Hdr.Status::Received;
        Hdr.Modify(true);
        Message('Transfer Reciept Posted, Document No. %1', hdr."No.");
    end;
}
