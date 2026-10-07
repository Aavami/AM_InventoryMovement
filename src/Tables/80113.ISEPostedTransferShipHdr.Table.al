table 80113 "ISE Posted Transfer Ship Hdr"
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
        field(4; "From Location Code"; Code[10])
        {
        }
        field(5; "In-Transit Location Code"; Code[10])
        {
        }
        field(6; "Transfer Type";Enum "ISE Transfer Type")
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
