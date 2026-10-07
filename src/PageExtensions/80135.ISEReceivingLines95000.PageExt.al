pageextension 80135 "ISE Receiving Lines 95000" extends "ISE Lot Lines"
{
    layout
    {
        addafter("Qty. Received")
        {
            field("Receiving Line Status"; Rec."Receiving Line Status")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Receiving Line Status';
            }
        }
    }
}
