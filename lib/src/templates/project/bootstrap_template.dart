String bootstrapTemplate(String presetName) {
  final appUiKitPreset = _appUiKitPresetName(presetName);
  return '''
import 'dart:async';
import 'dart:developer';

import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(\${bloc.runtimeType}, \$change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(\${bloc.runtimeType}, \$error, \$stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();

  AppUiKit.initialize(
    config: const AppUiKitConfig(
      fontFamily: 'Plus Jakarta Sans',
      preset: AppUiKitPreset.$appUiKitPreset,
    ),
  );

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  runApp(await builder());
}
''';
}

String _appUiKitPresetName(String presetName) {
  // CLI names map to AppUiKitPreset names; only 'default' diverges.
  if (presetName == 'default') return 'baseline';
  return presetName;
}
