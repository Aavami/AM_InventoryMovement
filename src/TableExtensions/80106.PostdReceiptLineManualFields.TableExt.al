tableextension 80106 "PostdReceiptLineManualFields" extends "ISE Posted Receipt Line"
{
    fields
    {
        field(50900; "Manual Line Type";Enum "ISE Manual Line Type")
        {
            DataClassification = CustomerContent;
        }
        field(50901; "Lot#"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(50902; "Customer Lot"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(50903; DeviceName; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50904; Expedite; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50905; "IQA Optional"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50906; "Lot Owner"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50907; "Date Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50908; COO; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(50909; Hold; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50910; "HW Details"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50911; "Tray Vendor"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50912; "Tray Part"; Text[50])
        {
            DataClassification = CustomerContent;
        }
    }
}
