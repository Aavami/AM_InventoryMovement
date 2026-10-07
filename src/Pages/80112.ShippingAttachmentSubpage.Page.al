page 80112 "Shipping Attachment Subpage"
{
    PageType = ListPart;
    SourceTable = "Shipping Attachment";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("File Name"; Rec."File Name")
                {
                }
                field("Attached By"; Rec."Attached By")
                {
                }
                field("Attached On"; Rec."Attached On")
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(UploadFile)
            {
                Caption = 'Upload';
                Image = Import;

                trigger OnAction()
                var
                    FileName: Text;
                    InStream: InStream;
                    OutStreams: OutStream;
                begin
                    UploadIntoStream('Select File', '', '', FileName, InStream);
                    Rec.Init();
                    Rec."File Name":=FileName;
                    Rec."Order No.":=Rec.GetFilter("Order No."); // key mapping
                    Rec."Attached By":=UserId;
                    Rec."Attached On":=CurrentDateTime;
                    Rec."File Content".CreateOutStream(OutStreams);
                    Rec.Insert(true);
                end;
            }
            action(DownloadFile)
            {
                Caption = 'Download';
                Image = Export;

                trigger OnAction()
                var
                    InStream: InStream;
                begin
                    Rec.CalcFields("File Content");
                    Rec."File Content".CreateInStream(InStream);
                    DownloadFromStream(InStream, '', '', '', Rec."File Name");
                end;
            }
        }
    }
}
