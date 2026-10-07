pageextension 80111 "ISEEmployee" extends "Employee Card"
{
    layout
    {
        addafter(Gender)
        {
            field("Lot Owner"; Rec."Lot Owner")
            {
                ApplicationArea = All;
            }
        }
    }
}
