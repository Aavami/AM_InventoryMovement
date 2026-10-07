pageextension 80129 "ISE Intraloc Card FB Ext" extends "ISE Intralocation Trans Card"
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
}
