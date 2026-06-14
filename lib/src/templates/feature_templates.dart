import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/template_index.dart';

class FeatureTemplates {
  FeatureTemplates(this.config);

  final FeatureConfig config;

  ProjectConfig get projectConfig => config.projectConfig;

  /// Feature
  String get featureIndex => featureIndexTemplate(config);

  /// Feature/Data
  String get dataModel => dataModelTemplate(config);
  String get createDto => createDtoTemplate(config);
  String get updateDto => updateDtoTemplate(config);
  String get params => paramsTemplate(config);
  String get repository => repositoryTemplate(config);
  String get service => serviceTemplate(projectConfig, config);
  String get repositoriesBarrel => repositoriesBarrelTemplate(config);
  String get useCases => useCasesTemplate(config);

  /// Feature/Presentation
  String get actionBloc => actionBlocTemplate(config);
  String get actionBlocEvent => actionBlocEventTemplate(config);
  String get actionBlocState => actionBlocStateTemplate(config);
  String get dataBloc => dataBlocTemplate(config);
  String get dataBlocEvent => dataBlocEventTemplate(config);
  String get dataBlocState => dataBlocStateTemplate(config);
  String get cubit => cubitTemplate(config);
  String get blocProvider => blocProviderTemplate(config);
  String get controllersBarrel => controllersBarrelTemplate(config);
  String get screen => screenTemplate(config);
  String get listScreen => listScreenTemplate(config);
  String get screensBarrel => screensBarrelTemplate(config);
  String get presentationBarrel => presentationBarrelTemplate(config);

  /// Pagination Feature
  String get paginationIndex => paginationIndexTemplate(projectConfig.projectName);
  String get paginationBloc => paginationBlocTemplate(projectConfig.projectName);
  String get paginationEvent => paginationEventTemplate(projectConfig.projectName);
  String get paginationState => paginationStateTemplate(projectConfig.projectName);
  String get paginatedListView => paginatedListViewTemplate(projectConfig.projectName);
  String get paginatedListBuilder => paginatedListBuilderTemplate(projectConfig.projectName);

  /// Notification Feature
  String get notificationIndex => notificationIndexTemplate(projectConfig.projectName);
  /// Notification Data Layer
  String get notificationTypeEnum => notificationTypeEnumTemplate(projectConfig.projectName);
  String get remoteMessageExtension => remoteMessageExtensionTemplate(projectConfig.projectName);
  String get notificationModel => notificationModelTemplate(projectConfig.projectName);
  String get notificationTypeConverter => notificationTypeConverterTemplate(projectConfig.projectName);
  String get notificationParams => notificationParamsTemplate(projectConfig.projectName);
  String get notifyDto => notifyDtoTemplate(projectConfig.projectName);
  String get notificationService => notificationServiceTemplate(projectConfig.projectName);
  String get fcmNotificationService => fcmNotificationServiceTemplate(projectConfig.projectName);
  String get notificationRepository => notificationRepositoryTemplate(projectConfig.projectName);
  String get notificationUseCases => notificationUseCasesTemplate(projectConfig.projectName);
  /// Notification Presentation
  String get notificationCubit => notificationCubitTemplate(projectConfig.projectName);
  String get notificationBlocProvider => notificationBlocProviderTemplate(projectConfig.projectName);
  String get notificationControllerIndex => notificationControllerIndexTemplate(projectConfig.projectName);
  String get notificationBadge => notificationBadgeTemplate(projectConfig.projectName);
  String get notificationCard => notificationCardTemplate(projectConfig.projectName);
  String get notificationList => notificationListTemplate(projectConfig.projectName);
  String get notificationTile => notificationTileTemplate(projectConfig.projectName);

  /// Chat Feature
  String get chatIndex => chatIndexTemplate(projectConfig.projectName);
  String get chatModel => chatModelTemplate(projectConfig.projectName);
  String get messageModel => messageModelTemplate(projectConfig.projectName);
  String get chatDto => chatDtoTemplate(projectConfig.projectName);
  String get markChatReadDto => markChatReadDtoTemplate(projectConfig.projectName);
  String get messageDto => messageDtoTemplate(projectConfig.projectName);
  String get sendMessageDto => sendMessageDtoTemplate(projectConfig.projectName);
  String get fireStoreChatService => fireStoreChatServiceTemplate(projectConfig.projectName);
  String get chatUseCases => chatUseCasesTemplate(projectConfig.projectName);
  String get chatActionEvent => chatActionEventTemplate(projectConfig.projectName);
  String get chatActionState => chatActionStateTemplate(projectConfig.projectName);
  String get chatActionBloc => chatActionBlocTemplate(projectConfig.projectName);
  String get chatCubit => chatCubitTemplate(projectConfig.projectName);
  String get chatUserCubit => chatUserCubitTemplate(projectConfig.projectName);
  String get savedChatCubit => savedChatCubitTemplate(projectConfig.projectName);
  String get chatBlocProvider => chatBlocProviderTemplate(projectConfig.projectName);
  String get chatControllerIndex => chatControllerIndexTemplate(projectConfig.projectName);
  String get chatEntity => chatEntityTemplate(projectConfig.projectName);
  String get savedChat => savedChatTemplate(projectConfig.projectName);
  String get chatHelper => chatHelperTemplate(projectConfig.projectName);
  String get chatScreen => chatScreenTemplate(projectConfig.projectName);
  String get chatsScreen => chatsScreenTemplate(projectConfig.projectName);
  String get chatScreenIndex => chatScreenIndexTemplate(projectConfig.projectName);
  String get chatBubble => chatBubbleTemplate(projectConfig.projectName);
  String get chatBuilder => chatBuilderTemplate(projectConfig.projectName);
  String get chatSearchUserBuilder => chatSearchUserBuilderTemplate(projectConfig.projectName);
  String get chatTile => chatTileTemplate(projectConfig.projectName);
  String get composeMessage => composeMessageTemplate(projectConfig.projectName);
  String get messageBuilder => messageBuilderTemplate(projectConfig.projectName);
  String get searchUserDisplay => searchUserDisplayTemplate(projectConfig.projectName);

  /// Chatbot Feature
  String get chatbotIndex => chatbotIndexTemplate(projectConfig.projectName);
  String get chatMessageEntity => chatMessageEntityTemplate(projectConfig.projectName);
  String get chatConversationEntity => chatConversationEntityTemplate(projectConfig.projectName);
  String get chatbotCubit => chatbotCubitTemplate(projectConfig.projectName);
  String get chatbotBlocProvider => chatbotBlocProviderTemplate(projectConfig.projectName);
  String get chatbotControllerIndex => chatbotControllerIndexTemplate(projectConfig.projectName);
  String get messageBubble => messageBubbleTemplate(projectConfig.projectName);
  String get chatInputField => chatInputFieldTemplate(projectConfig.projectName);
  String get typingIndicator => typingIndicatorTemplate(projectConfig.projectName);
  String get conversationList => conversationListTemplate(projectConfig.projectName);
  String get chatbotScreen => chatbotScreenTemplate(projectConfig.projectName);
  String get chatMessageModel => chatMessageModelTemplate(projectConfig.projectName);
  String get chatbotService => chatbotServiceTemplate(projectConfig.projectName);
  String get chatbotRepository => chatbotRepositoryTemplate(projectConfig.projectName);
  String get chatbotUseCases => chatbotUseCasesTemplate(projectConfig.projectName);

  /// Survey Feature
  String get surveyIndex => surveyIndexTemplate(projectConfig.projectName);
  String get surveyModeCubit => surveyModeCubitTemplate(projectConfig.projectName);
  String get surveyBlocProvider => surveyBlocProviderTemplate(projectConfig.projectName);
  String get surveyControllerIndex => surveyControllerIndexTemplate(projectConfig.projectName);
  String get surveyAnswerEntity => surveyAnswerEntityTemplate(projectConfig.projectName);
  String get surveyQuestionEntity => surveyQuestionEntityTemplate(projectConfig.projectName);
  String get surveyModeEnum => surveyModeEnumTemplate(projectConfig.projectName);
  String get surveyBuilder => surveyBuilderTemplate(projectConfig.projectName);
  String get surveyOverviewMode => overviewModeTemplate(projectConfig.projectName);
  String get surveyQuestionMode => questionModeTemplate(projectConfig.projectName);
  String get surveyAnswerDisplay => surveyAnswerDisplayTemplate(projectConfig.projectName);
  String get surveyQuestionDisplay => surveyQuestionDisplayTemplate(projectConfig.projectName);
  String get surveyOptionSelector => surveyOptionSelectorTemplate(projectConfig.projectName);
}
