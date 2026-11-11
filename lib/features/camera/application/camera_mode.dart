/// Supported camera modes for document scanning.
enum CameraMode {
  idCard('ID Card'),
  document('Document'),
  book('Book'),
  photo('Photo'),
  signature('Signature'),
  qrScanner('QR Scanner'),
  ocrText('OCR Text');

  const CameraMode(this.label);

  /// Human-readable label displayed in the camera mode strip.
  final String label;
}
