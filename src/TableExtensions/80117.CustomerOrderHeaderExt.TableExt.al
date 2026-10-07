tableextension 80117 "Customer Order Header Ext" extends "ISE Customer Order Header"
{
    fields
    {
        // --- Ship Alter capture fields ---
        field(75000; "No. of Boxes"; Integer)
        {
            Caption = 'No. of Boxes';
            DataClassification = CustomerContent;
        }
        field(75001; "No. of Cartons"; Integer)
        {
            Caption = 'No. of Cartons';
            DataClassification = CustomerContent;
        }
        field(75002; "Dispatch Date"; Date)
        {
            Caption = 'Dispatch Date';
            DataClassification = CustomerContent;
        }
        field(75003; "Tracking Number"; Code[50])
        {
            Caption = 'Tracking Number';
            DataClassification = CustomerContent;
        }
        field(75004; "Shipped By"; Text[50])
        {
            Caption = 'Shipped By';
            DataClassification = CustomerContent;
        }
        field(75005; "Contact Details"; Text[100])
        {
            Caption = 'Contact Details';
            DataClassification = CustomerContent;
        }
        // --- Flow control flags ---
        field(75011; "Skip Ship Alert"; Boolean)
        {
            Caption = 'Skip Ship Alert';
            DataClassification = SystemMetadata;
        }
        field(75012; "Ship Alter Done"; Boolean)
        {
            Caption = 'Ship Alter Done';
            DataClassification = SystemMetadata;
        }
        field(75013; "Sent To PM"; Boolean)
        {
            Caption = 'Sent To PM';
            DataClassification = SystemMetadata;
        }
        field(75014; "PM Order"; Boolean)
        {
            Caption = 'PM Order';
            DataClassification = SystemMetadata;
        }
        field(75015; "Ship Alert Approved"; Boolean)
        {
            Caption = 'Ship Alert Approved';
            DataClassification = SystemMetadata;
        }
        field(75016; Stage;Enum "ISE Stage")
        {
            Caption = 'Ship Stage';
            DataClassification = SystemMetadata;
        }
        // If your header does not already have an Order Type field, uncomment below to add it
        // field(75010; "Order Type"; Enum "ISE Order Type")
        // {
        //     Caption = 'Order Type';
        //     DataClassification = CustomerContent;
        // }
        Modify("Order Source")
        {
        trigger OnAfterValidate()
        var
            OT: Enum "ISE Order Source";
        begin
            OT:=rec."Order Source";
            // When PM sets Manual/MES: enforce bypass of Ship Alert
            if(OT in[OT::Manual, OT::MES])then begin
                Rec."Skip Ship Alert":=true;
                Rec."PM Order":=true;
            end;
        end;
        }
    }
}
