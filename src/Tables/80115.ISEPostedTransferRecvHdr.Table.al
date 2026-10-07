table 80115 "ISE Posted Transfer Recv Hdr"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Source Transfer No."; Code[20])
        {
        }
        field(3; "Posting Date"; Date)
        {
        }
        field(4; "To Location Code"; Code[10])
        {
        }
        field(5; "Transfer Type";Enum "ISE Transfer Type")
        {
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
