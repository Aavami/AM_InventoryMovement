page 80113 "ISE Setup"
{
    PageType = Card;
    SourceTable = "ISE Setup";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Orders)
            {
                field("Internal Lot No. Series"; Rec."Internal Lot No. Series")
                {
                    ApplicationArea = All;
                }
                field("Serial No. Series"; Rec."Serial No. Series")
                {
                    ApplicationArea = All;
                }
                field("Posted Shipment No. Series"; Rec."Posted Shipment No. Series")
                {
                    ApplicationArea = All;
                }
                field("Posted Receipt No. Series"; Rec."Posted Receipt No. Series")
                {
                    ApplicationArea = All;
                }
                field("Manual Order No. Series"; Rec."Manual Order No. Series")
                {
                    ApplicationArea = All;
                }
                field("MES Order No. Series"; Rec."MES Order No. Series")
                {
                    ApplicationArea = All;
                }
                field("Adhoc Order No. Series"; Rec."Adhoc Order No. Series")
                {
                    ApplicationArea = All;
                }
                field("Order No. Series"; Rec."Order No. Series")
                {
                    ApplicationArea = All;
                }
            }
            group(Transfers)
            {
                field("Transfer No. Series"; Rec."Transfer No. Series")
                {
                    ApplicationArea = All;
                }
                field("Posted Trans-Ship No. Series"; Rec."Posted Trans-Ship No. Series")
                {
                    ApplicationArea = All;
                }
                field("Posted Trans-Recv No. Series"; Rec."Posted Trans-Recv No. Series")
                {
                    ApplicationArea = All;
                }
                field("Default In-Transit Location"; Rec."Default In-Transit Location")
                {
                    ApplicationArea = All;
                }
            }
            group(Journals)
            {
                field("Item Jnl. Template"; Rec."Item Jnl. Template")
                {
                    ApplicationArea = All;
                }
                field("Item Jnl. Batch"; Rec."Item Jnl. Batch")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        if Rec.IsEmpty()then begin
            Rec.Init();
            Rec."Primary Key":='SETUP';
            Rec.Insert(true);
        end;
    end;
}
