tableextension 80118 ItemExn extends Item
{
    fields
    {
        field(50900; "Manual Line Type";Enum "ISE Manual Line Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Goods Type';
        } // Add changes to table fields here
    }
    var myInt: Integer;
}
