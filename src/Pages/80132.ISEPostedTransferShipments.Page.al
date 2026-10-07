page 80132 "ISE Posted Transfer Shipments"
{
    PageType = List;
    SourceTable = "ISE Posted Transfer Ship Hdr";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "ISE Posted Transfer Ship Card";
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
                field("From Location Code"; rec."From Location Code")
                {
                    ApplicationArea = All;
                }
            //field("To Location Code"; rec."To Location Code") { ApplicationArea = All; }
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
                    P: Page "ISE Posted Trans-Ship Lines";
                    PostedTraShptLine: Record "ISE Posted Transfer Ship Line";
                begin
                    PostedTraShptLine.SetFilter("Document No.", Rec."No.");
                    ;
                    P.SetSelectionFilter(PostedTraShptLine);
                    P.Run();
                end;
            }
        }
    }
}
