table 80101 "ISE Delivery Method Code"
{
    Caption = 'ISE Delivery Method Code';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Delivery Method 2";Enum "ISE Delivery Method")
        {
            Caption = 'Delivery Method';
        }
        field(2; Code; Code[20])
        {
            Caption = 'Code';
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Delivery Method 2", Code)
        {
            Clustered = true;
        }
    }
}
