table 80122 "ISE Device"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Customer; Code[20])
        {
            Caption = 'Customer';
            TableRelation = Customer."No.";
        }
        field(2; "Device Family"; Code[20])
        {
            Caption = 'Device Family';
            TableRelation = "ISE Device Family"."Device Family" where(Customer=field(Customer), Active=const(true));
        }
        field(3; Device; Code[20])
        {
            Caption = 'Device';
            NotBlank = true;
        }
        field(4; "Lot Type"; Code[20])
        {
            Caption = 'Lot Type';
        }
        field(5; "Tray/Tube Mapping"; Code[20])
        {
            Caption = 'Tray/Tube Mapping';
        }
        field(6; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            DecimalPlaces = 0: 5;
        }
        field(7; COO; Code[10])
        {
            Caption = 'Country of Origin';
            TableRelation = "ISE COO".COO;
        }
    }
    keys
    {
        key(PK; Customer, Device)
        {
            Clustered = true;
        }
    }
}
