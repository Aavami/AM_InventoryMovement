tableextension 80113 "ISE COH Shipping Ext" extends "ISE Customer Order Header"
{
    fields
    {
        field(50100; "Shipping Address 1"; Text[100])
        {
        }
        field(50101; "Shipping Address 2"; Text[100])
        {
        }
        field(50102; "City"; Code[30])
        {
        }
        field(50103; "State"; Code[30])
        {
        }
        field(50104; "Country"; Code[30])
        {
        }
        field(50105; "Contact Person"; Text[100])
        {
        }
        field(50106; "Phone No."; Text[30])
        {
        }
        field(51120; "Shipping Region";Enum "ISE Shipping Region")
        {
            Caption = 'Shipping Region';
            DataClassification = CustomerContent;
        }
        field(51121; "Drop-off Address"; Text[250])
        {
            Caption = 'Drop-off Address';
            DataClassification = CustomerContent;
        }
        field(51122; "Drop-off Contact Person"; Text[100])
        {
            Caption = 'Drop-off Contact Person';
            DataClassification = CustomerContent;
        }
        field(51123; "Drop-off Phone Number"; Text[30])
        {
            Caption = 'Drop-off Phone Number';
            DataClassification = CustomerContent;
        }
        field(51124; "Forwarder Account No."; Code[50])
        {
            Caption = 'Forwarder Account No.';
            DataClassification = CustomerContent;
        }
        field(51125; "Courier Service Level"; Text[50])
        {
            Caption = 'Courier Service Level';
            DataClassification = CustomerContent;
        }
        field(51126; "FedEx Account No."; Code[50])
        {
            Caption = 'FedEx Account No.';
            DataClassification = CustomerContent;
        }
        field(51127; "UPS Account No."; Code[50])
        {
            Caption = 'UPS Account No.';
            DataClassification = CustomerContent;
        }
        field(51128; "DHL Account No."; Code[50])
        {
            Caption = 'DHL Account No.';
            DataClassification = CustomerContent;
        }
        field(51129; "Shipping Contents"; Text[100])
        {
            Caption = 'Shipping Contents';
            DataClassification = CustomerContent;
        }
        field(51130; "Export Reason"; Text[100])
        {
            Caption = 'Export Reason';
            DataClassification = CustomerContent;
        }
        field(51132; Comments; Text[100])
        {
            Caption = 'Comments';
            DataClassification = CustomerContent;
        }
        field(51133; "Packing Slips"; Text[100])
        {
            Caption = 'Comments for Packing Slips';
            DataClassification = CustomerContent;
        }
        field(51134; "Commercial Invoice"; Text[100])
        {
            Caption = 'Comments for Commerical Invoice';
            DataClassification = CustomerContent;
        }
    }
}
