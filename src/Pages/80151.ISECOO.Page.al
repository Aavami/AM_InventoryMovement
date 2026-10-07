page 80151 "ISE COO"
{
    PageType = List;
    SourceTable = "ISE COO";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'COO';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(COO; Rec.COO)
                {
                    ApplicationArea = All;
                }
                field("COO Code"; Rec."COO Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
