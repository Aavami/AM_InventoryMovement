page 80147 "ISE Posted Trans-Rcpt Lines"
{
    PageType = List;
    SourceTable = "ISE Posted Transfer Recv Line";
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(G)
            {
                //field("Document No."; Rec."Document No.") { ApplicationArea = All; }
                // field("Line No."; rec."Line No.") { ApplicationArea = All; }
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
                //field("From Location Code";rec.) { ApplicationArea = All; }
                //field("From Bin Code"; rec."From Bin Code") { ApplicationArea = All; }
                field("To Location Code"; rec."To Location Code")
                {
                    ApplicationArea = All;
                }
                field("To Bin Code"; rec."To Bin Code")
                {
                    ApplicationArea = All;
                }
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
