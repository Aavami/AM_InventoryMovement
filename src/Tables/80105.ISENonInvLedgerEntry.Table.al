table 80105 "ISE Non-Inv. Ledger Entry"
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
        field(3; "Document No."; Code[20])
        {
        }
        field(4; "Entry Type"; Option)
        {
            OptionMembers = Shipment, Receipt, TransferOut, TransferIn;
        }
        field(5; "No."; Code[20])
        {
            Caption = 'Non-Inventory Code';
        }
        field(6; Description; Text[100])
        {
        }
        field(7; Quantity; Decimal)
        {
        }
        field(8; "Location Code"; Code[10])
        {
        }
        field(9; "Bin Code"; Code[20])
        {
        }
        field(10; "Customer Lot No."; Code[50])
        {
        }
        field(11; "Internal Lot No."; Code[20])
        {
        }
        field(12; "Serial No."; Code[50])
        {
        }
        field(13; "Source Doc. No."; Code[20])
        {
        }
        field(14; "Source Line No."; Integer)
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
