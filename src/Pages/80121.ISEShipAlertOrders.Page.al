page 80121 "ISE Ship Alert Orders"
{
    PageType = List;
    SourceTable = "ISE Customer Order Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    InsertAllowed = false;
    CardPageId = "ISE Ship Alert Card";
    SourceTableView = WHERE("Order Source"=FILTER(Manual|MES), "Ship Alert Required"=CONST(true), "Ship Alert Approved"=CONST(false));

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
