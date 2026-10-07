page 80115 "ISE Adhoc Orders"
{
    PageType = List;
    SourceTable = "ISE Customer Order Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "ISE Adhoc Entry Card";
    SourceTableView = WHERE("Order Source"=CONST(Adhoc));

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
