/// Options for ID Card capture mode.
enum IdScanSides {
  single('Single side', '1 side only'),
  both('Both sides', 'Front and back on one page');

  const IdScanSides(this.title, this.subtitle);

  final String title;
  final String subtitle;
}

