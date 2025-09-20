import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String componentsIndexTemplate(ProjectConfig config) => '''
/// App Bars
export 'app_bars/app_bar_v1.dart';
export 'app_bars/persistent_header_v1.dart';
export 'app_bars/tab_bar_v1.dart';

/// Buttons
export 'buttons/app_button.dart';
export 'buttons/app_outline_button.dart';
export 'buttons/app_text_button.dart';

/// Custom
export 'custom/custom_icon.dart';
export 'custom/divider_v1.dart';
export 'custom/dot.dart';
export 'custom/expansion_tile_v1.dart';
export 'custom/hyper_link_text.dart';
export 'custom/initials_display.dart';
export 'custom/list_tile_v1.dart';
export 'custom/password_strength_checker.dart';

/// Dialog
export 'dialog/action_dialog.dart';
export 'dialog/bottom_sheet_select_content.dart';
export 'dialog/toast_v1.dart';

/// Frames
export 'frames/icon_frame.dart';
export 'frames/list_frame.dart';
export 'frames/profile_frame.dart';
export 'frames/screen_frame.dart';

/// Helpers
export 'helpers/date_time_helper.dart';
export 'helpers/dialog_helper.dart';
export 'helpers/snackbar_helper.dart';
export 'helpers/toast_helper.dart';

/// Input Fields
export 'input_fields/base_text_field.dart';
export 'input_fields/input_field.dart';
export 'input_fields/input_item.dart';
export 'input_fields/password_field.dart';
export 'input_fields/phone_field.dart';
export 'input_fields/search_feature_field.dart';
export 'input_fields/search_input_field.dart';

/// Scaffolds
export 'scaffolds/base_scaffold.dart';
export 'scaffolds/scaffold_v1.dart';

/// States
export 'states/loading_indicator.dart';
export 'states/info_display.dart';
export 'states/loading_overlay_v1.dart';
export 'states/loading_shimmer.dart';
''';
