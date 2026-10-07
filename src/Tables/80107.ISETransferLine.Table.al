table 80107 "ISE Transfer Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            TableRelation = "ISE Transfer Header"."No.";
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; Type; Option)
        {
            OptionMembers = Inventory, NonInventory;
        }
        field(4; "No."; Code[20])
        {
            TableRelation = if(Type=CONST(Inventory))Item where(Type=const(Inventory))
            else if(Type=CONST(NonInventory))Item where(Type=const("Non-Inventory"));

            trigger OnValidate()
            var
                Itemrec: Record Item;
            Begin
                if Itemrec.Get("No.")then Description:=Itemrec.Description;
            End;
        }
        field(5; Description; Text[100])
        {
            Editable = false;
        }
        field(6; Quantity; Decimal)
        {
        }
        field(7; "Qty. to Post"; Decimal)
        {
        }
        field(8; "Qty. Shipped"; Decimal)
        {
            Editable = false;
        }
        field(9; "Qty. Received"; Decimal)
        {
            Editable = false;
        }
        field(10; "From Location Code"; Code[10])
        {
        }
        field(11; "From Zone Code"; Code[10])
        {
        }
        field(12; "From Bin Code"; Code[20])
        {
        }
        field(13; "To Location Code"; Code[10])
        {
        }
        field(14; "To Zone Code"; Code[10])
        {
        }
        field(15; "To Bin Code"; Code[20])
        {
        }
        field(16; "Customer Lot No."; Code[50])
        {
        }
        field(17; "Internal Lot No."; Code[20])
        {
        }
        field(18; "Serial No."; Code[50])
        {
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    local procedure GetNextLineNo(): Integer var
        Line: Record "ISE Customer Order Line";
    begin
        Line.SetRange("Document No.", "Document No.");
        if Line.FindLast()then exit(Line."Line No." + 10000)
        else
            exit(10000);
    end;
    trigger OnInsert()
    begin
        if "Line No." = 0 then "Line No.":=GetNextLineNo;
    end;
}
