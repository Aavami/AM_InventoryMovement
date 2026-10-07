codeunit 80104 "ISE Signature Mgt"
{
    procedure SaveSignatureToOrder(var H: Record "ISE Customer Order Header"; SignatureDataUrl: Text)
    var
        Base64: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        OutS: OutStream;
        InS: InStream;
        base64Text: Text;
    begin
        base64Text:=SignatureDataUrl;
        if StrPos(base64Text, 'base64,') > 0 then base64Text:=CopyStr(base64Text, StrPos(base64Text, 'base64,') + 7);
        TempBlob.CreateOutStream(OutS);
        Base64.FromBase64(base64Text, OutS);
        TempBlob.CreateInStream(InS);
        Clear(H.Signature);
        H.Signature.CreateOutStream(OutS);
        CopyStream(OutS, InS);
        H.Modify(true);
    end;
    procedure HasSignature(H: Record "ISE Customer Order Header"): Boolean var
        InS: InStream;
    begin
        exit(H.Signature.HasValue());
    end;
}
