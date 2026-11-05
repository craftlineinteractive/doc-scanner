/// Options for Book capture mode.
enum BookScanType {
  singlePage(
    'Single page',
    'Scan one book page at a time',
  ),
  twoPages(
    'Two pages (auto split)',
    'Captures both pages and separates them',
  ),
  flattenCurved(
    'Flatten curved page',
    'Removes book binding curvature with AI',
  );

  const BookScanType(this.title, this.subtitle);

  final String title;
  final String subtitle;
}

