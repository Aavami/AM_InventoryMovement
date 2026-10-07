pageextension 80120 "ISE CO Subform Ext" extends "ISE Customer Order Subform"
{
    layout
    {
        addlast(General)
        {
            field("Inventory Type"; Rec."Inventory Type")
            {
                ApplicationArea = All;
                Visible = Rec.Type = Rec.Type::Inventory;
            }
            field("Goods Type"; Rec."Goods Type")
            {
                ApplicationArea = All;
                Visible = Rec.Type = Rec.Type::Inventory;
            }
            field("Customer Inventory"; Rec."Customer Inventory")
            {
                ApplicationArea = All;
            }
        }
        //modify("Internal Lot No.") { Visible = (Rec.Type = Rec.Type::Inventory); }
        modify("Serial No.")
        {
            Visible = (Rec.Type = Rec.Type::Inventory) and (Rec."Goods Type" = Rec."Goods Type"::Hardware);
        }
    }
}
