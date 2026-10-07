tableextension 80119 EmployeeExn extends Employee
{
    fields
    {
        field(50900; "Lot Owner"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Lot Owner';
        } // Add changes to table fields here
    }
    var myInt: Integer;
}
