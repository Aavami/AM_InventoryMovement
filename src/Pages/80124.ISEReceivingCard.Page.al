page 80124 "ISE Receiving Card"
{
    PageType = Card;
    SourceTable = "ISE Customer Order Header";
    ApplicationArea = All;
    Caption = 'ISE Receiving';

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
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Order Source"; Rec."Order Source")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Order Request Type"; Rec."Order Request Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Receiving Status"; Rec."Receiving Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = ReceivingStatusStyle;
                }
                field("Receiving Released By"; Rec."Receiving Released By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Receiving Released DT"; Rec."Receiving Released DT")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Receiving")
            {
                field("Receiving Notes"; Rec."Receiving Notes")
                {
                    ApplicationArea = All;
                }
                field("Receiving Approved"; Rec."Receiving Approved")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Receiving Approved By"; Rec."Receiving Approved By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Receiving Approved DT"; Rec."Receiving Approved DT")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            //part(Lines; "ISE Customer Order Subform") { ApplicationArea = All; SubPageLink = "Document No." = FIELD("No."); }
            part(Lines; "ISE Customer Order Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No."=FIELD("No.");
                Visible = false;
            }
            group("Tray Lines")
            {
                Visible = Rec.Tray;

                part(TrayLines; "ISE Manual Tray Lines")
                {
                    ApplicationArea = All;
                    SubPageLink = "Document No."=field("No.");
                }
            }
            group("Hardware Lines")
            {
                Visible = Rec.Hardware;

                part(HardwareLines; "ISE Harware Lines")
                {
                    ApplicationArea = All;
                    SubPageLink = "Document No."=field("No.");
                }
            }
            group("Lot Lines")
            {
                Visible = Rec.Lot;

                part(LotLines; "ISE Lot Lines")
                {
                    ApplicationArea = All;
                    SubPageLink = "Document No."=field("No.");
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ApproveReceiving)
            {
                Caption = 'Approve Receive';
                ApplicationArea = All;
                Image = Approvals;
                Visible = false;

                trigger OnAction()
                begin
                    Rec."Receiving Approved":=true;
                    Rec."Receiving Approved By":=UserId();
                    Rec."Receiving Approved DT":=CurrentDateTime;
                    if Rec."Order Source" = Rec."Order Source"::Adhoc then Rec."Direction Locked":=true; // lock for Adhoc
                    Rec.Modify(true);
                    CurrPage.Lines.PAGE.SetStage("ISE Stage"::Receiving, true, false);
                end;
            }
            action(Release)
            {
                trigger OnAction()
                var
                    CU: Codeunit "ISE Release Mgt";
                    ReceivingStatusMgt: Codeunit "ISE Receiving Status Mgt";
                begin
                    CU.ReleaseDocument(Rec);
                    Rec."Receiving Approved":=true;
                    Rec."Receiving Approved By":=UserId();
                    Rec."Receiving Approved DT":=CurrentDateTime;
                    if Rec."Order Source" = Rec."Order Source"::Adhoc then Rec."Direction Locked":=true; // lock for Adhoc
                    //Rec.Modify(true);
                    ReceivingStatusMgt.ReleaseReceiving(Rec);
                    CurrPage.Update(false);
                    Message('Receiving has been released for %1.', Rec."No.");
                    Rec.Modify(true);
                end;
            }
            action(PostReceipt)
            {
                Caption = 'Post Receipt';
                ApplicationArea = All;

                //Image = PostReceipt;
                trigger OnAction()
                var
                    PM: Codeunit "ISE Posting Mgt.";
                    SigMgt: Codeunit "ISE Signature Mgt";
                begin
                    if Rec.Status <> rec.Status::Released then error('Status has to be released');
                    if not SigMgt.HasSignature(Rec)then Error('Signature is required before posting.');
                    PM.PostOrder(Rec);
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        allow: Boolean;
    begin
        SetReceivingStatusStyle();
        allow:=(Rec."Order Source" = Rec."Order Source"::Adhoc) and (not Rec."Receiving Approved");
        CurrPage.Lines.PAGE.SetStage("ISE Stage"::Receiving, Rec."Receiving Approved", allow);
    end;
    var ReceivingStatusStyle: Text;
    local procedure SetReceivingStatusStyle()
    begin
        case Rec."Receiving Status" of Rec."Receiving Status"::Open: ReceivingStatusStyle:='Standard';
        Rec."Receiving Status"::"In Progress": ReceivingStatusStyle:='Ambiguous';
        Rec."Receiving Status"::Complete: ReceivingStatusStyle:='Favorable';
        end;
    end;
}
