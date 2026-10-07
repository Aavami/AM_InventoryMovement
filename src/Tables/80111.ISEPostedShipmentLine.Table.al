table 80111 "ISE Posted Shipment Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; Type; Option)
        {
            OptionMembers = Inventory, NonInventory;
        }
        field(4; "No."; Code[20])
        {
        }
        field(5; Description; Text[100])
        {
        }
        field(6; Quantity; Decimal)
        {
        }
        field(7; "Location Code"; Code[10])
        {
        }
        field(8; "Bin Code"; Code[20])
        {
        }
        field(9; "Customer Lot No."; Code[50])
        {
        }
        field(10; "Internal Lot No."; Code[50])
        {
        }
        field(11; "Serial No."; Code[50])
        {
        }
        field(12; "Source Doc. No."; Code[20])
        {
        }
        field(13; "Source Line No."; Integer)
        {
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
