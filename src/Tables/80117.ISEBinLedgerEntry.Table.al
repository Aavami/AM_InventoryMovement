table 80117 "ISE Bin Ledger Entry"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Item No."; Code[20])
        {
        }
        field(3; "Location Code"; Code[10])
        {
        }
        field(4; "Bin Code"; Code[20])
        {
        }
        field(5; "Internal Lot No."; Code[20])
        {
        }
        field(6; "Serial No."; Code[50])
        {
        }
        field(7; Quantity; Decimal)
        {
        }
        field(8; "Source Doc. No."; Code[20])
        {
        }
        field(9; "Source Line No."; Integer)
        {
        }
        field(10; "Posting Date"; Date)
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
