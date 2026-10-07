pageextension 80133 "ISE Subcon Card Ext" extends "ISE Subcontractor Trans Card"
{
    layout
    {
        addlast(General)
        //modify("Transfer Type")
        {
            field("Transfer Type"; Rec."Transfer Type")
            {
                ApplicationArea = All;
                Editable = false;
            } // keep page typed
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Validate("Transfer Type", Rec."Transfer Type"::Subcontractor);
    end;
}
