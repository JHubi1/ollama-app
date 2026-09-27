// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Ollama';

  @override
  String get optionNewChat => 'New Chat';

  @override
  String get optionSettings => 'Settings';

  @override
  String get optionInstallPwa => 'Install Webapp';

  @override
  String get optionNoChatFound => 'No chats found';

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
  String get notAValidImage => 'Not a valid image';

  @override
  String get imageOnlyConversation => 'Image Only Conversation';

  @override
  String get messageInputPlaceholder => 'Message';

  @override
  String get tooltipAttachment => 'Add attachment';

  @override
  String get tooltipSend => 'Send';

  @override
  String get tooltipSave => 'Save';

  @override
  String get tooltipLetAIThink => 'Let AI think';

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
  String get modelDialogAddModel => 'Add';

  @override
  String get modelDialogAddPromptTitle => 'Add new model';

  @override
  String get modelDialogAddPromptDescription => 'This can have either be a normal name (e.g. \'llama3\') or name and tag (e.g. \'llama3:70b\').';

  @override
  String get modelDialogAddPromptAlreadyExists => 'Model already exists';

  @override
  String get modelDialogAddPromptInvalid => 'Invalid model name';

  @override
  String get modelDialogAddAllowanceTitle => 'Allow Proxy';

  @override
  String get modelDialogAddAllowanceDescription => 'Ollama App must check if the entered model is valid. For that, we normally send a web request to the Ollama model list and check the status code, but because you\'re using the web client, we can\'t do that directly. Instead, the app will send the request to a different api, hosted by JHubi1, to check for us.\nThis is a one-time request and will only be sent when you add a new model.\nYour IP address will be sent with the request and might be stored for up to ten minutes to prevent spamming with potential harmful intentions.\nIf you accept, your selection will be remembered in the future; if not, nothing will be sent and the model won\'t be added.';

  @override
  String get modelDialogAddAllowanceAllow => 'Allow';

  @override
  String get modelDialogAddAllowanceDeny => 'Deny';

  @override
  String modelDialogAddAssuranceTitle(String model) {
    return 'Add $model?';
  }

  @override
  String modelDialogAddAssuranceDescription(String model) {
    return 'Pressing \'Add\' will download the model \'$model\' directly from the Ollama server to your host.\nThis can take a while depending on your internet connection. The action cannot be canceled.\nIf the app is closed during the download, it\'ll resume if you enter the name into the model dialog again.';
  }

  @override
  String get modelDialogAddAssuranceAdd => 'Add';

  @override
  String get modelDialogAddAssuranceCancel => 'Cancel';

  @override
  String get modelDialogAddDownloadPercentLoading => 'loading progress';

  @override
  String modelDialogAddDownloadPercent(String percent) {
    return 'download at $percent%';
  }

  @override
  String get modelDialogAddDownloadFailed => 'Disconnected, try again';

  @override
  String get modelDialogAddDownloadSuccess => 'Download successful';

  @override
  String get deleteDialogTitle => 'Delete Chat';

  @override
  String get deleteDialogDescription => 'Are you sure you want to continue? This will wipe all memory of this chat and cannot be undone.\nTo disable this dialog, visit the settings.';

  @override
  String get deleteDialogDelete => 'Delete';

  @override
  String get deleteDialogCancel => 'Cancel';

  @override
  String get dialogEnterNewTitle => 'Enter new title';

  @override
  String get dialogEditMessageTitle => 'Edit message';

  @override
  String get settingsTitleBehavior => 'Behavior';

  @override
  String get settingsDescriptionBehavior => 'Change the behavior of the AI to your liking.';

  @override
  String get settingsTitleInterface => 'Interface';

  @override
  String get settingsDescriptionInterface => 'Edit how Ollama App looks and behaves.';

  @override
  String get settingsTitleVoice => 'Voice';

  @override
  String get settingsDescriptionVoice => 'Enable voice mode and configure voice settings.';

  @override
  String get settingsTitleExport => 'Export';

  @override
  String get settingsDescriptionExport => 'Export and import your chat history.';

  @override
  String get settingsTitleAbout => 'About';

  @override
  String get settingsDescriptionAbout => 'Check for updates and learn more about Ollama App.';

  @override
  String get settingsSavedAutomatically => 'Settings are saved automatically';

  @override
  String get settingsExperimentalAlpha => 'alpha';

  @override
  String get settingsExperimentalAlphaDescription => 'This feature is in alpha and may not work as intended or expected.\nCritical issues and/or permanent critical damage to device and/or used services cannot be ruled out.\nUse at your own risk. No liability on the part of the app author.';

  @override
  String get settingsExperimentalAlphaFeature => 'Alpha feature, hold to learn more';

  @override
  String get settingsExperimentalBeta => 'beta';

  @override
  String get settingsExperimentalBetaDescription => 'This feature is in beta and may not work intended or expected.\nLess severe issues may or may not occur. Damage shouldn\'t be critical.\nUse at your own risk.';

  @override
  String get settingsExperimentalBetaFeature => 'Beta feature, hold to learn more';

  @override
  String get settingsExperimentalDeprecated => 'deprecated';

  @override
  String get settingsExperimentalDeprecatedDescription => 'This feature is deprecated and will be removed in a future version.\nIt may not work as intended or expected. Use at your own risk.';

  @override
  String get settingsExperimentalDeprecatedFeature => 'Deprecated feature, hold to learn more';

  @override
  String get settingsHost => 'Host';

  @override
  String get settingsHostValid => 'Valid Host';

  @override
  String get settingsHostChecking => 'Checking Host';

  @override
  String settingsHostInvalid(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'url': 'Invalid URL',
        'host': 'Invalid Host',
        'auth': 'Authentication failed',
        'timeout': 'Request Failed. Server issues',
        'ratelimit': 'Too many requests',
        'other': 'Request Failed',
      },
    );
    return 'Issue: $_temp0';
  }

  @override
  String get settingsHostHeaderTitle => 'Set host header';

  @override
  String get settingsHostHeaderInvalid => 'The entered text isn\'t a valid header JSON object';

  @override
  String settingsHostInvalidDetailed(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'url': 'The URL you entered is invalid. Use a full URL starting with http:// or https:// — for example http://localhost:11434 for a local Ollama server, or https://ollama.com for Ollama Cloud. Do not add a trailing slash or an /api path.',
        'host': 'The host you entered is invalid. It cannot be reached. Please check the host and try again.',
        'auth': 'The server rejected the request (401/403). If you connect to Ollama Cloud (https://ollama.com), enter your API key in the token field below — you can create or copy it at https://ollama.com/keys — and save it. If you use a self-hosted server, check the Authorization header configured for the host.',
        'other': 'The host you entered is invalid. It cannot be reached. Please check the host and try again.',
      },
    );
    return '$_temp0';
  }

  @override
  String get settingsApiTokenInvalid => 'API token rejected';

  @override
  String get settingsApiTokenInvalidDetailed => 'The API token was rejected by the server (401/403). Check that it is copied exactly as shown at https://ollama.com/keys — a new key can be created on that page — and save it again. The token must be set while the host is https://ollama.com.';

  @override
  String get settingsApiTokenVerified => 'API token saved and verified';

  @override
  String get settingsApiToken => 'Ollama Cloud API Token';

  @override
  String get settingsApiTokenHint => 'Paste token from ollama.com';

  @override
  String get tooltipShowToken => 'Show token';

  @override
  String get tooltipHideToken => 'Hide token';

  @override
  String voiceLanguageInstruction(String language) {
    return 'You must write in the following language: $language!';
  }

  @override
  String get settingsSystemMessage => 'System message';

  @override
  String get settingsUseSystem => 'Use system message';

  @override
  String get settingsUseSystemDescription => 'Disables setting the system message above and use the one of the model instead. Can be useful for models with model files';

  @override
  String get settingsDisableMarkdown => 'Disable markdown';

  @override
  String get settingsBehaviorNotUpdatedForOlderChats => 'Behavior settings are not updated for older chats';

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
  String get settingsKeepModelLoadedNever => 'Don\'t keep model loaded';

  @override
  String get settingsKeepModelLoadedFor => 'Set specific time to keep model loaded';

  @override
  String settingsKeepModelLoadedSet(String minutes) {
    return 'Keep model loaded for $minutes minutes';
  }

  @override
  String get settingsTimeoutMultiplier => 'Timeout multiplier';

  @override
  String get settingsTimeoutMultiplierDescription => 'Select the multiplier that is applied to every timeout value in the app. Can be useful with a slow internet connection or a slow host.';

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
  String get settingsTemporaryFixesDescription => 'Enable temporary fixes for interface issues.\nLong press on the individual options to learn more.';

  @override
  String get settingsTemporaryFixesInstructions => 'Do not toggle any of these settings unless you know what you are doing! The given solutions might not work as expected.\nThey cannot be seen as final or should be judged as such. Issues might occur.';

  @override
  String get settingsTemporaryFixesNoFixes => 'No fixes available';

  @override
  String get settingsVoicePermissionLoading => 'Loading voice permissions ...';

  @override
  String get settingsVoiceTtsNotSupported => 'Text-to-speech not supported';

  @override
  String get settingsVoiceTtsNotSupportedDescription => 'Text-to-speech services are not supported for the selected language. Select a different language in the language drawer to reenable them.\nOther services like voice recognition and AI thinking will still work as usual, but interaction might not be as fluent.';

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
  String get settingsImportChatsDescription => 'The following step will import the chats from the selected file. This will overwrite all currently available chats.\nDo you want to continue?';

  @override
  String get settingsImportChatsImport => 'Import and Erase';

  @override
  String get settingsImportChatsCancel => 'Cancel';

  @override
  String get settingsImportChatsSuccess => 'Chats imported successfully';

  @override
  String get settingsExportInfo => 'This options allows you to export and import your chat history. This can be useful if you want to transfer your chat history to another device or backup your chat history';

  @override
  String get settingsExportWarning => 'Multiple chat histories won\'t be merged! You\'ll loose your current chat history if you import a new one';

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
  String get settingsUpdateDialogDescription => 'A new version of Ollama is available. Do you want to download and install it now?';

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

  @override
  String get settingsTitleAccessibility => 'Accessibility';

  @override
  String get settingsDescriptionAccessibility =>
      'Accessibility statement, test results and how to report a problem.';

  @override
  String get accessibilityStatementTitle => 'Accessibility statement';

  @override
  String get accessibilityCommitmentIntro =>
      'Ollama must be usable by people of all abilities, in every language we ship. Voice control, screen readers, keyboard navigation and high-contrast rendering are first-class ways of using this app — not afterthoughts.';

  @override
  String get accessibilityCommitmentDetails =>
      'In practice this means: every interactive control has a name that screen readers announce (including the voice-mode state), buttons keep a minimum touch target of 48dp, keyboard focus follows the visual order of the interface, status messages are announced while they change, and the interface stays usable at large text scales and in both light and dark themes.';

  @override
  String get accessibilityConformanceTitle => 'Conformance status';

  @override
  String get accessibilityConformanceStatus =>
      'This app is designed to conform with the Web Content Accessibility Guidelines (WCAG) 2.2 Level AA. The conformance has not been independently certified by a third party; it is based on our own automated testing. Where feasible we go beyond AA and apply WCAG AAA measures, which are listed below.';

  @override
  String get accessibilityAaaMeasuresTitle => 'Exceeding AA (AAA measures)';

  @override
  String get accessibilityAaaMeasures =>
      'The main text uses 21:1 contrast in both themes (AAA requires 7:1), muted secondary text uses 10:1 or better, status colours for success and warnings meet AAA contrast in both themes, and error text in the dark theme meets AAA contrast. AAA additionally requires measures that are not practical in a chat application of this size (for example 7:1 contrast on absolutely all text and reading-level limits), so we target AA as the guarantee and treat these AAA measures as enhancements.';

  @override
  String get accessibilityAodaTitle =>
      'Accessibility for Ontarians with Disabilities Act (AODA)';

  @override
  String get accessibilityAodaText =>
      'Ontario\'s Accessibility for Ontarians with Disabilities Act (AODA) requires digital products to meet WCAG 2.0/2.1 Level AA. The WCAG 2.2 Level AA target of this app meets and exceeds that baseline. Feedback on accessibility is welcomed through the contact form on this page, in line with AODA\'s requirement to make feedback channels accessible.';

  @override
  String get accessibilityStandardsEuropeTitle =>
      'European standards (EN 301 549)';

  @override
  String get accessibilityStandardsEuropeText =>
      'In the European Union, harmonized standard EN 301 549 defines the ICT accessibility requirements of the European Accessibility Act, which references WCAG 2.1 Level AA. The WCAG 2.2 Level AA target of this app covers those requirements, supporting the European accessibility obligations that apply from 28 June 2025.';

  @override
  String get accessibilityStandardsUsTitle =>
      'United States standards (ADA / Section 508)';

  @override
  String get accessibilityStandardsUsText =>
      'In the United States, the Americans with Disabilities Act (ADA) is the general non-discrimination baseline, and Section 508 of the Rehabilitation Act requires WCAG 2.0 Level AA for federal technology (Section 504 extends similar obligations to funded programs). The WCAG 2.2 Level AA target of this app meets and exceeds those baselines.';

  @override
  String get accessibilityKnownIssuesTitle => 'Known limitations';

  @override
  String get accessibilityKnownIssues =>
      'The desktop window title-bar buttons (minimize, maximize, close) are provided by the operating system integration and are not reachable by the app\'s screen-reader tree. The chat library renders a small amount of its own interface text, which may not yet be available in all languages. In voice mode, the response text is faded near the edge of the screen and very long chat lines can be truncated with an ellipsis when the system text size is increased significantly.';

  @override
  String accessibilityLastValidated(String version) {
    return 'Automated checks last validated against Ollama App v$version.';
  }

  @override
  String get accessibilityTestsTitle => 'Test results';

  @override
  String get accessibilityTestsIntro =>
      'The following automated accessibility checks are part of the test suite of this app and run on every commit:';

  @override
  String get accessibilityTestsCheckColumn => 'Check';

  @override
  String get accessibilityTestsStatusColumn => 'Status';

  @override
  String get accessibilityTestsPass => 'Pass';

  @override
  String get accessibilityTestsCiNote =>
      'The full suite (static analysis plus automated tests) runs on every commit in the continuous integration pipeline.';

  @override
  String get accessibilityTestContrast =>
      'Text contrast meets WCAG levels in light and dark themes';

  @override
  String get accessibilityTestLabeledTapTarget =>
      'Tappable targets have screen-reader labels';

  @override
  String get accessibilityTestAndroidTapTarget =>
      'Touch targets are at least 48x48dp (Android guideline)';

  @override
  String get accessibilityTestIosTapTarget =>
      'Touch targets are at least 44x44dp (iOS guideline)';

  @override
  String get accessibilityTestSemanticsPresent =>
      'Screen-reader labels exist for all custom controls';

  @override
  String get accessibilityTestTraversalOrder =>
      'Keyboard focus order follows the visual order';

  @override
  String get accessibilityTestLocalesRender =>
      'All interface languages render without errors';

  @override
  String get accessibilityTestFormValidation =>
      'Form fields announce validation errors';

  @override
  String get accessibilityContactTitle => 'Report an accessibility issue';

  @override
  String get accessibilityContactIntro =>
      'Use this form to request accessibility information, ask for a resolution, or report an accessibility barrier. Your report is composed into a message that you can send by email or as a public issue on GitHub.';

  @override
  String get accessibilityFormName => 'Name (optional)';

  @override
  String get accessibilityFormEmail => 'Email (optional)';

  @override
  String get accessibilityFormAssistiveTech =>
      'Assistive technology used (optional)';

  @override
  String get accessibilityFormDescription => 'Describe the issue (required)';

  @override
  String get accessibilityFormDescriptionHint =>
      'What were you trying to do, and what got in your way?';

  @override
  String get accessibilityFormErrorDescription =>
      'Please describe the issue before sending.';

  @override
  String get accessibilityFormErrorEmail =>
      'Please enter a valid email address or leave the field empty.';

  @override
  String get accessibilityFormSendEmail => 'Send by email';

  @override
  String get accessibilityFormSendGithub => 'Open a GitHub issue';

  @override
  String get accessibilityFormEmailSubject =>
      'Accessibility report (Ollama App)';

  @override
  String get accessibilityFormCopiedFallback =>
      'Could not open the link. The report was copied to the clipboard.';

  @override
  String get tooltipResetChat => 'Reset current chat';

  @override
  String get tooltipVoiceClose => 'Close voice mode';

  @override
  String get tooltipVoiceSettings => 'Open voice settings';

  @override
  String get tooltipVoiceScrollToEnd => 'Scroll to the latest text';

  @override
  String get tooltipWelcomeNext => 'Next page';

  @override
  String get tooltipWelcomeFinish => 'Start using Ollama';

  @override
  String get accessibilityVoiceOrbListening =>
      'Voice mode is listening. Tap to stop listening.';

  @override
  String get accessibilityVoiceOrbSpeaking =>
      'The response is being read aloud. Tap to stop.';

  @override
  String get accessibilityVoiceOrbThinking =>
      'The AI is preparing a response. Tap to cancel.';

  @override
  String get accessibilityAppLogo => 'Ollama';

  @override
  String get accessibilityWelcomePage1 =>
      'Welcome to Ollama. This onboarding shows three short pictures.';

  @override
  String get accessibilityWelcomePage2 =>
      'Onboarding page 2 of 3. The image shows how to select a model and start chatting.';

  @override
  String get accessibilityWelcomePage3 =>
      'Onboarding page 3 of 3. The image shows where to find settings and voice mode.';

  @override
  String get accessibilitySummaryConformance =>
      'This app targets WCAG 2.2 Level AA and applies AAA-level enhancements. Some features have limitations, described inside each section.';

  @override
  String get accessibilitySectionStatementSummary =>
      'Our commitment, conformance status, and the measures we apply beyond AA.';

  @override
  String get accessibilitySectionTestsSummary =>
      '8 automated accessibility checks pass on every build.';

  @override
  String get accessibilitySectionStandardsSummary =>
      'How we support AODA, the European standard EN 301 549, and US ADA / Section 508.';

  @override
  String get accessibilitySectionContactSummary =>
      'Report an accessibility issue by email or GitHub. We respond to all reports.';

  @override
  String get accessibilitySupportLevelLimited => 'Limited support';

  @override
  String get accessibilitySupportLevelCompliantWithLimitations =>
      'Compliant with limitations';
}
