tableextension 80112 "ISECustOrderHeaderPackage" extends "ISE Customer Order Header"
{
    fields
    {
        modify(Hardware)
        {
        trigger OnAfterValidate()
        begin
            if Rec.Hardware then begin
                // Hardware selected → Lot must be false
                if Rec.Lot then Error('Hardware cannot be selected when Lot is already selected. Please deselect Lot first.');
                Rec.Lot:=false;
            end;
        end;
        }
        modify(Lot)
        {
        trigger OnAfterValidate()
        begin
            if Rec.Lot then begin
                // Lot selected → Tray and Hardware must be false
                if Rec.Tray or Rec.Hardware then Error('Lot cannot be selected together with Tray or Hardware. Please deselect Tray and Hardware first.');
                Rec.Tray:=false;
                Rec.Hardware:=false;
            end;
        end;
        }
        modify(Tray)
        {
        trigger OnAfterValidate()
        begin
            if Rec.Tray then begin
                // Tray selected → Lot must be false
                if Rec.Lot then Error('Tray cannot be selected when Lot is already selected. Please deselect Lot first.');
                Rec.Lot:=false;
            end;
        end;
        }
    }
}
