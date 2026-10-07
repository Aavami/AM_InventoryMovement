table 80118 "ISE Combined Movement Buf"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Posting Date"; Date)
        {
        }
        field(3; "Movement Source"; Option)
        {
            OptionMembers = Inventory, NonInventory;
        }
        field(4; "Document No."; Code[20])
        {
        }
        field(5; "Line No."; Integer)
        {
        }
        field(6; "No."; Code[20])
        {
            Caption = 'Item/Code';
        }
        field(7; Description; Text[100])
        {
        }
        field(8; "Location Code"; Code[10])
        {
        }
        field(9; "Bin Code"; Code[20])
        {
        }
        field(10; "Internal Lot No."; Code[20])
        {
        }
        field(11; "Serial No."; Code[50])
        {
        }
        field(12; Quantity; Decimal)
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
