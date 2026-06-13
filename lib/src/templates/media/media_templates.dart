import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/template_index.dart';

class MediaTemplates {
  MediaTemplates(this.config);

  final ProjectConfig config;

  String get mediaIndex => mediaIndexTemplate(config);

  /// Data/Enums
  String get mediaType => mediaTypeTemplate();
  String get mediaActions => mediaActionsTemplate();

  /// Data/Extensions
  String get mediaTypeExtension => mediaTypeExtensionTemplate(config);
  String get mediaBytesExtension => mediaBytesExtensionTemplate(config);
  String get mediaSizeExtension => mediaSizeExtensionTemplate(config);
  String get mediaListExtension => mediaListExtensionTemplate(config);
  String get xfileExtension => xfileExtensionTemplate(config);

  /// Data/Parsers
  String get mediaTypeParser => mediaTypeParserTemplate(config);

  /// Data/Models
  String get attachmentModel => attachmentModelTemplate(config);
  String get attachedMediaModel => attachedMediaModelTemplate(config);
  String get uint8ListConverter => uint8ListConverterTemplate(config.packageName);

  /// Data/Remote/Cloudinary
  String get cloudinaryService => cloudinaryServiceTemplate(config);
  String get fileUploadDto => fileUploadDtoTemplate(config);
  String get deleteUploadDto => deleteUploadDtoTemplate(config);

  /// Data/Remote/Upload
  String get uploadRepository => uploadRepositoryTemplate(config);
  String get uploadParams => uploadParamsTemplate(config);

  /// Data/Remote/Download
  String get downloadRepository => downloadRepositoryTemplate(config);
  String get downloadDto => downloadDtoTemplate();

  /// Data/Domain
  String get uploadUseCases => uploadUseCasesTemplate(config);
  String get downloadUseCases => downloadUseCasesTemplate(config);

  /// Data/Remote
  String get mediaRepository => mediaRepositoryTemplate(config);

  /// Presentation/Entities
  String get downloadEntity => downloadEntityTemplate();

  /// Presentation/Helpers
  String get mediaHelper => mediaHelperTemplate(config);

  /// Presentation/Widgets
  String get photoDisplay => photoDisplayTemplate(config);
  String get mediaDisplay => mediaDisplayTemplate(config);
  String get videoPlayer => videoPlayerTemplate(config);
  String get mediaPickerField => mediaPickerFieldTemplate(config);
  String get selectedMediaItem => selectedMediaItemTemplate(config);

  /// Presentation/Controllers/BLocs
  String get uploadActionBloc => uploadActionBlocTemplate(config);
  String get uploadActionEvent => uploadActionEventTemplate(config);
  String get uploadActionState => uploadActionStateTemplate(config);
  String get downloadActionBloc => downloadActionBlocTemplate(config);
  String get downloadActionEvent => downloadActionEventTemplate(config);
  String get downloadActionState => downloadActionStateTemplate(config);

  /// Presentation/Controllers
  String get mediaControllerIndex => mediaControllerIndexTemplate();
  String get mediaBlocProvider => mediaBlocProviderTemplate(config);
}
