tableextension 80126 "ISE Posted Rcpt Line Ext" extends "ISE Posted Receipt Line"
{
    fields
    {
        field(70320; Reversed; Boolean)
        {
            Caption = 'Reversed';
        }
        field(70321; "From Location Code"; Code[20])
        {
        }
    }
}
