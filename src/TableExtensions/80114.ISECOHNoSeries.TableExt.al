tableextension 80114 "ISE COH No Series" extends "ISE Customer Order Header"
{
    fields
    {
    }
    trigger OnInsert()
    var
        Setup: Record "ISE Setup";
        NoSeries: Codeunit "No. Series";
    begin
        if Rec."No." <> '' then exit;
        if not Setup.Get('SETUP')then Error('ISE Setup not configured');
        if Setup."Order No. Series" = '' then Error('Order No. Series not configured');
        Rec."No.":=NoSeries.GetNextNo(Setup."Order No. Series", WorkDate(), true);
    end;
}
