page 80135 "ISE Posted Transfer Recv Card"
{
    PageType = Card;
    SourceTable = "ISE Posted Transfer Recv Hdr";
    ApplicationArea = All;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Source Transfer No."; Rec."Source Transfer No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("To Location Code"; Rec."To Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Lines; "Posted Transfer Rcv Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Document No."=FIELD("No.");
            }
        }
    }
}
