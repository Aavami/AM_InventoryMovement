pageextension 80136 "ISE Receiving List 95000" extends "ISE Receiving Orders"
{
    layout
    {
        addafter("Receiving Approved")
        {
            field("Receiving Status"; Rec."Receiving Status")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Mail Room Completed"; Rec."Mail Room Completed")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
