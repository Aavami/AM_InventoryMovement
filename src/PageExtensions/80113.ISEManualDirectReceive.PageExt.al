pageextension 80113 "ISE Manual Direct Receive" extends "ISE Manual Entry Card"
{
    actions
    {
        modify(SendForShipAlert)
        {
            Visible = false;
            Enabled = false;
        }
        addlast(Processing)
        {
            action(SendForReceive)
            {
                Caption = 'Send to Receive';
                ApplicationArea = All;
                Image = SendTo;
                Visible = false;

                trigger OnAction()
                begin
                    Page.Run(Page::"ISE Receiving Card", Rec);
                end;
            }
            action(Release)
            {
                Caption = 'Release';
                ApplicationArea = All;
                Image = ReleaseDoc;

                //Visible = false;
                trigger OnAction()
                var
                    CU: Codeunit "ISE Release Mgt";
                begin
                    CU.ReleaseDocument(Rec);
                    Message('Ship Alert %1 has been released.', Rec."No.");
                end;
            }
        }
    }
}
