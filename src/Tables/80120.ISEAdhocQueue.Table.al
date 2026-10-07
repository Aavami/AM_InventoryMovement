table 80120 "ISE Adhoc Queue"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Source No."; Code[20])
        {
        }
        field(3; Status; Option)
        {
            OptionMembers = Pending, Processing, Done, Error;
        }
        field(4; "Last Error"; Text[250])
        {
        }
        field(5; "Inserted At"; DateTime)
        {
        }
        field(6; "Processed At"; DateTime)
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
