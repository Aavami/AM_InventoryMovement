page 80108 "ISE Posted Shipment List"
{
    PageType = List;
    SourceTable = "ISE Posted Shipment Hdr";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Posted Shipments';
    CardPageId = "ISE Posted Shipment Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Source Doc. No."; Rec."Source Doc. No.")
                {
                    ApplicationArea = All;
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
        }
    }
}
