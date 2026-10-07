tableextension 80121 VendExn extends Vendor
{
    fields
    {
        field(50900; "Tray Vendor"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Tray Vendor';
        } // Add changes to table fields here
    }
    var myInt: Integer;
}
