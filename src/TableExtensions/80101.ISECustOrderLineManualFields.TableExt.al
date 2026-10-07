tableextension 80101 "ISECustOrderLineManualFields" extends "ISE Customer Order Line"
{
    fields
    {
        field(50900; "Manual Line Type";Enum "ISE Manual Line Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Goods Type';
        }
        // LOT
        field(50901; "Lot#"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Lot#';
        }
        field(50902; "Customer Lot#"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'CustomerLot#';
        }
        field(50903; DeviceName; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'DeviceName';
        }
        field(50904; Expedite; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Expedite';
        }
        field(50905; "IQA Optional"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'IQA Optional';
        }
        field(50906; "Lot Owner"; Code[20])
        {
            TableRelation = Employee."No." where("Lot Owner"=const(true));
            DataClassification = CustomerContent;
            Caption = 'Lot Owner';
        }
        field(50907; "Date Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Date Code';
        }
        field(50908; COO; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'COO';
        }
        field(50909; Hold; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Hold';
        }
        // HARDWARE / TRAY
        field(50910; "HW Details"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'HW Details';
        }
        field(50911; "Tray Vendor"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Tray Vendor';
        }
        field(50912; "Tray Part#"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Tray Part#';
        }
        field(50913; Status; Option)
        {
            OptionMembers = Open, Released, Closed;
        }
        field(50914; "Attribute 1"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50915; "Attribute 2"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50916; "Attribute 3"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        modify("No.")
        {
        TableRelation = if(Type=const(NonInventory))Item."No." where(Type=const("Non-Inventory"), "Manual Line Type"=field("Manual Line Type"))
        else
        item."No." where(Type=const("Inventory"));
        }
    }
}
