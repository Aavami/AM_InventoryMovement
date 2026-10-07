page 80120 "ISE Customer Order Subform"
{
    PageType = ListPart;
    SourceTable = "ISE Customer Order Line";
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
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Visible = false;
                    Caption = 'Item Type';
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
                // Editable = ((Stage = Stage::ShipAlert) or (Stage = Stage::Receiving) and AllowReceiveEdit) and (not Approved); }
                field("Qty. to Post"; Rec."Qty. to Post")
                {
                    ApplicationArea = All;
                }
                //Editable = (((Stage = "ISE STAge"::ShipAlert) 
                //or (Stage = "ISE Stage"::Receiving) and 
                //AllowReceiveEdit)) and (not Approved)); }
                field("Qty. Shipped"; Rec."Qty. Shipped")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Qty. Received"; Rec."Qty. Received")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Zone Code"; Rec."Zone Code")
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
                // Editable = ((Stage = Stage::ShipAlert) or (Stage = Stage::Receiving) and AllowReceiveEdit) and (not Approved); }
                //field("Serial No."; Rec."Serial No.") { ApplicationArea = All; }
                field("Lab Code"; Rec."Lab Code")
                {
                    ApplicationArea = All;
                }
                field("Rack Code"; Rec."Rack Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    procedure SetStage(NewStage: Enum "iSE Stage"; IsApproved: Boolean; AllowReceive: Boolean)
    var
        Stage: Enum "iSE Stage";
        Approved: Boolean;
        AllowReceiveEdit: Boolean;
    begin
        Stage:=NewStage;
        Approved:=IsApproved;
        AllowReceiveEdit:=AllowReceive;
        CurrPage.Update(false);
    end;
}
