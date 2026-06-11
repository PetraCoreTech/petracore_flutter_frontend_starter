import '../design_preset.dart';

/// Airbnb-inspired [DesignPreset] — warm accent palette (`#FF385C`),
/// friendlier radii (8/12/16), softer surfaces, and Circular typography.
const DesignPreset airbnbPreset = DesignPreset(
  id: DesignPresetId.airbnb,
  displayName: 'Airbnb-inspired',
  description:
      'Warm accent palette with friendlier radii, softer surfaces, and approachable component shapes.',
  colors: DesignPresetColors({
    'white': '0xffFFFFFF',
    'black': 'Colors.black',
    'brown': '0xff6D3B01',
    'indigo': '0xff01196D',
    'primaryGrading': '0xffFF385C',
    'primary': '0xffFF385C',
    'primaryPressed': '0xffE03050',
    'primaryDisabled': '0xffFF9AAE',
    'primaryDark': '0xffB01030',
    'neutral50': '0xFFF7F7F7',
    'neutral100': '0xffEBEBEB',
    'neutral200': '0xFFDDDDDD',
    'neutral300': '0xFF999999',
    'neutral400': '0xFF555555',
    'neutral500': '0xff333333',
    'neutral600': '0xFF111111',
    'surface001': '0xff222222',
    'technical100': '0xFF717171',
    'warning': '0xffCC7E0A',
    'error': '0xffC31B23',
    'shimmer': 'Color.fromRGBO(219, 219, 219, 1)',
  }),
  typography: DesignPresetTypography(fontFamily: 'Circular'),
  radius: DesignPresetRadius(small: 8, medium: 12, large: 16),
);
