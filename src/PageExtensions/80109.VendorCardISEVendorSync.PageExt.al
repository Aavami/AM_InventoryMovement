pageextension 80109 "Vendor Card - ISE Vendor Sync" extends "Vendor Card"
{
    layout
    {
        addafter(Blocked)
        {
            field("Tray Vendor"; Rec."Tray Vendor")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addlast(Processing)
        {
            action(UpdateISEVendor)
            {
                Caption = 'Update ISE Vendor';
                ApplicationArea = All;
                Image = Refresh;

                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                    SyncMgt: Codeunit "ISE Vendor Sync Mgt";
                begin
                    // Permission check
                    if not UserSetup.Get(UserId())then Error('User Setup is not defined for your user.');
                    if not UserSetup."Can Update ISE Vendors" then Error('You are not authorized to update ISE Vendors.');
                    SyncMgt.SyncVendorToISE(Rec);
                    Message('ISE Vendor updated successfully.');
                end;
            }
        }
    }
}
