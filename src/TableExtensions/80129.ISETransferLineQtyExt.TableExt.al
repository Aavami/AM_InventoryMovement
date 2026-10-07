tableextension 80129 "ISE Transfer Line QtyExt" extends "ISE Transfer Line"
{
    fields
    {
        modify("Qty. to Post")
        {
        trigger OnAfterValidate()
        var
            Rem: Decimal;
        begin
            if "Qty. to Post" < 0 then Error('Qty. to Post cannot be negative.');
            Rem:=Quantity - "Qty. Shipped";
            if Rem < 0 then Rem:=0;
            if "Qty. to Post" > Rem then Error('Qty. to Post (%1) cannot exceed remaining quantity (%2).', "Qty. to Post", Rem);
        end;
        }
        modify(Quantity)
        {
        trigger OnAfterValidate()
        var
            Rem: Decimal;
        begin
            if Quantity < "Qty. Shipped" then Error('Quantity (%1) cannot be less than Qty. Shipped (%2).', Quantity, "Qty. Shipped");
            Rem:=Quantity - "Qty. Shipped";
            if "Qty. to Post" > Rem then "Qty. to Post":=Rem;
        end;
        }
    }
}
