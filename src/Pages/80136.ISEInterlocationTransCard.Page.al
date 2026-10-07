page 80136 "ISE Interlocation Trans Card"
{
    PageType = Card;
    SourceTable = "ISE Transfer Header";
    ApplicationArea = All;
    SourceTableView = WHERE("Transfer Type"=CONST(Interlocation));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                field("In-Transit Location Code"; Rec."In-Transit Location Code")
                {
                    ApplicationArea = All;
                }
            }
        //part(Lines; "ISE Transfer Line Subform") { ApplicationArea = All; SubPageLink = "Document No." = FIELD("No."); }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ApproveShip)
            {
                Caption = 'Approve Ship';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec."Ship Approved":=true;
                    Rec."Ship Approved By":=UserId();
                    Rec."Ship Approved DT":=CurrentDateTime;
                    Rec.Modify(true);
                end;
            }
            action(ApproveReceive)
            {
                Caption = 'Approve Receive';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec."Receive Approved":=true;
                    Rec."Receive Approved By":=UserId();
                    Rec."Receive Approved DT":=CurrentDateTime;
                    Rec.Modify(true);
                end;
            }
            action(PostShip)
            {
                Caption = 'Post Ship';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TPM: Codeunit "ISE Transfer Posting Mgt.";
                begin
                    tpm.ValidateHeaderByType(Rec);
                    TPM.PostTransferShip(Rec);
                end;
            }
            action(PostReceive)
            {
                Caption = 'Post Receive';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TPM: Codeunit "ISE Transfer Posting Mgt.";
                begin
                    tpm.ValidateHeaderByType(Rec);
                    TPM.PostTransferReceive(Rec);
                end;
            }
        }
    }
}
