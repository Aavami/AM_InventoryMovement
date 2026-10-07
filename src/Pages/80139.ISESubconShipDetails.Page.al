page 80139 "ISE Subcon Ship Details"
{
    PageType = Card;
    SourceTable = "ISE Transfer Header";
    SourceTableView = WHERE("Transfer Type"=CONST(Subcontractor), Status=FILTER(Open|Released));
    ApplicationArea = All;
    Caption = 'Subcontracting - Ship Details';

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
                field("Transfer Type"; Rec."Transfer Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("From Location Code"; Rec."From Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("To Location Code"; Rec."To Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Subcon Vendor Location"; Rec."Subcon Vendor Location")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Lines; "ISE Transfer Lines Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No."=FIELD("No.");
            }
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
                Image = Approvals;

                trigger OnAction()
                begin
                    Rec."Ship Approved":=true;
                    Rec."Ship Approved By":=UserId();
                    Rec."Ship Approved DT":=CurrentDateTime;
                    Rec.Modify(true);
                end;
            }
            action(PostShip)
            {
                Caption = 'Post Ship';
                ApplicationArea = All;

                //Image = PostShipments;
                trigger OnAction()
                var
                    TPM: Codeunit "ISE Transfer Posting Mgt.";
                begin
                    TPM.PostTransferShip(Rec);
                end;
            }
        }
    }
}
