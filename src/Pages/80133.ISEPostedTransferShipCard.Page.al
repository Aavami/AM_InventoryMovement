page 80133 "ISE Posted Transfer Ship Card"
{
    PageType = Card;
    SourceTable = "ISE Posted Transfer Ship Hdr";
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
                field("From Location Code"; Rec."From Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("In-Transit Location Code"; Rec."In-Transit Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Lines; "Posted Trans Ship Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Document No."=FIELD("No.");
            }
        }
    }
}
