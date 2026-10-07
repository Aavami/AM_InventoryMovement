codeunit 80108 "ISE Bin Ledger Mgt."
{
    procedure AddMovement(ItemNo: Code[20]; Loc: Code[10]; Bin: Code[20]; Lot: Code[20]; Serial: Code[50]; Qty: Decimal; SourceDoc: Code[20]; SourceLine: Integer)
    var
        BE: Record "ISE Bin Ledger Entry";
    begin
        if Qty = 0 then exit;
        BE.Init();
        BE."Posting Date":=Today;
        BE."Item No.":=ItemNo;
        BE."Location Code":=Loc;
        BE."Bin Code":=Bin;
        BE."Internal Lot No.":=Lot;
        BE."Serial No.":=Serial;
        BE.Quantity:=Qty;
        BE."Source Doc. No.":=SourceDoc;
        BE."Source Line No.":=SourceLine;
        BE.Insert();
    end;
    procedure AddMovementEx(ItemNo: Code[20]; Loc: Code[10]; Zone: Code[10]; Bin: Code[20]; Lot: Code[20]; Serial: Code[50]; Qty: Decimal; SourceDoc: Code[20]; SourceLine: Integer)
    var
        BE: Record "ISE Bin Ledger Entry";
    begin
        if Qty = 0 then exit;
        BE.Init();
        BE."Posting Date":=Today;
        BE."Item No.":=ItemNo;
        BE."Location Code":=Loc;
        BE."Zone Code":=Zone;
        BE."Bin Code":=Bin;
        BE."Internal Lot No.":=Lot;
        BE."Serial No.":=Serial;
        BE.Quantity:=Qty;
        BE."Source Doc. No.":=SourceDoc;
        BE."Source Line No.":=SourceLine;
        BE.Insert();
    end;
    procedure GetOnHand(ItemNo: Code[20]; Loc: Code[10]; Bin: Code[20]; Lot: Code[20]; Serial: Code[50]): Decimal var
        BE: Record "ISE Bin Ledger Entry";
        q: Decimal;
    begin
        BE.SetRange("Item No.", ItemNo);
        if Loc <> '' then BE.SetRange("Location Code", Loc);
        if Bin <> '' then BE.SetRange("Bin Code", Bin);
        if Lot <> '' then BE.SetRange("Internal Lot No.", Lot);
        if Serial <> '' then BE.SetRange("Serial No.", Serial);
        if BE.FindSet()then repeat q+=BE.Quantity until BE.Next() = 0;
        exit(q);
    end;
}
