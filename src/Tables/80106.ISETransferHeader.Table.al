table 80106 "ISE Transfer Header"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Transfer Type";Enum "ISE Transfer Type")
        {
        }
        field(3; Status; Option)
        {
            OptionMembers = Open, Released, Shipped, Received;
        }
        field(4; "From Location Code"; Code[10])
        {
            TableRelation = Location.Code;
        }
        field(5; "To Location Code"; Code[10])
        {
            TableRelation = Location.Code;
        }
        field(6; "Courier Method"; Code[30])
        {
        }
        field(7; "Driver/Drop-off"; Text[100])
        {
        }
        field(8; "In-Transit Location Code"; Code[10])
        {
            Caption = 'In-Transit Location (Override)';
            TableRelation = Location.Code where("Use As In-Transit"=const(true));
        }
        field(9; "Subcon Vendor Location"; Code[10])
        {
            Caption = 'Subcon Vendor Location';
            TableRelation = Location.Code;
        }
        field(20; "Ship Approved"; Boolean)
        {
        }
        field(21; "Ship Approved By"; Code[50])
        {
            Editable = false;
        }
        field(22; "Ship Approved DT"; DateTime)
        {
            Editable = false;
        }
        field(23; "Receive Approved"; Boolean)
        {
        }
        field(24; "Receive Approved By"; Code[50])
        {
            Editable = false;
        }
        field(25; "Receive Approved DT"; DateTime)
        {
            Editable = false;
        }
        field(30; "Pending Return"; Boolean)
        {
            Caption = 'Auto-Created Pending Return';
        }
        field(31; "Parent Transfer No."; Code[20])
        {
            Caption = 'Parent Transfer No.';
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    var Setup: Record "ISE Setup";
    NoMgmt: Codeunit "No. Series";
    local procedure GetSetup()
    begin
        if not Setup.Get('SETUP')then begin
            Setup.Init();
            Setup."Primary Key":='SETUP';
            Setup.Insert(true);
        end;
    end;
    local procedure AssignNo()
    var
        Series: Code[20];
        NewNo: Code[20];
    begin
        GetSetup();
        Series:=Setup."Transfer No. Series";
        if Series = '' then Error('Transfer No. Series is not configured in ISE Setup.');
        NewNo:=NoMgmt.GetNextNo(Series, WorkDate(), true);
        "No.":=NewNo;
    end;
    trigger OnInsert()
    begin
        if "No." = '' then AssignNo();
    end;
}
