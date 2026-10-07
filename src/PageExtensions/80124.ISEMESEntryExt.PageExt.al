pageextension 80124 "ISE MES Entry Ext" extends "ISE MES Entry Card"
{
    actions
    {
        modify(SendForShipAlert)
        {
            Visible = false;
        }
        addfirst(Processing)
        {
            action(DirectShip)
            {
                Caption = 'Post Direct Shipment';
                ApplicationArea = All;
                Image = Post;

                trigger OnAction()
                var
                    PM: Codeunit "ISE Posting Mgt.";
                    H: Record "ISE Customer Order Header";
                begin
                    H.Get(Rec."No.");
                    H.Validate("Order Request Type", H."Order Request Type"::Shipment);
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
