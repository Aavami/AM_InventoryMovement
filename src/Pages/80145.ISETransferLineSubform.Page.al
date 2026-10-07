page 80145 "ISE Transfer Line Subform"
{
    PageType = ListPart;
    SourceTable = "ISE Transfer Line";
    ApplicationArea = All;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                //  field("Line No."; "Line No.") { ApplicationArea = All; Editable = false; }
                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                } //Visible = Type = Type::Inventory; }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Qty. to Ship"; rec."Qty. to Ship")
                {
                    ApplicationArea = All;
                } //Visible = (Type = Type::Inventory); }
                field("Qty. to Receive"; rec."Qty. to Receive")
                {
                    ApplicationArea = All;
                } //Visible = (Type = Type::Inventory); }
                field("Qty. to Post"; rec."Qty. to Post")
                {
                    ApplicationArea = All;
                }
                field("Qty. Shipped"; rec."Qty. Shipped")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Qty. Received"; rec."Qty. Received")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("From Location Code"; rec."From Location Code")
                {
                    ApplicationArea = All;
                }
                field("From Bin Code"; rec."From Bin Code")
                {
                    ApplicationArea = All;
                }
                field("To Location Code"; rec."To Location Code")
                {
                    ApplicationArea = All;
                }
                field("To Bin Code"; rec."To Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Customer Lot No."; rec."Customer Lot No.")
                {
                    ApplicationArea = All;
                //Visible = (Type = Type::Inventory) and ("Inventory Type" <> "Inventory Type"::"Non-Inventory");
                }
                field("Internal Lot No."; rec."Internal Lot No.")
                {
                    ApplicationArea = All;
                } //Visible = (Type = Type::Inventory); }
                field("Serial No."; rec."Serial No.")
                {
                    ApplicationArea = All;
                } //Visible = (Type = Type::Inventory) and ("Goods Type" = "Goods Type"::Hardware); }
                field("Inventory Type"; rec."Inventory Type")
                {
                    ApplicationArea = All;
                } //Visible = (Type = Type::Inventory); }
                field("Goods Type"; rec."Goods Type")
                {
                    ApplicationArea = All;
                } //Visible = (Type = Type::Inventory); }
                field("Customer Inventory"; rec."Customer Inventory")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(FillRemainingShip)
            {
                Caption = 'Fill Remaining (Ship)';
                ApplicationArea = All;
                Image = TransferOrder;

                trigger OnAction()
                var
                    rem: Decimal;
                begin
                    if Rec.Type <> Rec.Type::Inventory then exit;
                    rem:=Rec.Quantity - Rec."Qty. Shipped";
                    if rem < 0 then rem:=0;
                    Rec.Validate("Qty. to Ship", rem);
                    Rec.Modify(true);
                end;
            }
            action(FillRemainingReceive)
            {
                Caption = 'Fill Remaining (Receive)';
                ApplicationArea = All;
                Image = TransferReceipt;

                trigger OnAction()
                var
                    rem: Decimal;
                begin
                    if Rec.Type <> Rec.Type::Inventory then exit;
                    rem:=Rec.Quantity - Rec."Qty. Received";
                    if rem < 0 then rem:=0;
                    Rec.Validate("Qty. to Receive", rem);
                    Rec.Modify(true);
                end;
            }
        }
    }
}
