// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String appTitle(String env, String title) {
    String _temp0 = intl.Intl.selectLogic(env, {
      'short': 'Ollama',
      'integrated': '$title - Ollama App',
      'other': 'Ollama App',
    });
    return '$_temp0';
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
  String get optionNoChatFound => 'No chats';

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
  String get tip0 => 'Edit messages by long tapping on them';

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
  String get takeImage => 'Camera';

  @override
  String get uploadImage => 'Gallery';

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
    return 'Ask $model';
  }

  @override
  String get messageInputPlaceholderModelPlaceholder => 'model';

  @override
  String get tooltipMessageOptions => 'Message options';

  @override
  String get tooltipSend => 'Send';

  @override
  String tooltipLetAIThink(String model) {
    return 'Generate with $model';
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
  String get noHostSelected => 'No host selected, open settings to set one.';

  @override
  String get noSelectedModel => '<model>';

  @override
  String get newChatTitle => 'Untitled Chat';

  @override
  String get modelDialogTitle => 'Select a model';

  @override
  String get modelDialogAdd => 'Add';

  @override
  String get modelDialogRefresh => 'Refresh';

  @override
  String get modelDialogAddPromptTitle => 'Add model';

  @override
  String get modelDialogAddPromptDescription =>
      'This can either be a normal name (e.g. “llama3”) or a name together with a tag (e.g. “llama3:70b”).';

  @override
  String get modelDialogAddCurrently => 'Currently downloading:';

  @override
  String get modelDialogAddPromptAlreadyExists =>
      'Model already exists. Try refreshing if it was deleted.';

  @override
  String get modelDialogAddPromptInvalid =>
      'Couldn’t read your model name correctly. Please check the spelling and try again.';

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
  String get modelDialogAddDownloadSuccess =>
      'Download successful. Set as current model.';

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
      'This feature is in alpha and may not work as intended or expected.\nCritical issues and/or permanent critical damage to device and/or connected services cannot be ruled out.\nUse at your own risk. No liability on the part of the app author.';

  @override
  String get settingsExperimentalAlphaFeature =>
      'Alpha feature, hold to learn more';

  @override
  String get settingsExperimentalBeta => 'beta';

  @override
  String get settingsExperimentalBetaDescription =>
      'This feature is in beta and may not work as intended or expected.\nLess severe issues may or may not occur. Damage shouldn’t be critical.\nUse at your own risk.';

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
      'invalidUrl': 'Invalid URL',
      'unreachable': 'Host unreachable',
      'undetectable': 'Host not an Ollama server',
      'timeout': 'Connection timed out',
      'outdated': 'Outdated Ollama version',
      'other': 'Invalid host',
    });
    return '$_temp0';
  }

  @override
  String settingsHostInvalidDetailed(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'invalidUrl': 'The URL you entered isn’t in a valid format.',
      'unreachable':
          'The host is invalid or unreachable, possibly due to a wrong address or network issue.',
      'undetectable':
          'The host is reachable but doesn’t respond as expected by Ollama App.\nIt may not be an Ollama server. Are you sure you entered it correctly?',
      'timeout':
          'The host couldn’t be reached in time.\nTry increasing the timeout multiplier in interface settings.',
      'outdated':
          'The host is running an Ollama version incompatible with this app.\nPlease update both the host and this app, if possible.',
      'other': 'The host you entered is invalid.',
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
      'Disables setting the system message above and uses the one from the model’s Modelfile instead. Can be useful for models with model files.';

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
  String get settingsEnableEditing => 'Message editing';

  @override
  String get settingsAskBeforeDelete => 'Ask before chat deletion';

  @override
  String get settingsShowTips => 'Show tips in sidebar';

  @override
  String get settingsKeepModelLoadedAlways => 'Keep model always loaded';

  @override
  String get settingsKeepModelLoadedNever => 'Don’t keep model loaded';

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
      'Do not toggle any of these settings unless you know what you are doing! The given solutions might not work as expected.\nThey should not be considered final or judged as such. Issues might occur.';

  @override
  String get settingsTemporaryFixesNoFixes => 'No fixes available';

  @override
  String get settingsVoicePermissionLoading => 'Loading voice permissions...';

  @override
  String get settingsVoiceTtsNotSupported => 'Text-to-speech not supported';

  @override
  String get settingsVoiceTtsNotSupportedDescription =>
      'Text-to-speech services are not supported for the selected language. Select a different language in the language drawer to re-enable them.\nOther services like voice recognition and AI thinking will still work as usual, but interaction might not be as fluent.';

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
      'These options allow you to export and import your chat history. This can be useful if you want to transfer your chat history to another device or back up your chat history.';

  @override
  String get settingsExportWarning =>
      'Multiple chat histories won’t be merged! You’ll lose your current chat history if you import a new one.';

  @override
  String get settingsUpdateCheck => 'Check for updates';

  @override
  String get settingsUpdateChecking => 'Checking for updates...';

  @override
  String get settingsUpdateLatest => 'You are on the latest version';

  @override
  String settingsUpdateAvailable(String version) {
    return 'Update available (v$version)';
  }

  @override
  String get settingsUpdateRateLimit => 'Can’t check, API rate limit exceeded';

  @override
  String get settingsUpdateIssue => 'An issue occurred';

  @override
  String get settingsUpdateDialogTitle => 'New version available';

  @override
  String get settingsUpdateDialogDescription =>
      'A new version of Ollama App is available. Do you want to download and install it now?';

  @override
  String get settingsUpdateChangeLog => 'Change Log';

  @override
  String get settingsUpdateDialogUpdate => 'Update';

  @override
  String get settingsUpdateDialogCancel => 'Cancel';

  @override
  String get settingsCheckForUpdates => 'Check for updates on startup';

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
