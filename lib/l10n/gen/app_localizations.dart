import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_it.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('de'),
    Locale('fa'),
    Locale('it'),
    Locale('tr'),
    Locale('zh')
  ];

  /// Title of the application
  ///
  /// In en, this message translates to:
  /// **'Ollama'**
  String get appTitle;

  /// Text displayed for new chat option
  ///
  /// In en, this message translates to:
  /// **'New Chat'**
  String get optionNewChat;

  /// Text displayed for settings option
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get optionSettings;

  /// Text displayed for install PWA option
  ///
  /// In en, this message translates to:
  /// **'Install Webapp'**
  String get optionInstallPwa;

  /// Text displayed when no chats are found
  ///
  /// In en, this message translates to:
  /// **'No chats found'**
  String get optionNoChatFound;

  /// Prefix for tips
  ///
  /// In en, this message translates to:
  /// **'Tip: '**
  String get tipPrefix;

  /// First tip displayed in the sidebar
  ///
  /// In en, this message translates to:
  /// **'Edit messages by long taping on them'**
  String get tip0;

  /// Second tip displayed in the sidebar
  ///
  /// In en, this message translates to:
  /// **'Delete messages by double tapping on them'**
  String get tip1;

  /// Third tip displayed in the sidebar
  ///
  /// In en, this message translates to:
  /// **'You can change the theme in settings'**
  String get tip2;

  /// Fourth tip displayed in the sidebar
  ///
  /// In en, this message translates to:
  /// **'Select a multimodal model to input images'**
  String get tip3;

  /// Fifth tip displayed in the sidebar
  ///
  /// In en, this message translates to:
  /// **'Chats are automatically saved'**
  String get tip4;

  /// Text displayed for delete chat option
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteChat;

  /// Text displayed for rename chat option
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get renameChat;

  /// Text displayed for take image button
  ///
  /// In en, this message translates to:
  /// **'Take Image'**
  String get takeImage;

  /// Text displayed for image upload button
  ///
  /// In en, this message translates to:
  /// **'Upload Image'**
  String get uploadImage;

  /// Text displayed when an image is not valid
  ///
  /// In en, this message translates to:
  /// **'Not a valid image'**
  String get notAValidImage;

  /// Title, if 'Generate Title' is executed on a conversation with no text messages
  ///
  /// In en, this message translates to:
  /// **'Image Only Conversation'**
  String get imageOnlyConversation;

  /// Placeholder text for message input
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get messageInputPlaceholder;

  /// Tooltip for attachment button
  ///
  /// In en, this message translates to:
  /// **'Add attachment'**
  String get tooltipAttachment;

  /// Tooltip for send button
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get tooltipSend;

  /// Tooltip for save button
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get tooltipSave;

  /// Tooltip for let AI think button
  ///
  /// In en, this message translates to:
  /// **'Let AI think'**
  String get tooltipLetAIThink;

  /// Tooltip for add host headers button
  ///
  /// In en, this message translates to:
  /// **'Add host headers'**
  String get tooltipAddHostHeaders;

  /// Tooltip for reset button
  ///
  /// In en, this message translates to:
  /// **'Reset current chat'**
  String get tooltipReset;

  /// Tooltip for options button
  ///
  /// In en, this message translates to:
  /// **'Show options'**
  String get tooltipOptions;

  /// Text displayed when no model is selected
  ///
  /// In en, this message translates to:
  /// **'No model selected'**
  String get noModelSelected;

  /// Text displayed when no host is selected
  ///
  /// In en, this message translates to:
  /// **'No host selected, open setting to set one'**
  String get noHostSelected;

  /// Text displayed when no model is selected
  ///
  /// In en, this message translates to:
  /// **'<selector>'**
  String get noSelectedModel;

  /// Title of a new chat
  ///
  /// In en, this message translates to:
  /// **'Unnamed Chat'**
  String get newChatTitle;

  /// Text displayed for add model button
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get modelDialogAddModel;

  /// Title of the add model dialog
  ///
  /// In en, this message translates to:
  /// **'Add new model'**
  String get modelDialogAddPromptTitle;

  /// Description of the add model dialog
  ///
  /// In en, this message translates to:
  /// **'This can have either be a normal name (e.g. \'llama3\') or name and tag (e.g. \'llama3:70b\').'**
  String get modelDialogAddPromptDescription;

  /// Text displayed when the model already exists
  ///
  /// In en, this message translates to:
  /// **'Model already exists'**
  String get modelDialogAddPromptAlreadyExists;

  /// Text displayed when the model name is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid model name'**
  String get modelDialogAddPromptInvalid;

  /// Title of the allow proxy dialog
  ///
  /// In en, this message translates to:
  /// **'Allow Proxy'**
  String get modelDialogAddAllowanceTitle;

  /// Description of the allow proxy dialog
  ///
  /// In en, this message translates to:
  /// **'Ollama App must check if the entered model is valid. For that, we normally send a web request to the Ollama model list and check the status code, but because you\'re using the web client, we can\'t do that directly. Instead, the app will send the request to a different api, hosted by JHubi1, to check for us.\nThis is a one-time request and will only be sent when you add a new model.\nYour IP address will be sent with the request and might be stored for up to ten minutes to prevent spamming with potential harmful intentions.\nIf you accept, your selection will be remembered in the future; if not, nothing will be sent and the model won\'t be added.'**
  String get modelDialogAddAllowanceDescription;

  /// Text displayed for allow button, should be capitalized
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get modelDialogAddAllowanceAllow;

  /// Text displayed for deny button, should be capitalized
  ///
  /// In en, this message translates to:
  /// **'Deny'**
  String get modelDialogAddAllowanceDeny;

  /// Title of the add model assurance dialog
  ///
  /// In en, this message translates to:
  /// **'Add {model}?'**
  String modelDialogAddAssuranceTitle(String model);

  /// Description of the add model assurance dialog
  ///
  /// In en, this message translates to:
  /// **'Pressing \'Add\' will download the model \'{model}\' directly from the Ollama server to your host.\nThis can take a while depending on your internet connection. The action cannot be canceled.\nIf the app is closed during the download, it\'ll resume if you enter the name into the model dialog again.'**
  String modelDialogAddAssuranceDescription(String model);

  /// Text displayed for add button, should be capitalized
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get modelDialogAddAssuranceAdd;

  /// Text displayed for cancel button, should be capitalized
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get modelDialogAddAssuranceCancel;

  /// Text displayed while loading the download progress
  ///
  /// In en, this message translates to:
  /// **'loading progress'**
  String get modelDialogAddDownloadPercentLoading;

  /// Text displayed while downloading a model
  ///
  /// In en, this message translates to:
  /// **'download at {percent}%'**
  String modelDialogAddDownloadPercent(String percent);

  /// Text displayed when the download of a model fails
  ///
  /// In en, this message translates to:
  /// **'Disconnected, try again'**
  String get modelDialogAddDownloadFailed;

  /// Text displayed when the download of a model is successful
  ///
  /// In en, this message translates to:
  /// **'Download successful'**
  String get modelDialogAddDownloadSuccess;

  /// Title of the delete dialog
  ///
  /// In en, this message translates to:
  /// **'Delete Chat'**
  String get deleteDialogTitle;

  /// Description of the delete dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to continue? This will wipe all memory of this chat and cannot be undone.\nTo disable this dialog, visit the settings.'**
  String get deleteDialogDescription;

  /// Text displayed for delete button, should be capitalized
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteDialogDelete;

  /// Text displayed for cancel button, should be capitalized
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get deleteDialogCancel;

  /// Text displayed as description for new title input
  ///
  /// In en, this message translates to:
  /// **'Enter new title'**
  String get dialogEnterNewTitle;

  /// Title of the edit message dialog
  ///
  /// In en, this message translates to:
  /// **'Edit message'**
  String get dialogEditMessageTitle;

  /// Title of the behavior settings section
  ///
  /// In en, this message translates to:
  /// **'Behavior'**
  String get settingsTitleBehavior;

  /// Description of the behavior settings section
  ///
  /// In en, this message translates to:
  /// **'Change the behavior of the AI to your liking.'**
  String get settingsDescriptionBehavior;

  /// Title of the interface settings section
  ///
  /// In en, this message translates to:
  /// **'Interface'**
  String get settingsTitleInterface;

  /// Description of the interface settings section
  ///
  /// In en, this message translates to:
  /// **'Edit how Ollama App looks and behaves.'**
  String get settingsDescriptionInterface;

  /// Title of the voice settings section. Do not translate if not required!
  ///
  /// In en, this message translates to:
  /// **'Voice'**
  String get settingsTitleVoice;

  /// Description of the voice settings section
  ///
  /// In en, this message translates to:
  /// **'Enable voice mode and configure voice settings.'**
  String get settingsDescriptionVoice;

  /// Title of the export settings section
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get settingsTitleExport;

  /// Description of the export settings section
  ///
  /// In en, this message translates to:
  /// **'Export and import your chat history.'**
  String get settingsDescriptionExport;

  /// Title of the about settings section
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsTitleAbout;

  /// Description of the about settings section
  ///
  /// In en, this message translates to:
  /// **'Check for updates and learn more about Ollama App.'**
  String get settingsDescriptionAbout;

  /// Text displayed when settings are saved automatically
  ///
  /// In en, this message translates to:
  /// **'Settings are saved automatically'**
  String get settingsSavedAutomatically;

  /// Text displayed when a feature is in alpha
  ///
  /// In en, this message translates to:
  /// **'alpha'**
  String get settingsExperimentalAlpha;

  /// Description of the alpha feature
  ///
  /// In en, this message translates to:
  /// **'This feature is in alpha and may not work as intended or expected.\nCritical issues and/or permanent critical damage to device and/or used services cannot be ruled out.\nUse at your own risk. No liability on the part of the app author.'**
  String get settingsExperimentalAlphaDescription;

  /// Text displayed when a feature is in alpha
  ///
  /// In en, this message translates to:
  /// **'Alpha feature, hold to learn more'**
  String get settingsExperimentalAlphaFeature;

  /// Text displayed when a feature is in beta
  ///
  /// In en, this message translates to:
  /// **'beta'**
  String get settingsExperimentalBeta;

  /// Description of the beta feature
  ///
  /// In en, this message translates to:
  /// **'This feature is in beta and may not work intended or expected.\nLess severe issues may or may not occur. Damage shouldn\'t be critical.\nUse at your own risk.'**
  String get settingsExperimentalBetaDescription;

  /// Text displayed when a feature is in beta
  ///
  /// In en, this message translates to:
  /// **'Beta feature, hold to learn more'**
  String get settingsExperimentalBetaFeature;

  /// Text displayed when a feature is deprecated
  ///
  /// In en, this message translates to:
  /// **'deprecated'**
  String get settingsExperimentalDeprecated;

  /// Description of the deprecated feature
  ///
  /// In en, this message translates to:
  /// **'This feature is deprecated and will be removed in a future version.\nIt may not work as intended or expected. Use at your own risk.'**
  String get settingsExperimentalDeprecatedDescription;

  /// Text displayed when a feature is deprecated
  ///
  /// In en, this message translates to:
  /// **'Deprecated feature, hold to learn more'**
  String get settingsExperimentalDeprecatedFeature;

  /// Text displayed as description for host input
  ///
  /// In en, this message translates to:
  /// **'Host'**
  String get settingsHost;

  /// Text displayed when the host is valid
  ///
  /// In en, this message translates to:
  /// **'Valid Host'**
  String get settingsHostValid;

  /// Text displayed when the host is being checked
  ///
  /// In en, this message translates to:
  /// **'Checking Host'**
  String get settingsHostChecking;

  /// Text displayed when the host is invalid
  ///
  /// In en, this message translates to:
  /// **'Issue: {type, select, url{Invalid URL} host{Invalid Host} timeout{Request Failed. Server issues} ratelimit{Too many requests} other{Request Failed}}'**
  String settingsHostInvalid(String type);

  /// Text displayed as description for host header input
  ///
  /// In en, this message translates to:
  /// **'Set host header'**
  String get settingsHostHeaderTitle;

  /// Text displayed when the host header is invalid
  ///
  /// In en, this message translates to:
  /// **'The entered text isn\'t a valid header JSON object'**
  String get settingsHostHeaderInvalid;

  /// Text displayed when the host is invalid
  ///
  /// In en, this message translates to:
  /// **'{type, select, url{The URL you entered is invalid. It isn\'t an a standardized URL format.} other{The host you entered is invalid. It cannot be reached. Please check the host and try again.}}'**
  String settingsHostInvalidDetailed(String type);

  /// Text displayed as description for system message input
  ///
  /// In en, this message translates to:
  /// **'System message'**
  String get settingsSystemMessage;

  /// Text displayed as description for use system message toggle
  ///
  /// In en, this message translates to:
  /// **'Use system message'**
  String get settingsUseSystem;

  /// Description of the use system message toggle
  ///
  /// In en, this message translates to:
  /// **'Disables setting the system message above and use the one of the model instead. Can be useful for models with model files'**
  String get settingsUseSystemDescription;

  /// Text displayed as description for disable markdown toggle
  ///
  /// In en, this message translates to:
  /// **'Disable markdown'**
  String get settingsDisableMarkdown;

  /// Text displayed when behavior settings are not updated for older chats
  ///
  /// In en, this message translates to:
  /// **'Behavior settings are not updated for older chats'**
  String get settingsBehaviorNotUpdatedForOlderChats;

  /// Text displayed as description for show model tags toggle
  ///
  /// In en, this message translates to:
  /// **'Show model tags'**
  String get settingsShowModelTags;

  /// Text displayed as description for preload models toggle
  ///
  /// In en, this message translates to:
  /// **'Preload models'**
  String get settingsPreloadModels;

  /// Text displayed as description for reset on model change toggle
  ///
  /// In en, this message translates to:
  /// **'Reset on model change'**
  String get settingsResetOnModelChange;

  /// Text displayed as description for stream request type. Do not translate if not required!
  ///
  /// In en, this message translates to:
  /// **'Stream'**
  String get settingsRequestTypeStream;

  /// Text displayed as description for request request type. Do not translate if not required!
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get settingsRequestTypeRequest;

  /// Text displayed as description for generate titles toggle
  ///
  /// In en, this message translates to:
  /// **'Generate titles'**
  String get settingsGenerateTitles;

  /// Text displayed as description for enable editing toggle
  ///
  /// In en, this message translates to:
  /// **'Message editing'**
  String get settingsEnableEditing;

  /// Text displayed as description for ask before deletion toggle
  ///
  /// In en, this message translates to:
  /// **'Ask before chat deletion'**
  String get settingsAskBeforeDelete;

  /// Text displayed as description for show tips toggle
  ///
  /// In en, this message translates to:
  /// **'Show tips in sidebar'**
  String get settingsShowTips;

  /// Text displayed as description for keep model loaded always toggle
  ///
  /// In en, this message translates to:
  /// **'Keep model always loaded'**
  String get settingsKeepModelLoadedAlways;

  /// Text displayed as description for don't keep model loaded toggle
  ///
  /// In en, this message translates to:
  /// **'Don\'t keep model loaded'**
  String get settingsKeepModelLoadedNever;

  /// Text displayed as description for keep model loaded for toggle
  ///
  /// In en, this message translates to:
  /// **'Set specific time to keep model loaded'**
  String get settingsKeepModelLoadedFor;

  /// Text displayed as description for keep model loaded for set time toggle
  ///
  /// In en, this message translates to:
  /// **'Keep model loaded for {minutes} minutes'**
  String settingsKeepModelLoadedSet(String minutes);

  /// Text displayed as title for the timeout multiplier section
  ///
  /// In en, this message translates to:
  /// **'Timeout multiplier'**
  String get settingsTimeoutMultiplier;

  /// Description of the timeout multiplier section
  ///
  /// In en, this message translates to:
  /// **'Select the multiplier that is applied to every timeout value in the app. Can be useful with a slow internet connection or a slow host.'**
  String get settingsTimeoutMultiplierDescription;

  /// Example for the timeout multiplier
  ///
  /// In en, this message translates to:
  /// **'E.g. message timeout:'**
  String get settingsTimeoutMultiplierExample;

  /// Text displayed as description for enable haptic feedback toggle
  ///
  /// In en, this message translates to:
  /// **'Enable haptic feedback'**
  String get settingsEnableHapticFeedback;

  /// Text displayed as description for maximize on start toggle
  ///
  /// In en, this message translates to:
  /// **'Start maximized'**
  String get settingsMaximizeOnStart;

  /// Text displayed as description for system brightness option
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsBrightnessSystem;

  /// Text displayed as description for light brightness option
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsBrightnessLight;

  /// Text displayed as description for dark brightness option
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsBrightnessDark;

  /// Text displayed as description for device theme option
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get settingsThemeDevice;

  /// Text displayed as description for Ollama theme option
  ///
  /// In en, this message translates to:
  /// **'Ollama'**
  String get settingsThemeOllama;

  /// Text displayed as description for temporary fixes section
  ///
  /// In en, this message translates to:
  /// **'Temporary interface fixes'**
  String get settingsTemporaryFixes;

  /// Description of the temporary fixes section
  ///
  /// In en, this message translates to:
  /// **'Enable temporary fixes for interface issues.\nLong press on the individual options to learn more.'**
  String get settingsTemporaryFixesDescription;

  /// Instructions and warnings for the temporary fixes
  ///
  /// In en, this message translates to:
  /// **'Do not toggle any of these settings unless you know what you are doing! The given solutions might not work as expected.\nThey cannot be seen as final or should be judged as such. Issues might occur.'**
  String get settingsTemporaryFixesInstructions;

  /// Text displayed when no fixes are available
  ///
  /// In en, this message translates to:
  /// **'No fixes available'**
  String get settingsTemporaryFixesNoFixes;

  /// Text displayed while loading voice permissions
  ///
  /// In en, this message translates to:
  /// **'Loading voice permissions ...'**
  String get settingsVoicePermissionLoading;

  /// Text displayed when text-to-speech is not supported
  ///
  /// In en, this message translates to:
  /// **'Text-to-speech not supported'**
  String get settingsVoiceTtsNotSupported;

  /// Description of the text-to-speech not supported message
  ///
  /// In en, this message translates to:
  /// **'Text-to-speech services are not supported for the selected language. Select a different language in the language drawer to reenable them.\nOther services like voice recognition and AI thinking will still work as usual, but interaction might not be as fluent.'**
  String get settingsVoiceTtsNotSupportedDescription;

  /// Text displayed when voice permissions are not granted
  ///
  /// In en, this message translates to:
  /// **'Permissions not granted'**
  String get settingsVoicePermissionNot;

  /// Text displayed when voice mode is not enabled
  ///
  /// In en, this message translates to:
  /// **'Voice mode not enabled'**
  String get settingsVoiceNotEnabled;

  /// Text displayed when voice mode is not supported
  ///
  /// In en, this message translates to:
  /// **'Voice mode not supported'**
  String get settingsVoiceNotSupported;

  /// Text displayed as description for enable voice mode toggle
  ///
  /// In en, this message translates to:
  /// **'Enable voice mode'**
  String get settingsVoiceEnable;

  /// Text displayed when no language is selected
  ///
  /// In en, this message translates to:
  /// **'No language selected'**
  String get settingsVoiceNoLanguage;

  /// Text displayed as description for limit language toggle
  ///
  /// In en, this message translates to:
  /// **'Limit to selected language'**
  String get settingsVoiceLimitLanguage;

  /// Text displayed as description for enable AI punctuation toggle
  ///
  /// In en, this message translates to:
  /// **'Enable AI punctuation'**
  String get settingsVoicePunctuation;

  /// Text displayed as description for export chats button
  ///
  /// In en, this message translates to:
  /// **'Export chats'**
  String get settingsExportChats;

  /// Text displayed when chats are exported successfully
  ///
  /// In en, this message translates to:
  /// **'Chats exported successfully'**
  String get settingsExportChatsSuccess;

  /// Text displayed as description for import chats button
  ///
  /// In en, this message translates to:
  /// **'Import chats'**
  String get settingsImportChats;

  /// Title of the import dialog
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get settingsImportChatsTitle;

  /// Description of the import dialog
  ///
  /// In en, this message translates to:
  /// **'The following step will import the chats from the selected file. This will overwrite all currently available chats.\nDo you want to continue?'**
  String get settingsImportChatsDescription;

  /// Text displayed for import button, should be capitalized
  ///
  /// In en, this message translates to:
  /// **'Import and Erase'**
  String get settingsImportChatsImport;

  /// Text displayed for cancel button, should be capitalized
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get settingsImportChatsCancel;

  /// Text displayed when chats are imported successfully
  ///
  /// In en, this message translates to:
  /// **'Chats imported successfully'**
  String get settingsImportChatsSuccess;

  /// Information displayed for export and import options
  ///
  /// In en, this message translates to:
  /// **'This options allows you to export and import your chat history. This can be useful if you want to transfer your chat history to another device or backup your chat history'**
  String get settingsExportInfo;

  /// Warning displayed for export and import options
  ///
  /// In en, this message translates to:
  /// **'Multiple chat histories won\'t be merged! You\'ll loose your current chat history if you import a new one'**
  String get settingsExportWarning;

  /// Text displayed as description for check for updates button
  ///
  /// In en, this message translates to:
  /// **'Check for updates'**
  String get settingsUpdateCheck;

  /// Text displayed while looking for updates
  ///
  /// In en, this message translates to:
  /// **'Checking for updates ...'**
  String get settingsUpdateChecking;

  /// Text displayed when the app is up to date
  ///
  /// In en, this message translates to:
  /// **'You are on the latest version'**
  String get settingsUpdateLatest;

  /// Text displayed when an update is available
  ///
  /// In en, this message translates to:
  /// **'Update available (v{version})'**
  String settingsUpdateAvailable(String version);

  /// Text displayed when the API rate limit is exceeded
  ///
  /// In en, this message translates to:
  /// **'Can\'t check, API rate limit exceeded'**
  String get settingsUpdateRateLimit;

  /// Text displayed when an issue occurs while checking for updates
  ///
  /// In en, this message translates to:
  /// **'An issue occurred'**
  String get settingsUpdateIssue;

  /// Title of the update dialog
  ///
  /// In en, this message translates to:
  /// **'New version available'**
  String get settingsUpdateDialogTitle;

  /// Description of the update dialog
  ///
  /// In en, this message translates to:
  /// **'A new version of Ollama is available. Do you want to download and install it now?'**
  String get settingsUpdateDialogDescription;

  /// Text displayed as description for change log button
  ///
  /// In en, this message translates to:
  /// **'Change Log'**
  String get settingsUpdateChangeLog;

  /// Text displayed for update button, should be capitalized
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get settingsUpdateDialogUpdate;

  /// Text displayed for cancel button, should be capitalized
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get settingsUpdateDialogCancel;

  /// Text displayed as description for check for updates toggle
  ///
  /// In en, this message translates to:
  /// **'Check for updates on open'**
  String get settingsCheckForUpdates;

  /// Text displayed as description for GitHub button
  ///
  /// In en, this message translates to:
  /// **'GitHub'**
  String get settingsGithub;

  /// Text displayed as description for report issue button
  ///
  /// In en, this message translates to:
  /// **'Report Issue'**
  String get settingsReportIssue;

  /// Text displayed as description for licenses button
  ///
  /// In en, this message translates to:
  /// **'Licenses'**
  String get settingsLicenses;

  /// Text displayed as description for version
  ///
  /// In en, this message translates to:
  /// **'Ollama App v{version}'**
  String settingsVersion(String version);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'fa', 'it', 'tr', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'fa': return AppLocalizationsFa();
    case 'it': return AppLocalizationsIt();
    case 'tr': return AppLocalizationsTr();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
