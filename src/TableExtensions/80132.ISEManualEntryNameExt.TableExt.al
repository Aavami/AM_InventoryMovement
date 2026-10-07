tableextension 80132 "ISE Manual Entry Name Ext" extends "ISE Customer Order Header"
{
    fields
    {
        field(80031; "Vendor/Customer Name"; Text[100])
        {
            Caption = 'Vendor/Customer Name';
            DataClassification = CustomerContent;
        }
    }
}
