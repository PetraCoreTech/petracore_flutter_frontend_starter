import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String coreBarrelTemplate(ProjectConfig config) => '''
export 'package:flextras/flextras.dart';
export 'package:flutter/material.dart' hide Notification, Route;
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:flutter_hooks/flutter_hooks.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:flutter_styled_toast/flutter_styled_toast.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:gap/gap.dart';
export 'package:go_router/go_router.dart';
export 'package:mix/mix.dart' hide \$token, MixDurationInt;
export 'package:${config.packageName}/navigation/navigation_index.dart';

export 'components/components_index.dart';
export 'data/data_index.dart';
export 'utils/utils_index.dart';
''';
