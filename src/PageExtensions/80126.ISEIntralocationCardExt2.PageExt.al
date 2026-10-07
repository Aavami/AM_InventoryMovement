pageextension 80126 "ISE Intralocation Card Ext2" extends "ISE Intralocation Trans Card"
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
