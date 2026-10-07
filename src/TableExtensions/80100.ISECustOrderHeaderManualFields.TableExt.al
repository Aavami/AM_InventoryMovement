tableextension 80100 "ISECustOrderHeaderManualFields" extends "ISE Customer Order Header"
{
    fields
    {
        // GENERAL
        field(50900; "Vendor/Customer";Enum "ISE Vendor/Customer Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor/Customer';

            trigger OnValidate()
            begin
                // When switching to Customer, clear vendor-specific fields
                if xRec."Vendor/Customer" <> Rec."Vendor/Customer" then begin
                    Rec.Validate("Customer/Vendor No.", '');
                    rec.Validate("Vendor No", '');
                end;
                if Rec."Vendor/Customer" = Rec."Vendor/Customer"::Customer then begin
                    Rec."Behalf of Customer":='';
                end;
                // Re-apply Party No mapping into base Customer No when applicable
                SyncPartyNoToBase();
            end;
        }
        // Unified Customer/Vendor No
        field(50901; "Customer/Vendor No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer/Vendor No.';
            TableRelation = if("Vendor/Customer"=const(Vendor))"ISE Vendor"."No."
            else if("Vendor/Customer"=const(Customer))Customer."No.";

            trigger OnValidate()
            begin
                SyncPartyNoToBase();
            end;
        }
        field(50902; "Sender Company Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Sender Company Name';
        }
        field(50903; "Requestor/Sender Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Requestor / Sender Name';
        }
        field(50904; "Recipient/Attention To"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Recipient / Attention To';
            TableRelation = Employee."No.";
        }
        field(50905; "Number of Packages"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Number of Packages';
        }
        field(50906; "ISE Destination Location";Enum "ISE Destination Location")
        {
            DataClassification = CustomerContent;
            Caption = 'ISE Destination Location';
            TableRelation = Location.Code; //where("ISE Facility" = const(true));
        } //Dont use
        field(50907; "ISE Destination Locations"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'ISE Destination Location';
            TableRelation = Location.Code where("ISE Facility"=const(true));
        }
        // Delivery Method + courier/pickup fields
        field(50910; "Delivery Method 2";Enum "ISE Delivery Method")
        {
            DataClassification = CustomerContent;
            Caption = 'Delivery Method';
        }
        field(50911; "Courier/Forwarder Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Courier/Forwarder Name';
        }
        field(50912; "Air Way Bill (AWB)"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Air Way Bill (AWB)';
        }
        field(50913; "Expected Date Time"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Expected Date / Time of Arrival / Pick Up';
        }
        field(50914; "Pick up Address"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Pick up Address';
        }
        field(50915; "Pick up Contact Person"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Pick up Contact Person';
        }
        field(50916; "Contact Phone Number"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact Phone Number';
        }
        field(50917; "Special Instructions"; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'Special Instructions';
        }
        // Behalf of Customer - editable only if Vendor
        field(50918; "Behalf of Customer"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Behalf of Customer';
            TableRelation = Customer."No.";
        }
        // Package Category (multi-select)
        field(50920; "Package Hardware"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Hardware';
        }
        field(50921; "Package Lot"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Lot';
        }
        field(50922; "Package Tray"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Tray';
        }
        field(50923; "Package Other"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Other';
        }
        // Information (multiline) - reuse Notes. Keep a dedicated field to avoid clash with existing Notes label.
        field(50930; Information; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'Information';
        }
        field(50931; Notes; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'Notes';
        }
        field(50932; Tray; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50933; Lot; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50934; Hardware; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }
    local procedure SyncPartyNoToBase()
    begin
        // For Customer type, keep base Customer No. in sync for existing flows
        if Rec."Vendor/Customer" = Rec."Vendor/Customer"::Customer then Rec.Validate("Customer No.", Rec."Customer/Vendor No.")
        else
            // For Vendor type, clear base Customer No. (Behalf of Customer will represent the end customer)
            Rec."Customer No.":='';
    end;
}
