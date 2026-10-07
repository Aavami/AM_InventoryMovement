controladdin "ISE Signature Pad"
{
    RequestedHeight = 240;
    RequestedWidth = 520;
    VerticalStretch = true;
    HorizontalStretch = true;
    Scripts = 'src/ControlAddIns/Resources/ise-signature-host.js';
    StyleSheets = 'src/ControlAddIns/Resources/ise-signature.css';
    StartupScript = 'src/ControlAddIns/Resources/ise-signature-host.js';

    event SignatureSubmitted(SignatureDataUrl: Text);
    event SignatureCleared();
    procedure InitializeSignaturePad();
    procedure Clear();
}
