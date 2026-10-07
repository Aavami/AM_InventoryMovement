page 80141 "Posted Transfer Rcv Lines"
{
    ApplicationArea = All;
    Caption = 'Posted Transfer Rcv Lines';
    PageType = ListPart;
    SourceTable = "ISE Posted Transfer Recv Line";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Internal Lot No."; Rec."Internal Lot No.")
                {
                    ToolTip = 'Specifies the value of the Internal Lot No. field.', Comment = '%';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ToolTip = 'Specifies the value of the Serial No. field.', Comment = '%';
                }
                field("Source Doc. No."; Rec."Source Doc. No.")
                {
                    ToolTip = 'Specifies the value of the Source Doc. No. field.', Comment = '%';
                }
                field("Source Line No."; Rec."Source Line No.")
                {
                    ToolTip = 'Specifies the value of the Source Line No. field.', Comment = '%';
                }
                field("To Bin Code"; Rec."To Bin Code")
                {
                    ToolTip = 'Specifies the value of the To Bin Code field.', Comment = '%';
                }
                field("To Location Code"; Rec."To Location Code")
                {
                    ToolTip = 'Specifies the value of the To Location Code field.', Comment = '%';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
            }
        }
    }
}
