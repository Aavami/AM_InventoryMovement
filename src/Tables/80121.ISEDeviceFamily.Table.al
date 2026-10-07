table 80121 "ISE Device Family"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Customer; Code[20])
        {
            Caption = 'Customer';
            TableRelation = Customer."No.";
        }
        field(2; "Device Family"; Code[20])
        {
            Caption = 'Device Family';
        }
        field(3; Active; Boolean)
        {
            Caption = 'Active';
            InitValue = true;
        }
    }
    keys
    {
        key(PK; Customer, "Device Family")
        {
            Clustered = true;
        }
    }
}
