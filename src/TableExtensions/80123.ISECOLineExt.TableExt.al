tableextension 80123 "ISE CO Line Ext" extends "ISE Customer Order Line"
{
    fields
    {
        field(70320; "Customer Inventory"; Boolean)
        {
            Caption = 'Customer Inventory';
        }
        field(70321; "Inventory Type";Enum "ISE Inventory Type")
        {
            Caption = 'Inventory Type';
        }
        field(70322; "Goods Type";Enum "ISE Goods Type")
        {
            Caption = 'Goods Type';
        }
    }
}
