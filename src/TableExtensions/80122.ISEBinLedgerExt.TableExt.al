tableextension 80122 "ISE Bin Ledger Ext" extends "ISE Bin Ledger Entry"
{
    fields
    {
        field(50000; "Zone Code"; Code[10])
        {
            Caption = 'Zone Code';
            DataClassification = CustomerContent;
        }
    }
}
