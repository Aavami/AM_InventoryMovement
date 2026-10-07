page 80116 "ISE MES Entry Card"
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
                    LookupPageId = "ISE Customer Lookup";
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
    actions
    {
        area(Processing)
        {
            action(SendForShipAlert)
            {
                Caption = 'Send for Ship Alert';
                ApplicationArea = All;
                Image = SendTo;

                trigger OnAction()
                begin
                    Page.Run(Page::"ISE Ship Alert Card", Rec);
                end;
            }
        }
    }
    //trigger OnAfterGetCurrRecord()
    //begin
    //  CurrPage.Lines.PAGE.SetStage("ISE Stage"::Entry, false, false);
    //end;
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        NoMgt: Codeunit "No. Series";
        ISESetup: Record "ISE Setup";
    begin
        ISESetup.get('SETUP');
        Rec.Validate(rec."Order Source", Rec."Order Source"::MES);
        rec."Skip Ship Alert":=false;
        rec."No.":=NoMgt.GetNextNo(ISESetup."MES Order No. Series");
    end;
}
