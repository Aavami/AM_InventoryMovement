(function () {
  let canvas, ctx, drawing = false, lastX = 0, lastY = 0;

  function ensureUI() {
    document.body.innerHTML = `
      <div class="ise-signature-wrapper">
        <canvas id="signature-canvas"></canvas>
        <div class="ise-signature-actions">
          <button id="submit-signature" type="button">Submit</button>
          <button id="clear-signature" type="button">Clear</button>
        </div>
      </div>`;

    canvas = document.getElementById('signature-canvas');
    ctx = canvas.getContext('2d');
    ctx.lineWidth = 2;
    ctx.lineCap = 'round';
    ctx.strokeStyle = '#000';

    resizeCanvas();
    window.addEventListener('resize', resizeCanvas);

    // Pointer events support mouse + touch + pen
    canvas.addEventListener('pointerdown', onDown);
    canvas.addEventListener('pointermove', onMove);
    canvas.addEventListener('pointerup', onUp);
    canvas.addEventListener('pointercancel', onUp);
    canvas.addEventListener('pointerleave', onUp);

    document.getElementById('clear-signature').addEventListener('click', clear);
    document.getElementById('submit-signature').addEventListener('click', submit);
  }

  function resizeCanvas() {
    if (!canvas) return;
    const ratio = Math.max(window.devicePixelRatio || 1, 1);
    const rect = canvas.getBoundingClientRect();
    canvas.width = rect.width * ratio;
    canvas.height = rect.height * ratio;
    ctx.setTransform(ratio, 0, 0, ratio, 0, 0);
    // keep existing drawing? simplest: do nothing; user can re-sign if resized.
  }

  function getPos(e) {
    const rect = canvas.getBoundingClientRect();
    return {
      x: e.clientX - rect.left,
      y: e.clientY - rect.top
    };
  }

  function onDown(e) {
    drawing = true;
    canvas.setPointerCapture(e.pointerId);
    const p = getPos(e);
    lastX = p.x; lastY = p.y;
  }

  function onMove(e) {
    if (!drawing) return;
    const p = getPos(e);
    ctx.beginPath();
    ctx.moveTo(lastX, lastY);
    ctx.lineTo(p.x, p.y);
    ctx.stroke();
    lastX = p.x; lastY = p.y;
  }

  function onUp(e) {
    drawing = false;
  }

  function isEmpty() {
    const pixels = ctx.getImageData(0,0,canvas.width,canvas.height).data;
    for (let i=3; i<pixels.length; i+=4) {
      if (pixels[i] !== 0) return false;
    }
    return true;
  }

  function submit() {
    if (isEmpty()) {
      alert('Please provide a signature first.');
      return;
    }
    const dataUrl = canvas.toDataURL('image/png');
    if (window.Microsoft && Microsoft.Dynamics && Microsoft.Dynamics.NAV) {
      Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('SignatureSubmitted', [dataUrl]);
    }
  }

  function clear() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    if (window.Microsoft && Microsoft.Dynamics && Microsoft.Dynamics.NAV) {
      Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('SignatureCleared', []);
    }
  }

  // BC calls
  window.InitializeSignaturePad = function () {
    if (!canvas) ensureUI();
  };

  window.Clear = function () {
    if (!canvas) ensureUI();
    clear();
  };

  // initialize once
  ensureUI();
})();
