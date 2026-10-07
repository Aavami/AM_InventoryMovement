pageextension 80127 "ISE Subcontractor Card Ext" extends "ISE Subcontractor Trans Card"
{
    layout
    {
        addlast(content)
        {
            part(TransferLines; "ISE Transfer Line Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No."=field("No.");
            }
        }
    }
}
