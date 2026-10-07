tableextension 80136 "ISE COH Receiving Ext 95000" extends "ISE Customer Order Header"
{
    fields
    {
        field(95000; "Receiving Status";Enum "ISE Receiving Status")
        {
            Caption = 'Receiving Status';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(95001; "Mail Room Completed"; Boolean)
        {
            Caption = 'Mail Room Completed';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(95002; "Mail Room Completed By"; Code[50])
        {
            Caption = 'Mail Room Completed By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(95003; "Mail Room Completed DT"; DateTime)
        {
            Caption = 'Mail Room Completed Date/Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(95004; "Mail Room Comments 95000"; Text[250])
        {
            Caption = 'Mail Room Comments';
            DataClassification = CustomerContent;
        }
        field(95005; "Service Category 95000";Enum "ISE Service Category")
        {
            Caption = 'Service Category';
            DataClassification = CustomerContent;
        }
        field(95006; "Receiving Released By"; Code[50])
        {
            Caption = 'Receiving Released By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(95007; "Receiving Released DT"; DateTime)
        {
            Caption = 'Receiving Released Date/Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}
