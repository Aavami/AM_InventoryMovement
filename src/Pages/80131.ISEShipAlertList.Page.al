page 80131 "ISE Ship Alert List"
{
    PageType = List;
    SourceTable = "ISE Customer Order Header";
    Caption = 'Mail Room';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "ISE Ship Alert Card New";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Order Type"; rec."Order Source")
                {
                    ApplicationArea = All;
                }
                field("Ship Alert Approved"; rec."Ship Alert Approved")
                {
                    ApplicationArea = All;
                }
                field("Dispatch Date"; rec."Dispatch Date")
                {
                    ApplicationArea = All;
                }
                field("Tracking Number"; rec."Tracking Number")
                {
                    ApplicationArea = All;
                }
                field("Customer Hardware No."; Rec."Customer Hardware No.")
                {
                    ToolTip = 'Specifies the value of the Customer Hardware No. field.', Comment = '%';
                }
                field("Customer Lot No."; Rec."Customer Lot No.")
                {
                    ToolTip = 'Specifies the value of the Customer Lot No. field.', Comment = '%';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.', Comment = '%';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                }
                field("Delivery Method"; Rec."Delivery Method")
                {
                    ToolTip = 'Specifies the value of the Delivery Method field.', Comment = '%';
                }
                field("Direction Locked"; Rec."Direction Locked")
                {
                    ToolTip = 'Specifies the value of the Direction Locked (after stage approval) field.', Comment = '%';
                }
                field("Internal Lot No."; Rec."Internal Lot No.")
                {
                    ToolTip = 'Specifies the value of the Internal Lot No. field.', Comment = '%';
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Location field.', Comment = '%';
                }
                field("Order Request Type"; Rec."Order Request Type")
                {
                    ToolTip = 'Specifies the value of the Order Request Type (Shipment/Receipt) field.', Comment = '%';
                }
                field("Order Source"; Rec."Order Source")
                {
                    ToolTip = 'Specifies the value of the Order Source field.', Comment = '%';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies the value of the Payment Terms Code field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field("Receiving Approved"; Rec."Receiving Approved")
                {
                    ToolTip = 'Specifies the value of the Receiving Approved field.', Comment = '%';
                }
                field("Receiving Approved By"; Rec."Receiving Approved By")
                {
                    ToolTip = 'Specifies the value of the Receiving Approved By field.', Comment = '%';
                }
                field("Receiving Approved DT"; Rec."Receiving Approved DT")
                {
                    ToolTip = 'Specifies the value of the Receiving Approved DT field.', Comment = '%';
                }
                field("Receiving Notes"; Rec."Receiving Notes")
                {
                    ToolTip = 'Specifies the value of the Receiving Notes field.', Comment = '%';
                }
                field("Ship Alert Approved By"; Rec."Ship Alert Approved By")
                {
                    ToolTip = 'Specifies the value of the Ship Alert Approved By field.', Comment = '%';
                }
                field("Ship Alert Approved DT"; Rec."Ship Alert Approved DT")
                {
                    ToolTip = 'Specifies the value of the Ship Alert Approved DT field.', Comment = '%';
                }
                field("Ship Alert Cartons"; Rec."Ship Alert Cartons")
                {
                    ToolTip = 'Specifies the value of the Ship Alert Cartons field.', Comment = '%';
                }
                field("Ship Alert Courier"; Rec."Ship Alert Courier")
                {
                    ToolTip = 'Specifies the value of the Ship Alert Courier field.', Comment = '%';
                }
                field("Ship Alert Driver"; Rec."Ship Alert Driver")
                {
                    ToolTip = 'Specifies the value of the Driver/Drop-off field.', Comment = '%';
                }
                field("Ship Alert Nature"; Rec."Ship Alert Nature")
                {
                    ToolTip = 'Specifies the value of the Ship Alert Nature field.', Comment = '%';
                }
                field("Ship Alert Notes"; Rec."Ship Alert Notes")
                {
                    ToolTip = 'Specifies the value of the Ship Alert Notes field.', Comment = '%';
                }
                field("Ship Alert Required"; Rec."Ship Alert Required")
                {
                    ToolTip = 'Specifies the value of the Ship Alert Required field.', Comment = '%';
                }
                field("Ship Alert Type"; Rec."Ship Alert Type")
                {
                    ToolTip = 'Specifies the value of the Ship Alert Type field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(OpenCard)
            {
                Caption = 'Open';
                ApplicationArea = All;
                RunObject = page "ISE Ship Alert Card New";
                RunPageLink = "No."=field("No.");
            }
        }
    }
    trigger OnOpenPage()
    begin
        if rec.FieldNo(rec."Order Source") <> 0 then rec.SetFilter(rec."Order Source", '%1|%2', rec."Order Source"::Manual, rec."Order Source"::MES);
    //if rec.FieldNo("Skip Ship Alert") <> 0 then
    //  rec.SetRange("Skip Ship Alert", false);
    //if rec.FieldNo("Stage") <> 0 then
    //  rec.SetRange("Stage", Rec."Stage"::ShipAlert);
    end;
}
