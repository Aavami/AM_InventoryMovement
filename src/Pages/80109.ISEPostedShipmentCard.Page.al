page 80109 "ISE Posted Shipment Card"
{
    PageType = Document;
    SourceTable = "ISE Posted Shipment Hdr";
    ApplicationArea = All;
    Caption = 'Posted Shipment';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Source Doc. No."; Rec."Source Doc. No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
            }
            group(Lines)
            {
                part(PostedShipmentLines; "ISE Posted Shipment Subform")
                {
                    ApplicationArea = All;
                    SubPageLink = "Document No."=field("No.");
                }
            }
        }
    }
}
