page 80149 "ISE Device Family"
{
    PageType = List;
    SourceTable = "ISE Device Family";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Device Family';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Customer; Rec.Customer)
                {
                    ApplicationArea = All;
                }
                field("Device Family"; Rec."Device Family")
                {
                    ApplicationArea = All;
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
