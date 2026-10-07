pageextension 80137 "ISE Tray Line Status 95000" extends "ISE Manual Tray Lines"
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
