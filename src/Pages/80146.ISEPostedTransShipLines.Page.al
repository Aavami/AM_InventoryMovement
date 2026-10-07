page 80146 "ISE Posted Trans-Ship Lines"
{
    PageType = List;
    SourceTable = "ISE Posted Transfer Ship Line";
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(G)
            {
                // field("Document No."; "Document No.") { ApplicationArea = All; }
                // field("Line No."; "Line No.") { ApplicationArea = All; }
                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("From Location Code"; rec."From Location Code")
                {
                    ApplicationArea = All;
                }
                field("From Bin Code"; rec."From Bin Code")
                {
                    ApplicationArea = All;
                }
                //field("To Location Code"; rec."To Location Code") { ApplicationArea = All; }
                //field("To Bin Code"; rec."To Bin Code") { ApplicationArea = All; }
                field("Internal Lot No."; rec."Internal Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Serial No."; rec."Serial No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
