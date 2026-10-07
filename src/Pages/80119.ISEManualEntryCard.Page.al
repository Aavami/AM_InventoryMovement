page 80119 "ISE Manual Entry Card"
{
    PageType = Card;
    SourceTable = "ISE Customer Order Header";
    ApplicationArea = All;
    Caption = 'Ship Alert';

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
                    Visible = false;
                }
                //field("Posting Date"; Rec."Posting Date") { ApplicationArea = All; }
                field("Service Category"; Rec."Service Category")
                {
                    ApplicationArea = all;
                }
            }
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
            action(SendForShipAlert)
            {
                Caption = 'Send for Ship Alert';
                ApplicationArea = All;
                Image = SendTo;

                trigger OnAction()
                begin
                    rec."Ship Alert Required":=true;
                    rec.Modify();
                //Page.Run(Page::"ISE Ship Alert Card", Rec);
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
        Rec.Validate(rec."Order Source", Rec."Order Source"::Manual);
        rec."Skip Ship Alert":=false;
        Rec."Order Request Type":=rec."Order Request Type"::Receipt;
        rec."No.":=NoMgt.GetNextNo(ISESetup."Manual Order No. Series");
        rec.Lot:=true;
    end;
}
