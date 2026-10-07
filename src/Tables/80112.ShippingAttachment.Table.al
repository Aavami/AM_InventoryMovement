table 80112 "Shipping Attachment"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Order No."; Code[20])
        {
        }
        field(3; "File Name"; Text[250])
        {
        }
        field(4; "File Content"; Blob)
        {
            SubType = Memo;
        }
        field(5; "Attached By"; Code[50])
        {
        }
        field(6; "Attached On"; DateTime)
        {
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
