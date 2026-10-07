pageextension 80108 "ISE Vendor Permission" extends "User Setup"
{
    layout
    {
        addafter("User ID")
        {
            field("Can Update ISE Vendors"; Rec."Can Update ISE Vendors")
            {
                ApplicationArea = All;
            }
        }
    }
}
