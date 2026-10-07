page 80143 "ISE Combined Movements"
{
    PageType = List;
    SourceTable = "ISE Combined Movement Buf";
    SourceTableTemporary = true;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'ISE Combined Movements';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Movement Source"; Rec."Movement Source")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
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
                field("Location Code"; Rec."Location Code")
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
                field(Quantity; Rec.Quantity)
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
            action(RefreshMovements)
            {
                Caption = 'Refresh';
                ApplicationArea = All;
                Image = Refresh;

                trigger OnAction()
                begin
                    LoadMovements();
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        LoadMovements();
    end;
    local procedure LoadMovements()
    var
        Non: Record "ISE Non-Inv. Ledger Entry";
        BinLed: Record "ISE Bin Ledger Entry";
        Buf: Record "ISE Combined Movement Buf" temporary;
        EntryNo: Integer;
    begin
        Rec.DeleteAll();
        EntryNo:=1;
        if BinLed.FindSet()then repeat Buf.Init();
                buf."Entry No.":=EntryNo;
                Buf."Posting Date":=BinLed."Posting Date";
                Buf."Movement Source":=Buf."Movement Source"::Inventory;
                Buf."Document No.":=BinLed."Source Doc. No.";
                Buf."Line No.":=BinLed."Source Line No.";
                Buf."No.":=BinLed."Item No.";
                Buf.Description:='';
                Buf."Location Code":=BinLed."Location Code";
                Buf."Bin Code":=BinLed."Bin Code";
                Buf."Internal Lot No.":=BinLed."Internal Lot No.";
                Buf."Serial No.":=BinLed."Serial No.";
                Buf.Quantity:=BinLed.Quantity;
                EntryNo:=EntryNo + 1;
                Rec:=Buf;
                Rec.Insert(true);
            until BinLed.Next() = 0;
        if Non.FindSet()then repeat Buf.Init();
                buf."Entry No.":=EntryNo;
                Buf."Posting Date":=Non."Posting Date";
                Buf."Movement Source":=Buf."Movement Source"::NonInventory;
                Buf."Document No.":=Non."Document No.";
                Buf."Line No.":=Non."Source Line No.";
                Buf."No.":=Non."No.";
                Buf.Description:=Non.Description;
                Buf."Location Code":=Non."Location Code";
                Buf."Bin Code":=Non."Bin Code";
                Buf."Internal Lot No.":=Non."Internal Lot No.";
                Buf."Serial No.":=Non."Serial No.";
                EntryNo:=EntryNo + 1;
                if Non."Entry Type" IN[Non."Entry Type"::Shipment, Non."Entry Type"::TransferOut]then Buf.Quantity:=-Non.Quantity
                else
                    Buf.Quantity:=Non.Quantity;
                Rec:=Buf;
                Rec.Insert(true);
            until Non.Next() = 0;
    end;
}
