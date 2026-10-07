page 80122 "ISE Receiving Orders"
{
    PageType = List;
    SourceTable = "ISE Customer Order Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    InsertAllowed = false;
    CardPageId = "ISE Receiving Card";
    SourceTableView = WHERE("Ship Alert Approved"=CONST(true)); //, "Receiving Approved" = CONST(false));

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
