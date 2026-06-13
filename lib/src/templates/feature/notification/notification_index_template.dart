String notificationIndexTemplate(String projectName) => '''
/* Data */
export 'data/enums/notification_type.dart';
export 'data/extensions/remote_message_extension.dart';
export 'data/models/notification_model.dart';
export 'data/remote/dtos/notification_params.dart';
export 'data/remote/dtos/notify_dto.dart';
export 'data/remote/fcm_notification_service.dart';
export 'data/remote/notification_repository.dart';
export 'data/remote/notification_service.dart';
export 'data/use_cases/notification_use_cases.dart';
/* Presentation */
export 'presentation/controllers/notification_controller_index.dart';
export 'presentation/widgets/notification_badge.dart';
export 'presentation/widgets/notification_card.dart';
export 'presentation/widgets/notification_list.dart';
export 'presentation/widgets/notification_tile.dart';
''';
