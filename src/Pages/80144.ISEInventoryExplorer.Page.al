page 80144 "ISE Inventory Explorer"
{
    PageType = List;
    SourceTable = "ISE Inventory Explorer Buf";
    SourceTableTemporary = true;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'ISE Inventory Explorer';

    layout
    {
        area(content)
        {
            repeater(G)
            {
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
                field("Internal Lot No."; Rec."Internal Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field("On Hand"; Rec."On Hand")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Refresh)
            {
                Caption = 'Refresh';
                ApplicationArea = All;
                Image = Refresh;

                trigger OnAction()
                begin
                    Load();
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Load();
    end;
    local procedure Load()
    var
        BE: Record "ISE Bin Ledger Entry";
        tmp: Record "ISE Inventory Explorer Buf" temporary;
    begin
        Rec.DeleteAll();
        if BE.FindSet()then repeat tmp.Init();
                tmp."Location Code":=BE."Location Code";
                tmp."Zone Code":=BE."Zone Code";
                tmp."Bin Code":=BE."Bin Code";
                tmp."Internal Lot No.":=BE."Internal Lot No.";
                tmp."Serial No.":=BE."Serial No.";
                if tmp.Get(tmp."Location Code", tmp."Zone Code", tmp."Bin Code", tmp."Internal Lot No.", tmp."Serial No.")then begin
                    tmp."On Hand":=tmp."On Hand" + BE.Quantity;
                    tmp.Modify();
                end
                else
                begin
                    tmp."On Hand":=BE.Quantity;
                    tmp.Insert();
                end;
            until BE.Next() = 0;
        // Materialize tmp into Rec
        if tmp.FindSet()then repeat Rec:=tmp;
                Rec.Insert();
            until tmp.Next() = 0;
    end;
}
