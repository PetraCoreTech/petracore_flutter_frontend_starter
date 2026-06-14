import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/template_index.dart';

class MapTemplates {
  MapTemplates(this.config);

  final ProjectConfig config;

  String get mapIndex => mapIndexTemplate(config);

  /// Data/Enums
  String get businessStatus => businessStatusTemplate();

  /// Data/Parsers
  String get businessStatusParser => businessStatusParserTemplate(config);
  String get locationParser => locationParserTemplate();

  /// Data/Models
  String get userLocationModel => userLocationModelTemplate(config);
  String get nearbyPlaceModel => nearbyPlaceModelTemplate(config);

  /// Data/Remote/DTOs
  String get placeParams => placeParamsTemplate();

  /// Data/Remote
  String get locationService => locationServiceTemplate(config);
  String get locationRepository => locationRepositoryTemplate(config);

  /// Data/Helpers
  String get locationHelper => locationHelperTemplate(config);

  /// Data/UseCases
  String get mapUseCases => mapUseCasesTemplate(config);

  /// Presentation/Controllers
  String get mapControllersIndex => mapControllersIndexTemplate();
  String get mapBlocProvider => mapBlocProviderTemplate(config);

  /// Presentation/Controllers/Blocs/Location
  String get locationEvent => locationEventTemplate();
  String get locationState => locationStateTemplate();
  String get locationBloc => locationBlocTemplate(config);

  /// Presentation/Controllers/Blocs/NearbyPlaces
  String get nearbyPlacesEvent => nearbyPlacesEventTemplate();
  String get nearbyPlacesState => nearbyPlacesStateTemplate();
  String get nearbyPlacesBloc => nearbyPlacesBlocTemplate(config);

  /// Presentation/Controllers/Cubits
  String get locationCubit => locationCubitTemplate(config);
  String get nearbyPlacesCubit => nearbyPlacesCubitTemplate(config);

  /// Presentation/Controllers/BlocListeners
  String get locationBlocListener => locationBlocListenerTemplate(config);

  /// Presentation/Screens
  String get mapScreensIndex => mapScreensIndexTemplate();
  String get mapScreen => mapScreenTemplate(config);

  /// Setup Guide
  String get mapSetupGuide => mapSetupGuideTemplate(config);
}
