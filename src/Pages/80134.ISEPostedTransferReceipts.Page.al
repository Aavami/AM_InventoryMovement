page 80134 "ISE Posted Transfer Receipts"
{
    PageType = List;
    SourceTable = "ISE Posted Transfer Recv Hdr";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "ISE Posted Transfer Recv Card";
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(G)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Transfer No."; rec."Source Transfer No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                //field("From Location Code"; rec."From Location Code") { ApplicationArea = All; }
                field("To Location Code"; rec."To Location Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(ViewLines)
            {
                Caption = 'View Lines';
                ApplicationArea = All;
                Image = ViewDetails;

                trigger OnAction()
                var
                    P: Page "ISE Posted Trans-Rcpt Lines";
                    PostedTraRcptLine: Record "ISE Posted Transfer Recv Line";
                begin
                    PostedTraRcptLine.SetFilter("Document No.", rec."No.");
                    P.SetSelectionFilter(PostedTraRcptLine);
                    P.Run();
                end;
            }
        }
    }
}
