import '../design_preset.dart';

const DesignPreset vercelPreset = DesignPreset(
  id: DesignPresetId.vercel,
  displayName: 'Vercel-inspired',
  description:
      'Monochrome precision with restrained accent usage, tight radii, and crisp typography.',
  colors: DesignPresetColors({
    'white': '0xffFFFFFF',
    'black': 'Colors.black',
    'brown': '0xff6D3B01',
    'indigo': '0xff01196D',
    'primaryGrading': '0xff000000',
    'primary': '0xff000000',
    'primaryPressed': '0xff333333',
    'primaryDisabled': '0xff888888',
    'primaryDark': '0xff000000',
    'neutral50': '0xFFFAFAFA',
    'neutral100': '0xffEAEAEA',
    'neutral200': '0xFF999999',
    'neutral300': '0xFF666666',
    'neutral400': '0xFF444444',
    'neutral500': '0xff2A2A2A',
    'neutral600': '0xFF111111',
    'surface001': '0xff000000',
    'technical100': '0xFF333333',
    'warning': '0xffCC7E0A',
    'error': '0xffE53E3E',
    'shimmer': 'Color.fromRGBO(200, 200, 200, 1)',
  }),
  typography: DesignPresetTypography(fontFamily: 'Inter'),
  radius: DesignPresetRadius(small: 2, medium: 4, large: 6),
);
