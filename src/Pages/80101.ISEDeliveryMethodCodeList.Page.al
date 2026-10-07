page 80101 "ISE Delivery Method Code List"
{
    PageType = List;
    SourceTable = "ISE Delivery Method Code";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'ISE Delivery Method Codes';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Delivery Method"; Rec."Delivery Method 2")
                {
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
