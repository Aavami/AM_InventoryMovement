tableextension 80110 "ISE COH Signature" extends "ISE Customer Order Header"
{
    fields
    {
        field(55000; Signature; Blob)
        {
            Caption = 'Signature';
            SubType = Bitmap;
            DataClassification = CustomerContent;
        }
    }
}
