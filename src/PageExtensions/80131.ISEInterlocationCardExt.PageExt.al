pageextension 80131 "ISE Interlocation Card Ext" extends "ISE Interlocation Trans Card"
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
        Rec.Validate("Transfer Type", Rec."Transfer Type"::Interlocation);
    end;
}
