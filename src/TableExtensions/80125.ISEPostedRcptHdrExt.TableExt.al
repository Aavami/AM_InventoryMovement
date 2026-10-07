tableextension 80125 "ISE Posted Rcpt Hdr Ext" extends "ISE Posted Receipt Hdr"
{
    fields
    {
        field(70320; Reopened; Boolean)
        {
            Caption = 'Reopened';
        }
        field(70321; "From Location Code"; Code[20])
        {
        }
        field(70322; "Transfer No."; Code[20])
        {
        }
    }
}
