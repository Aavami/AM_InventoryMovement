pageextension 80121 "ISE Receiving Card Ext" extends "ISE Receiving Card"
{
    layout
    {
        addlast(General)
        {
            field("Vendor No."; Rec."Vendor No")
            {
                ApplicationArea = All;
                Editable = false;
            }
            //field("Vendor Name"; Rec."Vendor Name") { ApplicationArea = All; Editable = false; }
            field("Sent From Purchase"; Rec."Sent From Purchase")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Tray; Rec.Tray)
            {
                ApplicationArea = All;
            }
            field(Lot; Rec.Lot)
            {
                ApplicationArea = All;
            }
            field(Hardware; Rec.Hardware)
            {
                ApplicationArea = All;
            }
        }
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
                    SigMgt: Codeunit "ISE Signature Mgt";
                begin
                    H.Get(Rec."No.");
                    if not SigMgt.HasSignature(H)then Error('Signature is required before posting.');
                    if not H."Receiving Approved" then begin
                        H.Validate("Receiving Approved", true);
                        H.Validate("Receiving Approved By", UserId());
                        H.Validate("Receiving Approved DT", CurrentDateTime);
                        if H."Order Source" = H."Order Source"::Adhoc then H.Validate("Direction Locked", true);
                        H.Modify(true);
                    end;
                    PM.PostOrder(H);
                end;
            }
        }
    }
}
