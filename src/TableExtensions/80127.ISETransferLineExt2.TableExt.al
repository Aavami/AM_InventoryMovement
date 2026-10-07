tableextension 80127 "ISE Transfer Line Ext2" extends "ISE Transfer Line"
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
        field(70323; "Qty. to Ship"; Decimal)
        {
            Caption = 'Qty. to Ship';
            DecimalPlaces = 0: 5;
        }
        field(70324; "Qty. to Receive"; Decimal)
        {
            Caption = 'Qty. to Receive';
            DecimalPlaces = 0: 5;
        }
    }
}
