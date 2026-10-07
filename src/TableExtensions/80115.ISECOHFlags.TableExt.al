tableextension 80115 "ISE COH Flags" extends "ISE Customer Order Header"
{
    fields
    {
        modify(Hardware)
        {
        trigger OnAfterValidate()
        begin
            if Rec.Hardware then Rec.Lot:=false;
        end;
        }
        modify(Lot)
        {
        trigger OnAfterValidate()
        begin
            if Rec.Lot then begin
                Rec.Tray:=false;
                Rec.Hardware:=false;
            end;
        end;
        }
        modify(Tray)
        {
        trigger OnAfterValidate()
        begin
            if Rec.Tray then Rec.Lot:=false;
        end;
        }
    }
}
