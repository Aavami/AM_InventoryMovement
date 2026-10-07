page 80104 "ISE Harware Lines"
{
    PageType = ListPart;
    SourceTable = "ISE Customer Order Line";
    ApplicationArea = All;
    // Filter only Lot lines
    SourceTableView = where("Manual Line Type"=const(Hardware));

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
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field("HW Details"; Rec."HW Details")
                {
                    ApplicationArea = All;
                }
                field(DeviceName; Rec.DeviceName)
                {
                    ApplicationArea = All;
                    Caption = 'Device Name';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Expected Quantity';
                }
                field("Qty. Received"; Rec."Qty. Received")
                {
                    ApplicationArea = All;
                    Caption = 'Recieved Quantity';
                    Editable = false;
                }
                field(Hold; Rec.Hold)
                {
                    ApplicationArea = All;
                }
                field("Hold Comment"; Rec."Hold Comment")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            /* action(AssignLotNos)
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
 */
            action(AssignSerialNos)
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
            }
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
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        LineNoMgt: Codeunit "ISE Line No. Mgt.";
    begin
        // Document No. will come from SubPageLink; keep it safe:
        if Rec."Document No." = '' then Rec."Document No.":=xRec."Document No.";
        Rec.Type:=Rec.Type::NonInventory;
        Rec.Validate("Manual Line Type", Rec."Manual Line Type"::Hardware);
        Rec."Line No.":=LineNoMgt.GetNextLineNo(Rec."Document No.");
    end;
    var CustLot: Boolean;
    trigger OnAfterGetRecord()
    var
        CustHeader: Record "ISE Customer Order Header";
    begin
        CustHeader.Reset();
        CustHeader.SetRange(CustHeader."No.", Rec."Document No.");
        if CustHeader.FindFirst()then;
    end;
}
