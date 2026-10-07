pageextension 80105 "ISEAuto Lot & Serial" extends "ISE Customer Order Subform"
{
    actions
    {
        addlast(Processing)
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
}
