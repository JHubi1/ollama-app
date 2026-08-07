// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String appTitle(String env, String title) {
    return 'Ollama';
  }

  @override
  String get learnMore => 'Learn more';

  @override
  String get optionNewChat => 'New Chat';

  @override
  String get optionSettings => 'Settings';

  @override
  String get optionInstallPwa => 'Install Webapp';

  @override
  String get optionNoChatFound => 'No chats found';

  @override
  String optionNoChatFoundSearch(String query) {
    return 'No chats found for ‘$query’';
  }

  @override
  String get optionSearchChats => 'Search through chats';

  @override
  String get optionChatDetails => 'Chat details';

  @override
  String get optionChatDetailsNoChat => 'No chat selected';

  @override
  String get tipPrefix => 'Tip: ';

  @override
  String get tip0 => 'Edit messages by long taping on them';

  @override
  String get tip1 => 'Delete messages by double tapping on them';

  @override
  String get tip2 => 'You can change the theme in settings';

  @override
  String get tip3 => 'Select a multimodal model to input images';

  @override
  String get tip4 => 'Chats are automatically saved';

  @override
  String get deleteChat => 'Delete';

  @override
  String get renameChat => 'Rename';

  @override
  String get takeImage => 'Take Image';

  @override
  String get uploadImage => 'Upload Image';

  @override
  String newChatGreeting1(String user) {
    return 'What’s on your mind, $user?';
  }

  @override
  String newChatGreeting2(String user) {
    return 'Good to see you, $user.';
  }

  @override
  String newChatGreeting3(String user) {
    return 'What can I do for you, $user?';
  }

  @override
  String newChatGreeting4(String user) {
    return 'How can I help you today, $user?';
  }

  @override
  String newChatGreeting5(String user) {
    return 'What would you like to talk about, $user?';
  }

  @override
  String get newChatGreetingNameFallback => 'user';

  @override
  String messageInputPlaceholder(String model) {
    return 'Message';
  }

  @override
  String get messageInputPlaceholderModelPlaceholder => 'model';

  @override
  String get tooltipMessageOptions => 'Message options';

  @override
  String get tooltipSend => 'Send';

  @override
  String tooltipLetAIThink(String model) {
    return 'Let AI think';
  }

  @override
  String get tooltipAddHostHeaders => 'Add host headers';

  @override
  String get tooltipReset => 'Reset current chat';

  @override
  String get tooltipOptions => 'Show options';

  @override
  String get noModelSelected => 'No model selected';

  @override
  String get noHostSelected => 'No host selected, open setting to set one';

  @override
  String get noSelectedModel => '<selector>';

  @override
  String get newChatTitle => 'Unnamed Chat';

  @override
  String get modelDialogTitle => 'Select a model';

  @override
  String get modelDialogAdd => 'Add';

  @override
  String get modelDialogRefresh => 'Refresh';

  @override
  String get modelDialogAddPromptTitle => 'Add new model';

  @override
  String get modelDialogAddPromptDescription =>
      'This can have either be a normal name (e.g. \'llama3\') or name and tag (e.g. \'llama3:70b\').';

  @override
  String get modelDialogAddCurrently => 'Currently downloading:';

  @override
  String get modelDialogAddPromptAlreadyExists => 'Model already exists';

  @override
  String get modelDialogAddPromptInvalid => 'Invalid model name';

  @override
  String get modelDialogAddPromptNotFound =>
      'Couldn’t find your model on the server. Please check the spelling and try again.';

  @override
  String get modelDialogAddPromptNetworkError =>
      'Network error while checking model. Please check your connection and try again.';

  @override
  String get modelDialogAddPromptCorruptionError =>
      'The API returned “EOF”; your server was likely restarted while downloading the model previously.';

  @override
  String get modelDialogAddPromptCorruptionErrorSolution =>
      'Alternatively, you can run the following command on your Linux host directly:\nIf you see a new error, try running the command with “sudo” placed in front of it.';

  @override
  String get modelDialogAddCancelTitle => 'Cancel download?';

  @override
  String get modelDialogAddCancelConfirm => 'Cancel';

  @override
  String get modelDialogAddCancelHide => 'Hide';

  @override
  String get modelDialogAddDownloadSuccess => 'Download successful';

  @override
  String get deleteDialogTitle => 'Delete Chat';

  @override
  String get deleteDialogDescription =>
      'Are you sure you want to continue? This will wipe all memory of this chat and cannot be undone.\nTo disable this dialog, visit the settings.';

  @override
  String get deleteDialogDelete => 'Delete';

  @override
  String get deleteDialogCancel => 'Cancel';

  @override
  String get errorGuardTitle => 'ErrorGuard';

  @override
  String get errorGuardDetails => 'Details';

  @override
  String get errorGuardException => 'Exception';

  @override
  String get errorGuardStackTrace => 'Stack Trace';

  @override
  String get errorGuardReport => 'Report';

  @override
  String get dialogEnterNewTitle => 'Enter new title';

  @override
  String get dialogEditMessageTitle => 'Edit message';

  @override
  String get settingsTitleOverview => 'Overview';

  @override
  String get settingsDescriptionOverview =>
      'General settings regarding your host.';

  @override
  String get settingsTitleBehavior => 'Behavior';

  @override
  String get settingsDescriptionBehavior =>
      'Change the behavior of the AI to your liking.';

  @override
  String get settingsTitleInterface => 'Interface';

  @override
  String get settingsDescriptionInterface =>
      'Edit how Ollama App looks and behaves.';

  @override
  String get settingsTitleVoice => 'Voice';

  @override
  String get settingsDescriptionVoice =>
      'Enable voice mode and configure voice settings.';

  @override
  String get settingsTitleExport => 'Export';

  @override
  String get settingsDescriptionExport =>
      'Export and import your chat history.';

  @override
  String get settingsTitleAbout => 'About';

  @override
  String get settingsDescriptionAbout =>
      'Check for updates and learn more about Ollama App.';

  @override
  String get settingsExperimentalAlpha => 'alpha';

  @override
  String get settingsExperimentalAlphaDescription =>
      'This feature is in alpha and may not work as intended or expected.\nCritical issues and/or permanent critical damage to device and/or used services cannot be ruled out.\nUse at your own risk. No liability on the part of the app author.';

  @override
  String get settingsExperimentalAlphaFeature =>
      'Alpha feature, hold to learn more';

  @override
  String get settingsExperimentalBeta => 'beta';

  @override
  String get settingsExperimentalBetaDescription =>
      'This feature is in beta and may not work intended or expected.\nLess severe issues may or may not occur. Damage shouldn\'t be critical.\nUse at your own risk.';

  @override
  String get settingsExperimentalBetaFeature =>
      'Beta feature, hold to learn more';

  @override
  String get settingsExperimentalDeprecated => 'deprecated';

  @override
  String get settingsExperimentalDeprecatedDescription =>
      'This feature is deprecated and will be removed in a future version.\nIt may not work as intended or expected. Use at your own risk.';

  @override
  String get settingsExperimentalDeprecatedFeature =>
      'Deprecated feature, hold to learn more';

  @override
  String get settingsHost => 'Host';

  @override
  String get settingsHostMissing => 'No host set';

  @override
  String get settingsHostValid => 'Valid Host';

  @override
  String get settingsHostChecking => 'Checking Host';

  @override
  String settingsHostInvalid(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'url': 'Invalid URL',
      'host': 'Invalid Host',
      'timeout': 'Request Failed. Server issues',
      'ratelimit': 'Too many requests',
      'other': 'Request Failed',
    });
    return 'Issue: $_temp0';
  }

  @override
  String settingsHostInvalidDetailed(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'url':
          'The URL you entered is invalid. It isn\'t an a standardized URL format.',
      'other':
          'The host you entered is invalid. It cannot be reached. Please check the host and try again.',
    });
    return '$_temp0';
  }

  @override
  String get settingsHostHeaderHeaderName => 'Header';

  @override
  String get settingsHostHeaderHeaderValue => 'Value';

  @override
  String settingsHostHeaderUnsupported(String header) {
    return 'The header “$header” may not be supported.';
  }

  @override
  String settingsHostHeaderDuplicate(String header) {
    return 'The header “$header” is already set.';
  }

  @override
  String get settingsSystemMessage => 'System message';

  @override
  String get settingsUseSystem => 'Use system message';

  @override
  String get settingsUseSystemDescription =>
      'Disables setting the system message above and use the one of the model instead. Can be useful for models with model files';

  @override
  String get settingsDisableMarkdown => 'Disable markdown';

  @override
  String get settingsBehaviorNotUpdatedForOlderChats =>
      'Behavior settings are not updated for older chats';

  @override
  String get settingsShowModelTags => 'Show model tags';

  @override
  String get settingsPreloadModels => 'Preload models';

  @override
  String get settingsResetOnModelChange => 'Reset on model change';

  @override
  String get settingsRequestTypeStream => 'Stream';

  @override
  String get settingsRequestTypeRequest => 'Request';

  @override
  String get settingsGenerateTitles => 'Generate titles';

  @override
  String get settingsEnableEditing => 'Enable editing of messages';

  @override
  String get settingsAskBeforeDelete => 'Ask before chat deletion';

  @override
  String get settingsShowTips => 'Show tips in sidebar';

  @override
  String get settingsKeepModelLoadedAlways => 'Keep model always loaded';

  @override
  String get settingsKeepModelLoadedNever => 'Don\'t keep model loaded';

  @override
  String get settingsKeepModelLoadedFor =>
      'Set specific time to keep model loaded';

  @override
  String settingsKeepModelLoadedSet(String minutes) {
    return 'Keep model loaded for $minutes minutes';
  }

  @override
  String get settingsTimeoutMultiplier => 'Timeout multiplier';

  @override
  String get settingsTimeoutMultiplierDescription =>
      'Select the multiplier that is applied to every timeout value in the app. Can be useful with a slow internet connection or a slow host.';

  @override
  String get settingsTimeoutMultiplierExample => 'E.g. message timeout:';

  @override
  String get settingsEnableHapticFeedback => 'Enable haptic feedback';

  @override
  String get settingsMaximizeOnStart => 'Start maximized';

  @override
  String get settingsBrightnessSystem => 'System';

  @override
  String get settingsBrightnessLight => 'Light';

  @override
  String get settingsBrightnessDark => 'Dark';

  @override
  String get settingsThemeDevice => 'Device';

  @override
  String get settingsThemeOllama => 'Ollama';

  @override
  String get settingsTemporaryFixes => 'Temporary interface fixes';

  @override
  String get settingsTemporaryFixesDescription =>
      'Enable temporary fixes for interface issues.\nLong press on the individual options to learn more.';

  @override
  String get settingsTemporaryFixesInstructions =>
      'Do not toggle any of these settings unless you know what you are doing! The given solutions might not work as expected.\nThey cannot be seen as final or should be judged as such. Issues might occur.';

  @override
  String get settingsTemporaryFixesNoFixes => 'No fixes available';

  @override
  String get settingsVoicePermissionLoading => 'Loading voice permissions ...';

  @override
  String get settingsVoiceTtsNotSupported => 'Text-to-speech not supported';

  @override
  String get settingsVoiceTtsNotSupportedDescription =>
      'Text-to-speech services are not supported for the selected language. Select a different language in the language drawer to reenable them.\nOther services like voice recognition and AI thinking will still work as usual, but interaction might not be as fluent.';

  @override
  String get settingsVoicePermissionNot => 'Permissions not granted';

  @override
  String get settingsVoiceNotEnabled => 'Voice mode not enabled';

  @override
  String get settingsVoiceNotSupported => 'Voice mode not supported';

  @override
  String get settingsVoiceEnable => 'Enable voice mode';

  @override
  String get settingsVoiceNoLanguage => 'No language selected';

  @override
  String get settingsVoiceLimitLanguage => 'Limit to selected language';

  @override
  String get settingsVoicePunctuation => 'Enable AI punctuation';

  @override
  String get settingsExportChats => 'Export chats';

  @override
  String get settingsExportChatsSuccess => 'Chats exported successfully';

  @override
  String get settingsImportChats => 'Import chats';

  @override
  String get settingsImportChatsTitle => 'Import';

  @override
  String get settingsImportChatsDescription =>
      'The following step will import the chats from the selected file. This will overwrite all currently available chats.\nDo you want to continue?';

  @override
  String get settingsImportChatsImport => 'Import and Erase';

  @override
  String get settingsImportChatsCancel => 'Cancel';

  @override
  String get settingsImportChatsSuccess => 'Chats imported successfully';

  @override
  String get settingsExportInfo =>
      'This options allows you to export and import your chat history. This can be useful if you want to transfer your chat history to another device or backup your chat history';

  @override
  String get settingsExportWarning =>
      'Multiple chat histories won\'t be merged! You\'ll loose your current chat history if you import a new one';

  @override
  String get settingsUpdateCheck => 'Check for updates';

  @override
  String get settingsUpdateChecking => 'Checking for updates ...';

  @override
  String get settingsUpdateLatest => 'You are on the latest version';

  @override
  String settingsUpdateAvailable(String version) {
    return 'Update available (v$version)';
  }

  @override
  String get settingsUpdateRateLimit => 'Can\'t check, API rate limit exceeded';

  @override
  String get settingsUpdateIssue => 'An issue occurred';

  @override
  String get settingsUpdateDialogTitle => 'New version available';

  @override
  String get settingsUpdateDialogDescription =>
      'A new version of Ollama is available. Do you want to download and install it now?';

  @override
  String get settingsUpdateChangeLog => 'Change Log';

  @override
  String get settingsUpdateDialogUpdate => 'Update';

  @override
  String get settingsUpdateDialogCancel => 'Cancel';

  @override
  String get settingsCheckForUpdates => 'Check for updates on open';

  @override
  String get settingsGithub => 'GitHub';

  @override
  String get settingsReportIssue => 'Report Issue';

  @override
  String get settingsLicenses => 'Licenses';

  @override
  String settingsVersion(String version) {
    return 'Ollama App v$version';
  }
}
