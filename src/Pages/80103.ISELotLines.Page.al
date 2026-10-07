page 80103 "ISE Lot Lines"
{
    PageType = ListPart;
    SourceTable = "ISE Customer Order Line";
    ApplicationArea = All;
    // Filter only Lot lines
    SourceTableView = where("Manual Line Type"=const(Lot));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Post"; Rec."Qty. to Post")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Internal Lot No."; Rec."Internal Lot No.")
                {
                    ApplicationArea = All;
                    Caption = 'ISE Lot No.';
                }
                field("Customer Lot No."; Rec."Customer Lot No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Expected Quantity';
                }
                field(DeviceName; Rec.DeviceName)
                {
                    ApplicationArea = All;
                    Caption = 'Device Name';
                }
                field(Expedite; Rec.Expedite)
                {
                    ApplicationArea = All;
                }
                field("IQA Optional"; Rec."IQA Optional")
                {
                    ApplicationArea = All;
                }
                field("Lot Owner"; Rec."Lot Owner")
                {
                    ApplicationArea = All;
                }
                field("Date Code"; Rec."Date Code")
                {
                    ApplicationArea = All;
                    Caption = 'Date Code COO';
                    Editable = Shipalert;
                }
                field(COO; Rec.COO)
                {
                    ApplicationArea = All;
                    Editable = Shipalert;
                }
                field(Hold; Rec.Hold)
                {
                    ApplicationArea = All;
                    Editable = Shipalert;
                }
                field("Hold Comment"; Rec."Hold Comment")
                {
                    ApplicationArea = All;
                    Editable = Shipalert;
                }
                field("Qty. Received"; Rec."Qty. Received")
                {
                    ApplicationArea = All;
                    Caption = 'Recieved Quantity';
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(AssignLotNos)
            {
                Caption = 'Assign Lot Nos';
                ApplicationArea = All;
                Image = NewSerialNoProperties;

                trigger OnAction()
                var
                    SelLines: Record "ISE Customer Order Line";
                begin
                    CurrPage.SetSelectionFilter(SelLines);
                    AssignNosToLines(SelLines, true, false);
                end;
            }
        /* action(AssignSerialNos)
            {
                Caption = 'Assign Serial Nos';
                ApplicationArea = All;
                Image = NewSerialNoProperties;

                trigger OnAction()
                var
                    SelLines: Record "ISE Customer Order Line";
                begin
                    CurrPage.SetSelectionFilter(SelLines);
                    AssignNosToLines(SelLines, false, true);
                end;
            } */
        }
    }
    local procedure AssignNosToLines(var Lines: Record "ISE Customer Order Line"; DoLot: Boolean; DoSerial: Boolean)
    var
        Setup: Record "ISE Setup";
        NoSeries: Codeunit "No. Series";
        LotSeries: Code[20];
        SerialSeries: Code[20];
        NewNo: Code[20];
    begin
        EnsureSetup(Setup);
        LotSeries:=Setup."Internal Lot No. Series";
        SerialSeries:=Setup."Serial No. Series";
        if DoLot and (LotSeries = '')then Error('Internal Lot No. Series is not configured in ISE Setup.');
        if DoSerial and (SerialSeries = '')then Error('Internal Serial No. Series is not configured in ISE Setup.');
        if Lines.FindSet(true)then repeat if DoLot then begin
                    if Lines."Internal Lot No." = '' then begin
                        NewNo:=NoSeries.GetNextNo(LotSeries, WorkDate(), true);
                        Lines.Validate("Internal Lot No.", NewNo);
                    end;
                end;
                if DoSerial then begin
                    if Lines."Serial No." = '' then begin
                        NewNo:=NoSeries.GetNextNo(SerialSeries, WorkDate(), true);
                        Lines.Validate("Serial No.", NewNo);
                    end;
                end;
                Lines.Modify(true);
            until Lines.Next() = 0;
    end;
    local procedure EnsureSetup(var Setup: Record "ISE Setup")
    begin
        if not Setup.Get('SETUP')then begin
            Setup.Init();
            Setup."Primary Key":='SETUP';
            Setup.Insert(true);
        end;
    end;
    var Shipalert: Boolean;
    CustOrder: Record "ISE Customer Order Header";
    local procedure SetShipFlags()
    begin
        Shipalert:=true;
        if CustOrder.get(Rec."Document No.")then if CustOrder.Stage = CustOrder.Stage::ShipAlert then Shipalert:=false;
        CurrPage.Update(false);
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        LineNoMgt: Codeunit "ISE Line No. Mgt.";
        CustOrder: Record "ISE Customer Order Header";
    begin
        // Document No. will come from SubPageLink; keep it safe:
        if Rec."Document No." = '' then Rec."Document No.":=xRec."Document No.";
        Rec.Type:=Rec.Type::NonInventory;
        Rec.Validate("Manual Line Type", Rec."Manual Line Type"::Lot);
        Rec."Line No.":=LineNoMgt.GetNextLineNo(Rec."Document No.");
        if CustOrder.get(Rec."Document No.")then Rec."Location Code":=CustOrder."ISE Destination Locations";
    end;
    var CustLot: Boolean;
    trigger OnAfterGetRecord()
    var
        CustHeader: Record "ISE Customer Order Header";
    begin
        CustHeader.Reset();
        CustHeader.SetRange(CustHeader."No.", Rec."Document No.");
        if CustHeader.FindFirst()then begin
            Custlot:=false;
            Rec."Location Code":=CustHeader."ISE Destination Locations";
        end;
        SetShipFlags();
    end;
}
