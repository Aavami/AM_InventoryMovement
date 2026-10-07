page 80123 "ISE Ship Alert Card"
{
    PageType = Card;
    SourceTable = "ISE Customer Order Header";
    ApplicationArea = All;
    Caption = 'ISE Ship Alert';

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
                field("Ship Alert Type"; Rec."Ship Alert Type")
                {
                    ApplicationArea = All;
                }
                field("Order Request Type"; Rec."Order Request Type")
                {
                    ApplicationArea = All;
                    Editable = not Rec."Direction Locked";
                }
            }
            group("Ship Alert")
            {
                field("Ship Alert Required"; Rec."Ship Alert Required")
                {
                    ApplicationArea = All;
                }
                field("Ship Alert Nature"; Rec."Ship Alert Nature")
                {
                    ApplicationArea = All;
                }
                field("Ship Alert Courier"; Rec."Ship Alert Courier")
                {
                    ApplicationArea = All;
                }
                field("Ship Alert Driver"; Rec."Ship Alert Driver")
                {
                    ApplicationArea = All;
                }
                field("Ship Alert Cartons"; Rec."Ship Alert Cartons")
                {
                    ApplicationArea = All;
                }
                field("Ship Alert Notes"; Rec."Ship Alert Notes")
                {
                    ApplicationArea = All;
                }
                field("Ship Alert Approved"; Rec."Ship Alert Approved")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ship Alert Approved By"; Rec."Ship Alert Approved By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ship Alert Approved DT"; Rec."Ship Alert Approved DT")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Shipment Details")
            {
                field("No. of Boxes"; rec."No. of Boxes")
                {
                    ApplicationArea = All;
                }
                field("No. of Cartons"; rec."No. of Cartons")
                {
                    ApplicationArea = All;
                }
                field("Dispatch Date"; rec."Dispatch Date")
                {
                    ApplicationArea = All;
                }
                field("Tracking Number"; rec."Tracking Number")
                {
                    ApplicationArea = All;
                }
                field("Shipped By"; rec."Shipped By")
                {
                    ApplicationArea = All;
                }
                field("Contact Details"; rec."Contact Details")
                {
                    ApplicationArea = All;
                }
            }
            part(Lines; "ISE Customer Order Subform")
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
            action(ApproveShipAlert)
            {
                Caption = 'Approve Ship Alert';
                ApplicationArea = All;
                Image = Approvals;

                trigger OnAction()
                begin
                    if Rec."Ship Alert Type" = Rec."Ship Alert Type"::Shipment then Rec."Order Request Type":=Rec."Order Request Type"::Shipment
                    else if Rec."Ship Alert Type" = Rec."Ship Alert Type"::Receipt then Rec."Order Request Type":=Rec."Order Request Type"::Receipt;
                    Rec."Ship Alert Approved":=true;
                    Rec."Ship Alert Approved By":=UserId();
                    Rec."Ship Alert Approved DT":=CurrentDateTime;
                    Rec."Direction Locked":=true;
                    CurrPage.Lines.PAGE.SetStage("ISE Stage"::ShipAlert, true, false);
                    Rec.Modify(true);
                end;
            }
            action(SendForReceive)
            {
                Caption = 'Send for Receive';
                ApplicationArea = All;
                Image = SendTo;

                trigger OnAction()
                begin
                    Page.Run(Page::"ISE Receiving Card", Rec);
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.Lines.PAGE.SetStage("ISE Stage"::ShipAlert, Rec."Ship Alert Approved", false);
    end;
}
