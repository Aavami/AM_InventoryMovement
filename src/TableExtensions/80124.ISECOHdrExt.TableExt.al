tableextension 80124 "ISE CO Hdr Ext" extends "ISE Customer Order Header"
{
    fields
    {
        field(70320; "Linked Purchase Order No."; Code[20])
        {
            Caption = 'Linked Purchase Order No.';
            TableRelation = "Purchase Header"."No." where("Document Type"=const(Order));
        }
        field(70321; "Vendor No"; code[20])
        {
        }
        field(70322; "Sent From Purchase"; Boolean)
        {
        }
    }
}
