page 80127 "ISE Subcontractor Transfers"
{
    PageType = List;
    SourceTable = "ISE Transfer Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "ISE Subcontractor Trans Card";
    SourceTableView = WHERE("Transfer Type"=CONST(Subcontractor));

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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("From Location Code"; Rec."From Location Code")
                {
                    ApplicationArea = All;
                }
                field("To Location Code"; Rec."To Location Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
