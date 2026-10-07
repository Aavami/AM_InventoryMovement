pageextension 80122 "ISE ShipAlert Card Ext" extends "ISE Ship Alert Card"
{
    layout
    {
        addfirst(FactBoxes)
        {
            part(DocAttach; "Doc. Attachment List Factbox")
            {
                Caption = 'Attachments';
                ApplicationArea = All;
                SubPageLink = "Table ID"=CONST(80103), "No."=FIELD("No.");
            }
            systempart(Notes; Notes)
            {
                Caption = 'Notes';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addfirst(Processing)
        {
            action(ApproveAndPost)
            {
                Caption = 'Approve & Post';
                ApplicationArea = All;
                Image = Post;

                trigger OnAction()
                var
                    PM: Codeunit "ISE Posting Mgt.";
                    H: Record "ISE Customer Order Header";
                begin
                    H.Get(Rec."No.");
                    if not H."Ship Alert Approved" then begin
                        H.Validate("Ship Alert Approved", true);
                        H.Validate("Ship Alert Approved By", UserId());
                        H.Validate("Ship Alert Approved DT", CurrentDateTime);
                        H.Validate("Direction Locked", true);
                        H.Modify(true);
                    end;
                    if not H."Receiving Approved" then begin
                        H.Validate("Receiving Approved", true);
                        H.Validate("Receiving Approved By", UserId());
                        H.Validate("Receiving Approved DT", CurrentDateTime);
                        H.Modify(true);
                    end;
                    PM.PostOrder(H);
                end;
            }
        }
    }
}
