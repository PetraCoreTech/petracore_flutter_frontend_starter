import 'design_preset.dart';
import 'presets/airbnb_preset.dart';
import 'presets/apple_preset.dart';
import 'presets/default_preset.dart';
import 'presets/vercel_preset.dart';

class DesignPresetRegistry {
  static const Map<DesignPresetId, DesignPreset> _presets = {
    DesignPresetId.defaultPreset: defaultPreset,
    DesignPresetId.vercel: vercelPreset,
    DesignPresetId.airbnb: airbnbPreset,
    DesignPresetId.apple: applePreset,
  };

  static List<DesignPreset> get all => _presets.values.toList();

  static DesignPreset resolve(DesignPresetId id) {
    final preset = _presets[id];
    if (preset == null) {
      throw ArgumentError('Unknown DesignPresetId: $id');
    }
    return preset;
  }

  static DesignPreset get defaultPresetConfig => resolve(DesignPresetId.defaultPreset);
}
