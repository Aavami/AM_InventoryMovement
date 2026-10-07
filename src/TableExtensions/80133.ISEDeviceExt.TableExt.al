tableextension 80133 "ISEDeviceExt" extends "ISE Device"
{
    fields
    {
        field(50100; "Device Family 2"; Code[20])
        {
            Caption = 'Device Family';
            // Set this to false to completely avoid the "cannot be renamed" platform error
            ValidateTableRelation = false;
            TableRelation = "ISE Device Family"."Device Family" where(Customer=field(Customer), Active=const(true));

            // Manually handle validation safely in the trigger
            trigger OnValidate()
            var
                DeviceFamilyRec: Record "ISE Device Family";
            begin
                if "Device Family 2" <> '' then begin
                    if DeviceFamilyRec.Get("Device Family 2")then begin
                        DeviceFamilyRec.TestField(Customer, Rec.Customer);
                        DeviceFamilyRec.TestField(Active, true);
                    end;
                end;
            end;
        }
    }
}
