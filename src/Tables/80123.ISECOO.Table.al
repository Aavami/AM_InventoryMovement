table 80123 "ISE COO"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; COO; Code[10])
        {
            Caption = 'COO';
        }
        field(2; "COO Code"; Code[10])
        {
            Caption = 'Country';
            TableRelation = "Country/Region".Code;
        }
    }
    keys
    {
        key(PK; COO)
        {
            Clustered = true;
        }
    }
}
