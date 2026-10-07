pageextension 80112 "ISELoc" extends "Location Card"
{
    layout
    {
        addafter("Use As In-Transit")
        {
            field("ISE Facility"; Rec."ISE Facility")
            {
                ApplicationArea = All;
            }
            field("ISE Staging Location"; Rec."ISE Staging Location")
            {
                ApplicationArea = All;
            }
        }
    }
}
