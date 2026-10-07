codeunit 80111 "ISE Adhoc Posting Job"
{
    //Subtype = Job;
    trigger OnRun()
    begin
        ProcessQueue();
    end;
    local procedure ProcessQueue()
    var
        Q: Record "ISE Adhoc Queue";
        H: Record "ISE Customer Order Header";
        PM: Codeunit "ISE Posting Mgt.";
    begin
        if Q.FindSet()then repeat if Q.Status <> Q.Status::Pending then continue;
                Q.Status:=Q.Status::Processing;
                Q.Modify(true);
                if TryPostOrder(Q."Source No.")then begin
                    Q.Status:=Q.Status::Done;
                    Q."Processed At":=CurrentDateTime();
                end
                else
                begin
                    Q.Status:=Q.Status::Error;
                    // The TryFunction sets the last error text automatically
                    Q."Last Error":=GetLastErrorText();
                end;
                Q.Modify(true);
            until Q.Next() = 0;
    end;
    [TryFunction]
    local procedure TryPostOrder(SourceNo: Code[20])
    var
        H: Record "ISE Customer Order Header";
        PM: Codeunit "ISE Posting Mgt.";
    begin
        if H.Get(SourceNo)then PM.PostOrder(H)
        else
            Error(StrSubstNo('Order %1 not found', SourceNo));
    end;
}
