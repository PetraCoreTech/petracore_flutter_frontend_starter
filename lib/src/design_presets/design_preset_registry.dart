import 'design_preset.dart';
import 'presets/airbnb_preset.dart';
import 'presets/apple_preset.dart';
import 'presets/default_preset.dart';
import 'presets/vercel_preset.dart';

/// Registry of all available [DesignPreset]s, providing lookup by
/// [DesignPresetId] and access to the full list.
class DesignPresetRegistry {
  static const Map<DesignPresetId, DesignPreset> _presets = {
    DesignPresetId.defaultPreset: defaultPreset,
    DesignPresetId.vercel: vercelPreset,
    DesignPresetId.airbnb: airbnbPreset,
    DesignPresetId.apple: applePreset,
  };

  /// Returns a list of every registered [DesignPreset].
  static List<DesignPreset> get all => _presets.values.toList();

  /// Looks up and returns the [DesignPreset] for the given [id].
  ///
  /// Throws [ArgumentError] if [id] is not registered.
  static DesignPreset resolve(DesignPresetId id) {
    final preset = _presets[id];
    if (preset == null) {
      throw ArgumentError('Unknown DesignPresetId: $id');
    }
    return preset;
  }

  /// Returns the default [DesignPreset] (the `defaultPreset` entry).
  static DesignPreset get defaultPresetConfig => resolve(DesignPresetId.defaultPreset);
}
