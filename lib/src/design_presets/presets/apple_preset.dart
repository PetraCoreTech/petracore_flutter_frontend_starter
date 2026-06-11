import '../design_preset.dart';

/// Apple-inspired [DesignPreset] — premium whitespace, neutral palette,
/// precise radii (6/10/14), subdued chrome, and SF Pro Display typography.
const DesignPreset applePreset = DesignPreset(
  id: DesignPresetId.apple,
  displayName: 'Apple-inspired',
  description:
      'Premium whitespace, neutral palette, precise but gentle radii, and subdued chrome.',
  colors: DesignPresetColors({
    'white': '0xffFFFFFF',
    'black': 'Colors.black',
    'brown': '0xff6D3B01',
    'indigo': '0xff01196D',
    'primaryGrading': '0xff007AFF',
    'primary': '0xff007AFF',
    'primaryPressed': '0xff0062CC',
    'primaryDisabled': '0xff7DB8FF',
    'primaryDark': '0xff004099',
    'neutral50': '0xFFF5F5F7',
    'neutral100': '0xffE8E8ED',
    'neutral200': '0xFFC7C7CC',
    'neutral300': '0xFF8E8E93',
    'neutral400': '0xFF48484A',
    'neutral500': '0xff363639',
    'neutral600': '0xFF1C1C1E',
    'surface001': '0xff2C2C2E',
    'technical100': '0xFF636366',
    'warning': '0xffCC7E0A',
    'error': '0xffFF3B30',
    'shimmer': 'Color.fromRGBO(199, 199, 204, 1)',
  }),
  typography: DesignPresetTypography(fontFamily: 'SF Pro Display'),
  radius: DesignPresetRadius(small: 6, medium: 10, large: 14),
);
