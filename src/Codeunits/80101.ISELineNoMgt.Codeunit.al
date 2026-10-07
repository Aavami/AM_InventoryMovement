codeunit 80101 "ISE Line No. Mgt."
{
    procedure GetNextLineNo(DocumentNo: Code[20]): Integer var
        L: Record "ISE Customer Order Line";
    begin
        L.LockTable();
        L.SetRange("Document No.", DocumentNo);
        if L.FindLast()then exit(L."Line No." + 10000);
        exit(10000);
    end;
}
