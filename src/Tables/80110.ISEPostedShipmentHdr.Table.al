table 80110 "ISE Posted Shipment Hdr"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Source Doc. No."; Code[20])
        {
        }
        field(3; "Posting Date"; Date)
        {
        }
        field(4; "Customer No."; Code[20])
        {
        }
        field(5; "Customer Name"; Text[100])
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
