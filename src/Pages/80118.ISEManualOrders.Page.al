page 80118 "ISE Manual Orders"
{
    PageType = List;
    SourceTable = "ISE Customer Order Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "ISE Manual Entry Card";
    Caption = 'Ship Alerts';
    SourceTableView = WHERE("Order Source"=CONST(Manual), Lot=const(true), Tray=const(false), Hardware=const(false));

    layout
    {
        area(content)
        {
            repeater(G)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Order Request Type"; Rec."Order Request Type")
                {
                    ApplicationArea = All;
                }
                field("Ship Alert Approved"; Rec."Ship Alert Approved")
                {
                    ApplicationArea = All;
                }
                field("Receiving Approved"; Rec."Receiving Approved")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
