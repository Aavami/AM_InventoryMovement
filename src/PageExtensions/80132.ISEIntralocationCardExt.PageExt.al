pageextension 80132 "ISE Intralocation Card Ext" extends "ISE Intralocation Trans Card"
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
        Rec.Validate("Transfer Type", Rec."Transfer Type"::IntraLocation);
    end;
}
