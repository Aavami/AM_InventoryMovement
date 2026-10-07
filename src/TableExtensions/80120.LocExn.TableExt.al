tableextension 80120 LocExn extends Location
{
    fields
    {
        field(50900; "ISE Facility"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'ISE Facility';
        } // Add changes to table fields here
        field(50901; "ISE Staging Location"; Boolean)
        {
            Caption = 'ISE Staging Location';
            DataClassification = CustomerContent;
        }
    }
    var myInt: Integer;
}
