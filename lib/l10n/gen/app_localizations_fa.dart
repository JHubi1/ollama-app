// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

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
        'auth': 'احراز هویت ناموفق بود',
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
        'url': 'نشانی اینترنتی واردشده نامعتبر است. از یک نشانی کامل که با http:// یا https:// شروع می‌شود استفاده کنید — برای مثال http://localhost:11434 برای سرور محلی Ollama، یا https://ollama.com برای Ollama Cloud. در انتها اسلش یا مسیر api/ اضافه نکنید.',
        'host': 'The host you entered is invalid. It cannot be reached. Please check the host and try again.',
        'auth': 'سرور درخواست را رد کرد (401/403). اگر به Ollama Cloud (https://ollama.com) متصل می‌شوید، کلید API خود را در فیلد توکن زیر وارد کنید — می‌توانید آن را در https://ollama.com/keys بسازید یا کپی کنید — و ذخیره کنید. اگر از سرور شخصی استفاده می‌کنید، هدر Authorization پیکربندی‌شده برای میزبان را بررسی کنید.',
        'other': 'The host you entered is invalid. It cannot be reached. Please check the host and try again.',
      },
    );
    return '$_temp0';
  }

  @override
  String get settingsApiTokenInvalid => 'توکن API رد شد';

  @override
  String get settingsApiTokenInvalidDetailed => 'توکن API توسط سرور رد شد (401/403). بررسی کنید که دقیقاً مطابق نمایش‌داده‌شده در https://ollama.com/keys کپی شده باشد — کلید جدیدی نیز می‌توان در همان صفحه ساخت — و دوباره ذخیره کنید. توکن باید در حالی که میزبان https://ollama.com است تنظیم شود.';

  @override
  String get settingsApiTokenVerified => 'توکن API ذخیره و تأیید شد';

  @override
  String get settingsApiToken => 'توکن API ابری Ollama';

  @override
  String get settingsApiTokenHint => 'توکن را از ollama.com بچسبانید';

  @override
  String get tooltipShowToken => 'نمایش توکن';

  @override
  String get tooltipHideToken => 'پنهان کردن توکن';

  @override
  String voiceLanguageInstruction(String language) {
    return 'شما باید به زبان زیر بنویسید: $language!';
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
  String get settingsTitleAccessibility => 'دسترس‌پذیری';

  @override
  String get settingsDescriptionAccessibility => 'بیانیه دسترس‌پذیری، نتایج آزمون‌ها و نحوه گزارش یک مشکل.';

  @override
  String get accessibilityStatementTitle => 'بیانیه دسترس‌پذیری';

  @override
  String get accessibilityCommitmentIntro => 'Ollama باید برای افراد با هر توانایی‌ای، در هر زبانی که ارائه می‌کنیم، قابل استفاده باشد. کنترل صوتی، صفحه‌خوان‌ها، ناوبری با صفحه‌کلید و رندر با کنتراست بالا روش‌های درجه‌یک استفاده از این برنامه هستند — نه مواردی فرعی و اضافی.';

  @override
  String get accessibilityCommitmentDetails => 'در عمل این به این معناست: هر کنترل تعاملی نامی دارد که صفحه‌خوان اعلام می‌کند (از جمله وضعیت حالت صوتی)، دکمه‌ها حداقل اندازه لمسی 48dp را حفظ می‌کنند، فوکوس صفحه‌کلید از ترتیب بصری رابط پیروی می‌کند، پیام‌های وضعیت هنگام تغییر اعلام می‌شوند، و رابط در مقیاس‌های بزرگ متن و در هر دو تم روشن و تاریک قابل استفاده باقی می‌ماند.';

  @override
  String get accessibilityConformanceTitle => 'وضعیت انطباق';

  @override
  String get accessibilityConformanceStatus => 'این برنامه برای انطباق با Web Content Accessibility Guidelines (WCAG) 2.2 Level AA طراحی شده است. این انطباق به‌طور مستقل توسط شخص ثالث گواهی نشده است؛ این امر بر پایه آزمون‌های خودکار خودِ ما است. هرجا امکان‌پذیر باشد فراتر از AA می‌رویم و اقدامات WCAG AAA را به کار می‌گیریم که در ادامه فهرست شده‌اند.';

  @override
  String get accessibilityAaaMeasuresTitle => 'فراتر از AA (اقدامات AAA)';

  @override
  String get accessibilityAaaMeasures => 'متن اصلی در هر دو تم از کنتراست 21:1 استفاده می‌کند (AAA نیازمند 7:1 است)، متن فرعی کم‌رنگ از کنتراست 10:1 یا بهتر بهره می‌برد، رنگ‌های وضعیت موفقیت و هشدار در هر دو تم کنتراست AAA را برآورده می‌کنند، و متن خطا در تم تاریک کنتراست AAA را برآورده می‌کند. AAA افزون بر این اقداماتی را نیز الزامی می‌کند که در یک برنامه چت با این اندازه عملی نیستند (برای مثال کنتراست 7:1 بر همه متن‌ها بدون استثنا و محدودیت سطح خوانایی)، بنابراین AA را به‌عنوان تضمین هدف قرار می‌دهیم و این اقدامات AAA را به‌چشم بهبودهای افزوده در نظر می‌گیریم.';

  @override
  String get accessibilityAodaTitle => 'قانون دسترس‌پذیری برای اهالی انتاریو با معلولیت (AODA)';

  @override
  String get accessibilityAodaText => 'قانون دسترس‌پذیری برای اهالی انتاریو با معلولیت (AODA) انتاریو از محصولات دیجیتال می‌خواهد استاندارد WCAG 2.0/2.1 Level AA را برآورده کنند. هدف WCAG 2.2 Level AA این برنامه از آن خط مبنا فراتر می‌رود. بازخورد درباره دسترس‌پذیری از طریق فرم تماس در همین صفحه پذیرفته می‌شود، در راستای الزام AODA به در دسترس بودن کانال‌های بازخورد.';

  @override
  String get accessibilityStandardsEuropeTitle => 'استانداردهای اروپا (EN 301 549)';

  @override
  String get accessibilityStandardsEuropeText => 'در اتحادیه اروپا، استاندارد هماهنگ‌شده EN 301 549 الزامات دسترس‌پذیری فناوری اطلاعات و ارتباطات (ICT) قانون دسترس‌پذیری اروپا را تعریف می‌کند که به WCAG 2.1 Level AA ارجاع می‌دهد. هدف WCAG 2.2 Level AA این برنامه آن الزامات را پوشش می‌دهد و از تعهدات دسترس‌پذیری اروپایی پشتیبانی می‌کند که از 28 ژوئن 2025 اعمال می‌شوند.';

  @override
  String get accessibilityStandardsUsTitle => 'استانداردهای ایالات متحده (ADA / Section 508)';

  @override
  String get accessibilityStandardsUsText => 'در ایالات متحده، Americans with Disabilities Act (ADA) خط مبنای عمومی منع تبعیض است و Section 508 از Rehabilitation Act برای فناوری فدرال WCAG 2.0 Level AA را الزام می‌کند (Section 504 تعهدات مشابهی را به برنامه‌های دارای بودجه گسترش می‌دهد). هدف WCAG 2.2 Level AA این برنامه از آن خطوط مبنا فراتر می‌رود.';

  @override
  String get accessibilityKnownIssuesTitle => 'محدودیت‌های شناخته‌شده';

  @override
  String get accessibilityKnownIssues => 'دکمه‌های نوار عنوان پنجره دسکتاپ (کوچک‌کردن، بزرگ‌کردن، بستن) توسط یکپارچه‌سازی سیستم‌عامل فراهم می‌شوند و در درخت صفحه‌خوان برنامه در دسترس نیستند. کتابخانه چت مقدار کمی از متن رابط خود را رندر می‌کند که هنوز ممکن است در همه زبان‌ها موجود نباشد. در حالت صوتی، متن پاسخ نزدیک لبه صفحه محو می‌شود و در صورت افزایش چشمگیر اندازه متن سیستم، خطوط چت خیلی بلند ممکن است با سه‌نقطه بریده شوند.';

  @override
  String accessibilityLastValidated(String version) {
    return 'بررسی‌های خودکار آخرین بار با Ollama App v$version اعتبارسنجی شدند.';
  }

  @override
  String get accessibilityTestsTitle => 'نتایج آزمون‌ها';

  @override
  String get accessibilityTestsIntro => 'بررسی‌های خودکار دسترس‌پذیری زیر بخشی از مجموعه آزمون‌های این برنامه هستند و روی هر کامیت اجرا می‌شوند:';

  @override
  String get accessibilityTestsCheckColumn => 'بررسی';

  @override
  String get accessibilityTestsStatusColumn => 'وضعیت';

  @override
  String get accessibilityTestsPass => 'قبول';

  @override
  String get accessibilityTestsCiNote => 'مجموعه کامل (تحلیل ایستا به‌همراه آزمون‌های خودکار) روی هر کامیت در خط لوله یکپارچه‌سازی مداوم اجرا می‌شود.';

  @override
  String get accessibilityTestContrast => 'کنتراست متن در تم‌های روشن و تاریک سطوح WCAG را برآورده می‌کند';

  @override
  String get accessibilityTestLabeledTapTarget => 'اهداف قابل لمس برچسب صفحه‌خوان دارند';

  @override
  String get accessibilityTestAndroidTapTarget => 'اهداف لمسی دست‌کم 48x48dp هستند (راهنمای Android)';

  @override
  String get accessibilityTestIosTapTarget => 'اهداف لمسی دست‌کم 44x44dp هستند (راهنمای iOS)';

  @override
  String get accessibilityTestSemanticsPresent => 'برچسب صفحه‌خوان برای همه کنترل‌های سفارشی وجود دارد';

  @override
  String get accessibilityTestTraversalOrder => 'ترتیب فوکوس صفحه‌کلید از ترتیب بصری پیروی می‌کند';

  @override
  String get accessibilityTestLocalesRender => 'همه زبان‌های رابط بدون خطا رندر می‌شوند';

  @override
  String get accessibilityTestFormValidation => 'فیلدهای فرم خطاهای اعتبارسنجی را اعلام می‌کنند';

  @override
  String get accessibilityContactTitle => 'گزارش یک مشکل دسترس‌پذیری';

  @override
  String get accessibilityContactIntro => 'از این فرم برای درخواست اطلاعات دسترس‌پذیری، درخواست رسیدگی، یا گزارش یک مانع دسترس‌پذیری استفاده کنید. گزارش شما در قالب پیامی ساخته می‌شود که می‌توانید با ایمیل یا به‌صورت یک issue عمومی در GitHub ارسال کنید.';

  @override
  String get accessibilityFormName => 'نام (اختیاری)';

  @override
  String get accessibilityFormEmail => 'ایمیل (اختیاری)';

  @override
  String get accessibilityFormAssistiveTech => 'فناوری کمکی استفاده‌شده (اختیاری)';

  @override
  String get accessibilityFormDescription => 'مشکل را توصیف کنید (الزامی)';

  @override
  String get accessibilityFormDescriptionHint => 'می‌خواستید چه کاری انجام دهید و چه چیزی جلوی راه شما قرار گرفت؟';

  @override
  String get accessibilityFormErrorDescription => 'لطفاً پیش از ارسال، مشکل را توصیف کنید.';

  @override
  String get accessibilityFormErrorEmail => 'لطفاً یک نشانی ایمیل معتبر وارد کنید یا فیلد را خالی بگذارید.';

  @override
  String get accessibilityFormSendEmail => 'ارسال با ایمیل';

  @override
  String get accessibilityFormSendGithub => 'ایجاد یک issue در GitHub';

  @override
  String get accessibilityFormEmailSubject => 'گزارش دسترس‌پذیری (Ollama App)';

  @override
  String get accessibilityFormCopiedFallback => 'باز کردن پیوند ممکن نشد. گزارش در کلیپ‌بورد کپی شد.';

  @override
  String get tooltipResetChat => 'بازنشانی چت فعلی';

  @override
  String get tooltipVoiceClose => 'بستن حالت صوتی';

  @override
  String get tooltipVoiceSettings => 'باز کردن تنظیمات صدا';

  @override
  String get tooltipVoiceScrollToEnd => 'پیمایش به آخرین متن';

  @override
  String get tooltipWelcomeNext => 'صفحه بعدی';

  @override
  String get tooltipWelcomeFinish => 'شروع استفاده از Ollama';

  @override
  String get accessibilityVoiceOrbListening => 'حالت صوتی در حال شنیدن است. برای توقف شنیدن ضربه بزنید.';

  @override
  String get accessibilityVoiceOrbSpeaking => 'پاسخ بلندخوانی می‌شود. برای توقف ضربه بزنید.';

  @override
  String get accessibilityVoiceOrbThinking => 'هوش مصنوعی در حال آماده‌سازی پاسخ است. برای لغو ضربه بزنید.';

  @override
  String get accessibilityAppLogo => 'Ollama';

  @override
  String get accessibilityWelcomePage1 => 'به Ollama خوش آمدید. این راه‌اندازی اولیه سه تصویر کوتاه نشان می‌دهد.';

  @override
  String get accessibilityWelcomePage2 => 'صفحه راه‌اندازی اولیه 2 از 3. تصویر نشان می‌دهد چگونه مدلی انتخاب کنید و گفت‌وگو را شروع کنید.';

  @override
  String get accessibilityWelcomePage3 => 'صفحه راه‌اندازی اولیه 3 از 3. تصویر نشان می‌دهد تنظیمات و حالت صوتی کجا پیدا می‌شوند.';

  @override
  String get accessibilitySummaryConformance => 'این برنامه هدف خود را WCAG 2.2 Level AA قرار می‌دهد و بهبودهای سطح AAA را نیز به کار می‌گیرد. برخی ویژگی‌ها محدودیت‌هایی دارند که درون هر بخش توضیح داده شده‌اند.';

  @override
  String get accessibilitySectionStatementSummary => 'تعهد ما، وضعیت انطباق، و اقداماتی که فراتر از AA به کار می‌گیریم.';

  @override
  String get accessibilitySectionTestsSummary => '8 بررسی خودکار دسترس‌پذیری در هر ساخت اجرا می‌شوند و قبول می‌شوند.';

  @override
  String get accessibilitySectionStandardsSummary => 'چگونه از AODA، استاندارد اروپایی EN 301 549، و ADA / Section 508 آمریکا پشتیبانی می‌کنیم.';

  @override
  String get accessibilitySectionContactSummary => 'یک مشکل دسترس‌پذیری را با ایمیل یا در GitHub گزارش کنید. به همه گزارش‌ها پاسخ می‌دهیم.';

  @override
  String get accessibilitySupportLevelLimited => 'پشتیبانی محدود';

  @override
  String get accessibilitySupportLevelCompliantWithLimitations => 'منطبق با محدودیت‌ها';
}
