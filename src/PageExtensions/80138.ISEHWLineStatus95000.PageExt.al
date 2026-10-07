pageextension 80138 "ISE HW Line Status 95000" extends "ISE Harware Lines"
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
