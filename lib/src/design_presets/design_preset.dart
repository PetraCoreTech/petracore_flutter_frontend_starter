enum DesignPresetId {
  defaultPreset,
  vercel,
  airbnb,
  apple,
}

class DesignPresetColors {
  final Map<String, String> values;

  const DesignPresetColors(this.values);
}

class DesignPresetTypography {
  final String fontFamily;

  const DesignPresetTypography({required this.fontFamily});
}

class DesignPresetRadius {
  final int small;
  final int medium;
  final int large;

  const DesignPresetRadius({
    required this.small,
    required this.medium,
    required this.large,
  });
}

class DesignPreset {
  final DesignPresetId id;
  final String displayName;
  final String description;
  final DesignPresetColors colors;
  final DesignPresetTypography typography;
  final DesignPresetRadius radius;

  const DesignPreset({
    required this.id,
    required this.displayName,
    required this.description,
    required this.colors,
    required this.typography,
    required this.radius,
  });
}
