page 80142 "Posted Trans Ship Lines"
{
    ApplicationArea = All;
    Caption = 'Posted Trans Ship Lines';
    PageType = ListPart;
    SourceTable = "ISE Posted Transfer Ship Line";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("From Bin Code"; Rec."From Bin Code")
                {
                    ToolTip = 'Specifies the value of the From Bin Code field.', Comment = '%';
                }
                field("From Location Code"; Rec."From Location Code")
                {
                    ToolTip = 'Specifies the value of the From Location Code field.', Comment = '%';
                }
                field("Internal Lot No."; Rec."Internal Lot No.")
                {
                    ToolTip = 'Specifies the value of the Internal Lot No. field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ToolTip = 'Specifies the value of the Serial No. field.', Comment = '%';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
            }
        }
    }
}
