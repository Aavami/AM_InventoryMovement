pageextension 80110 "ISEItem" extends "Item Card"
{
    layout
    {
        addafter(Type)
        {
            field("Manual Line Type"; Rec."Manual Line Type")
            {
                ApplicationArea = All;
            }
        }
    }
}
