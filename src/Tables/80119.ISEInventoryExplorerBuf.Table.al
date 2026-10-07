table 80119 "ISE Inventory Explorer Buf"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Location Code"; Code[10])
        {
        }
        field(2; "Zone Code"; Code[10])
        {
        }
        field(3; "Bin Code"; Code[20])
        {
        }
        field(4; "Internal Lot No."; Code[20])
        {
        }
        field(5; "Serial No."; Code[50])
        {
        }
        field(6; "On Hand"; Decimal)
        {
        }
    }
    keys
    {
        key(PK; "Location Code", "Zone Code", "Bin Code", "Internal Lot No.", "Serial No.")
        {
            Clustered = true;
        }
    }
}
