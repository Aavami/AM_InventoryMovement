page 80106 "ISE Shipping List"
{
    PageType = List;
    SourceTable = "ISE Customer Order Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "ISE Shipping Card";
    SourceTableView = where("Order Request Type"=const(Shipment));
    Caption = 'ISE Shipping';

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
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Order Source"; Rec."Order Source")
                {
                    ApplicationArea = All;
                }
                field("Delivery Method 2"; Rec."Delivery Method 2")
                {
                    ApplicationArea = All;
                }
                field(Lot; Rec.Lot)
                {
                    ApplicationArea = All;
                }
                field(Tray; Rec.Tray)
                {
                    ApplicationArea = All;
                }
                field(Hardware; Rec.Hardware)
                {
                    ApplicationArea = All;
                }
                field("Ship Alert Approved"; Rec."Ship Alert Approved")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
