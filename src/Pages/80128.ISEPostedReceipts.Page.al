page 80128 "ISE Posted Receipts"
{
    PageType = List;
    SourceTable = "ISE Posted Receipt Hdr";
    ApplicationArea = All;
    UsageCategory = Lists;

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
                field("Source Doc. No."; rec."Source Doc. No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field(Reopened; rec.Reopened)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Reopen)
            {
                ApplicationArea = All;
                Image = ReOpen;

                trigger OnAction()
                var
                    M: Codeunit "ISE Undo Receipt Mgt";
                begin
                    M.Reopen(Rec);
                end;
            }
            action(Undo)
            {
                ApplicationArea = All;
                Image = Undo;

                trigger OnAction()
                var
                    M: Codeunit "ISE Undo Receipt Mgt";
                begin
                    M.Undo(Rec);
                end;
            }
        }
    }
}
