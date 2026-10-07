page 80140 "ISE Transfer Lines Subform"
{
    PageType = ListPart;
    SourceTable = "ISE Transfer Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Qty. to Post"; Rec."Qty. to Post")
                {
                    ApplicationArea = All;
                }
                field("From Location Code"; Rec."From Location Code")
                {
                    ApplicationArea = All;
                }
                field("From Zone Code"; Rec."From Zone Code")
                {
                    ApplicationArea = All;
                }
                field("From Bin Code"; Rec."From Bin Code")
                {
                    ApplicationArea = All;
                }
                field("To Location Code"; Rec."To Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("To Zone Code"; Rec."To Zone Code")
                {
                    ApplicationArea = All;
                }
                field("To Bin Code"; Rec."To Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Customer Lot No."; Rec."Customer Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Internal Lot No."; Rec."Internal Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
