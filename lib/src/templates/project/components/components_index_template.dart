import '../../../generators/project_generator.dart';

String componentsIndexTemplate(ProjectConfig config) => '''
// Components barrel file for ${config.projectName}
// This file exports all the reusable UI components

// App Bars
export 'app_bars/app_bar_v1.dart';
export 'app_bars/tab_bar_v1.dart';

// Buttons
export 'buttons/app_button.dart';
export 'buttons/app_outline_button.dart';
export 'buttons/app_text_button.dart';

// Dialog & Toast
export 'dialog/action_dialog.dart';
export 'dialog/dialog_v1.dart';
export 'dialog/dialog_v2.dart';
export 'dialog/info_dialog.dart';
export 'dialog/toast/toast_type.dart';
export 'dialog/toast/toast_v1.dart';
export 'dialog/toast/toast_v2.dart';
export 'dialog/utils/content_container.dart';

// Displays
export 'displays/initials_display.dart';
export 'displays/mark_down_display.dart';

// Frames
export 'frames/icon_frame.dart';
export 'frames/list_frame.dart';
export 'frames/profile_frame.dart';
export 'frames/screen_frame.dart';

// Helpers
export 'helpers/alert_dialog_helper.dart';
export 'helpers/date_time_helper.dart';
export 'helpers/overlay_helper.dart';
export 'helpers/snackbar_helper.dart';
export 'helpers/toast_helper.dart';
export 'helpers/tooltip_helper.dart';

// Icon & Dividers
export 'icon/custom_icon.dart';
export 'icon/divider_v1.dart';
export 'icon/dot.dart';
export 'icon/more_icon.dart';

// Input Fields
export 'input_fields/base_text_field.dart';
export 'input_fields/password_field.dart';
export 'input_fields/phone_field.dart';
export 'input_fields/select_fields/drop_down_field_v1.dart';
export 'input_fields/select_fields/search_field.dart';
export 'input_fields/select_fields/select_field_v1.dart';
export 'input_fields/utils/form_field_frame.dart';
export 'input_fields/utils/input_field_validator.dart';

// Rich Texts
export 'rich_texts/auth_rich_text.dart';
export 'rich_texts/hyper_link_text.dart';
export 'rich_texts/password_strength_checker.dart';

// Scaffolds
export 'scaffolds/base_scaffold.dart';

// States
export 'states/loading_indicator.dart';
export 'states/info_display.dart';
export 'states/loading_overlay_v1.dart';
export 'states/loading_shimmer.dart';

// Tiles
export 'tiles/expansion_tile_v1.dart';
export 'tiles/list_tile_v1.dart';
''';
