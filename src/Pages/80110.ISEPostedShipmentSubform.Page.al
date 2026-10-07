page 80110 "ISE Posted Shipment Subform"
{
    PageType = ListPart;
    SourceTable = "ISE Posted Shipment Line";
    ApplicationArea = All;
    Caption = 'Posted Shipment Lines';

    layout
    {
        area(content)
        {
            repeater(Group)
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
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
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
