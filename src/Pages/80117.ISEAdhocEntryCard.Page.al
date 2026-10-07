page 80117 "ISE Adhoc Entry Card"
{
    PageType = Card;
    SourceTable = "ISE Customer Order Header";
    ApplicationArea = All;

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
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Order Request Type"; Rec."Order Request Type")
                {
                    ApplicationArea = All;
                    Editable = not Rec."Direction Locked";
                }
                field("Posting Date"; Rec."Posting Date")
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
    //
    actions
    {
        area(Processing)
        {
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
        CurrPage.Lines.PAGE.SetStage("ISE Stage"::Entry, false, false);
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        NoMgt: Codeunit "No. Series";
        ISESetup: Record "ISE Setup";
    begin
        ISESetup.get('SETUP');
        Rec.Validate(rec."Order Source", Rec."Order Source"::Adhoc);
        rec."No.":=NoMgt.GetNextNo(ISESetup."Adhoc Order No. Series");
    end;
}
