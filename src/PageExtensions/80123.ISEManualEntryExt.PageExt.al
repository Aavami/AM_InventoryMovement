pageextension 80123 "ISE Manual Entry Ext" extends "ISE Manual Entry Card"
{
    layout
    {
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
        addlast(Processing)
        {
            action(OpenManualOrders)
            {
                Caption = 'Open Manual Orders';
                ApplicationArea = All;
                Image = List;

                trigger OnAction()
                var
                    P: Page "ISE Manual Orders";
                begin
                    P.Run();
                end;
            }
        }
    }
}
