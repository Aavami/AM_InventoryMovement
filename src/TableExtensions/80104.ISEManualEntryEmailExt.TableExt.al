tableextension 80104 "ISE Manual Entry Email Ext" extends "ISE Customer Order Header"
{
    fields
    {
        field(80000; "Service Category";Enum "ISE Service Category")
        {
        }
        field(80931; "Email"; Text[100])
        {
            Caption = 'Email';
            DataClassification = CustomerContent;
        }
    }
    trigger OnModify()
    begin
    //TODO: Validate mandatory fields before release
    end;
}
