page 80150 "ISE Device"
{
    PageType = List;
    SourceTable = "ISE Device";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Device';
    DelayedInsert = true;

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
                field("Device Family"; Rec."Device Family 2")
                {
                    ApplicationArea = All;
                }
                field(Device; Rec.Device)
                {
                    ApplicationArea = All;
                }
                field("Lot Type"; Rec."Lot Type")
                {
                    ApplicationArea = All;
                }
                field("Tray/Tube Mapping"; Rec."Tray/Tube Mapping")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field(COO; Rec.COO)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
