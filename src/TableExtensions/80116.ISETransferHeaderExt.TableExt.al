tableextension 80116 "ISE Transfer Header Ext" extends "ISE Transfer Header"
{
    fields
    {
        field(50000; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";

            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
                if Cust.Get("Customer No.")then "Customer Name":=Cust.Name
                else
                    "Customer Name":='';
            end;
        }
        field(50001; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            Editable = false;
        }
    }
}
