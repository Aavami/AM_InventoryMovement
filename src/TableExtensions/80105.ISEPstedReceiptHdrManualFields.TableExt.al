tableextension 80105 "ISEPstedReceiptHdrManualFields" extends "ISE Posted Receipt Hdr"
{
    fields
    {
        field(50900; "Vendor/Customer";Enum "ISE Vendor/Customer Type")
        {
            DataClassification = CustomerContent;
        }
        field(50901; "Customer/Vendor No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50902; "Sender Company Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50903; "Requestor/Sender Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50904; "Recipient/Attention To"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50905; "Number of Packages"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50906; "ISE Destination Location";Enum "ISE Destination Location")
        {
            DataClassification = CustomerContent;
        }
        field(50910; "Delivery Method";Enum "ISE Delivery Method")
        {
            DataClassification = CustomerContent;
        }
        field(50911; "Courier/Forwarder Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50912; "Air Way Bill (AWB)"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50913; "Expected Date Time"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(50914; "Pick up Address"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(50915; "Pick up Contact Person"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50916; "Contact Phone Number"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50917; "Special Instructions"; Text[2048])
        {
            DataClassification = CustomerContent;
        }
        field(50918; "Behalf of Customer"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50920; "Package Hardware"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50921; "Package Lot"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50922; "Package Tray"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50923; "Package Other"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50930; Information; Text[2048])
        {
            DataClassification = CustomerContent;
        }
    }
}
