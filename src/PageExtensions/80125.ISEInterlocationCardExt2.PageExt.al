pageextension 80125 "ISE Interlocation Card Ext2" extends "ISE Interlocation Trans Card"
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
