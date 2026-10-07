pageextension 80114 "ISE Receiving Signature Pad" extends "ISE Receiving Card"
{
    layout
    {
        addlast("Receiving")
        {
            group(Signatures)
            {
                Caption = 'Signature';

                usercontrol(SignPad; "ISE Signature Pad")
                {
                    ApplicationArea = All;

                    trigger SignatureSubmitted(SignatureDataUrl: Text)
                    var
                        H: Record "ISE Customer Order Header";
                        SigMgt: Codeunit "ISE Signature Mgt";
                    begin
                        H.Get(Rec."No.");
                        SigMgt.SaveSignatureToOrder(H, SignatureDataUrl);
                        CurrPage.Update(false);
                    end;
                }
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}
