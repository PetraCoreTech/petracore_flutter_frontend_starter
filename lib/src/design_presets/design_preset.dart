/// Identifies a built-in design preset that controls the visual language
/// of a generated PetraCore project.
enum DesignPresetId {
  /// The default PetraCore design language — balanced, clean, and modern.
  defaultPreset,

  /// Vercel-inspired monochrome palette with restrained accents and tight radii.
  vercel,

  /// Airbnb-inspired warm accent palette with friendlier radii and surfaces.
  airbnb,

  /// Apple-inspired premium whitespace, neutral palette, and precise radii.
  apple,
}

/// Holds a map of named color tokens (e.g. `primary`, `neutral100`, `error`)
/// to their hex or [Color] string representations for the preset.
class DesignPresetColors {
  /// Map of color token names to their string color values.
  final Map<String, String> values;

  /// Creates a [DesignPresetColors] with the given [values] map.
  const DesignPresetColors(this.values);
}

/// Defines the typography settings for a design preset.
class DesignPresetTypography {
  /// The primary font family name (e.g. `"Inter"`, `"SF Pro Display"`).
  final String fontFamily;

  /// Creates a [DesignPresetTypography] with the given [fontFamily].
  const DesignPresetTypography({required this.fontFamily});
}

/// Defines the border-radius scale for a design preset at three sizes.
class DesignPresetRadius {
  /// Small border radius value in logical pixels.
  final int small;

  /// Medium border radius value in logical pixels.
  final int medium;

  /// Large border radius value in logical pixels.
  final int large;

  /// Creates a [DesignPresetRadius] with the three radius tiers.
  const DesignPresetRadius({
    required this.small,
    required this.medium,
    required this.large,
  });
}

/// A complete design preset combining color tokens, typography, and border
/// radii into a cohesive visual language for a generated PetraCore project.
class DesignPreset {
  /// The unique identifier for this preset.
  final DesignPresetId id;

  /// A human-readable name (e.g. `"Default PetraCore"`, `"Vercel-inspired"`).
  final String displayName;

  /// A short description of the design language this preset provides.
  final String description;

  /// The color token definitions for this preset.
  final DesignPresetColors colors;

  /// The typography settings for this preset.
  final DesignPresetTypography typography;

  /// The border-radius scale for this preset.
  final DesignPresetRadius radius;

  /// Creates a [DesignPreset] with all required visual properties.
  const DesignPreset({
    required this.id,
    required this.displayName,
    required this.description,
    required this.colors,
    required this.typography,
    required this.radius,
  });
}
