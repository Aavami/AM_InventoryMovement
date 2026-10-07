table 80100 "ISE Vendor"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; Name; Text[100])
        {
        }
        field(3; Address; Text[100])
        {
        }
        field(4; "Address 2"; Text[100])
        {
        }
        field(5; City; Text[30])
        {
        }
        field(6; "Post Code"; Code[20])
        {
        }
        field(7; Country; Code[10])
        {
        }
        field(8; Phone; Text[30])
        {
        }
        field(9; Email; Text[80])
        {
        }
        field(50; "Source Vendor No."; Code[20])
        {
        }
        field(51; "Tray Vendor"; Boolean)
        {
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(ByVendor; "Source Vendor No.")
        {
        }
    }
}
