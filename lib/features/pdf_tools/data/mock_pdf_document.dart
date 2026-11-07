import '../domain/pdf_page_content.dart';

/// Mock 6-page corporate PDF report matching Frame 1 & Frame 3 specs.
class MockPdfDocument {
  MockPdfDocument._();

  static const String fileName = 'Annual_Report_2026_Q3.pdf';

  static const List<PdfPageContent> pages = <PdfPageContent>[
    // Page 1: Financial Highlights
    PdfPageContent(
      pageNumber: 1,
      title: 'Financial Highlights',
      tag: 'AUDITED',
      hasChart: true,
      growthLabel: 'Revenue Growth YoY',
      growthValue: '+28.4%',
      metrics: <String, String>{
        'Operating Margin': '\$4,821,900',
        'EBITDA Conversion': '32.8%',
        'CapEx Allocations': '\$1,240,000',
      },
      paragraphs: <String>[
        'During the fiscal period, the company consolidated its core balance '
            'sheet across digital assets. We achieved record performance in our '
            'Financial Year 2026 forecast models.',
        'Operating expenses decreased by 8.4% through systematic document '
            'pipeline automation. Key operational workflows remain compliant '
            'across ISO 27001 standards.',
      ],
    ),

    // Page 2: Corporate Structure & Governance
    PdfPageContent(
      pageNumber: 2,
      title: 'Corporate Governance',
      tag: 'PAGE 2',
      metrics: <String, String>{
        'Board Independence': '85%',
        'Audit Frequency': 'Quarterly',
        'Risk Oversight Score': '98/100',
      },
      paragraphs: <String>[
        'Our executive leadership maintains strong adherence to global enterprise '
            'compliance standards and continuous stakeholder reporting.',
        'Independent risk audits are conducted quarterly to verify zero data leakage '
            'across localized on-device processing and edge recognition engines.',
      ],
    ),

    // Page 3: Market Expansion (Contains 3rd match)
    PdfPageContent(
      pageNumber: 3,
      title: 'Global Market Expansion',
      tag: 'PAGE 3',
      metrics: <String, String>{
        'Active Jurisdictions': '42 Countries',
        'Enterprise Contracts': '1,280+',
        'Net Retention': '134%',
      },
      paragraphs: <String>[
        'Our cross-border enterprise adoption expanded significantly across Europe and '
            'the Asia-Pacific region during the previous quarters.',
        'The mobile scanner pipeline demonstrated strong financial growth through '
            'streamlined team subscriptions and rapid on-device document extraction.',
      ],
    ),

    // Page 4: Document Pipeline Engineering
    PdfPageContent(
      pageNumber: 4,
      title: 'Pipeline Engineering',
      tag: 'PAGE 4',
      metrics: <String, String>{
        'Average Processing': '34 ms',
        'Compression Ratio': '72%',
        'Offline Availability': '100%',
      },
      paragraphs: <String>[
        'High-performance rasterization and client-side vector processing enable '
            'instantaneous document manipulation without cloud dependency.',
        'Memory optimization algorithms guarantee sub-second rendering for complex '
            'multi-page portfolios and high-resolution camera captures.',
      ],
    ),

    // Page 5: Security Architecture & Cryptography
    PdfPageContent(
      pageNumber: 5,
      title: 'Cryptographic Security',
      tag: 'PAGE 5',
      metrics: <String, String>{
        'Cipher Standard': 'AES-256 GCM',
        'Key Management': 'Hardware Enclave',
        'Zero-Trust Matrix': 'Level 4',
      },
      paragraphs: <String>[
        'Document encryption applies military-grade AES-256 ciphers protected by on-device '
            'secure enclaves before files are written to internal flash storage.',
        'Password-protected PDFs ensure sensitive contracts, NDAs, and corporate ledgers '
            'remain unreadable to unauthorized external tools.',
      ],
    ),

    // Page 6: Forward-Looking Outlook
    PdfPageContent(
      pageNumber: 6,
      title: 'Forward-Looking Outlook',
      tag: 'PAGE 6',
      metrics: <String, String>{
        'Projected Target': 'Q4 2026',
        'Platform Coverage': 'Android / iOS',
        'User Target': '10M MAU',
      },
      paragraphs: <String>[
        'Looking forward into the upcoming quarters, the company will accelerate edge '
            'AI capabilities, intelligent form detection, and seamless multi-device sync.',
        'Continuous investment in developer toolkits and native UI performance guarantees '
            'best-in-class user satisfaction across global markets.',
      ],
    ),
  ];
}

