// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Armenian (`hy`).
class AppLocalizationsHy extends AppLocalizations {
  AppLocalizationsHy([String locale = 'hy']) : super(locale);

  @override
  String get appTitle => 'Ollama';

  @override
  String get optionNewChat => 'Նոր Չաթ';

  @override
  String get optionSettings => 'Կարգավորումներ';

  @override
  String get optionInstallPwa => 'Տեղադրել Վեբհավելված';

  @override
  String get optionNoChatFound => 'Չաթեր չեն գտնվել';

  @override
  String get tipPrefix => 'Խորհուրդ. ';

  @override
  String get tip0 => 'Խմբագրեք հաղորդագրությունները՝ երկար սեղմելով դրանց վրա';

  @override
  String get tip1 => 'Ջնջեք հաղորդագրությունները՝ կրկնակի սեղմելով դրանց վրա';

  @override
  String get tip2 => 'Կարող եք փոխել թեման կարգավորումներում';

  @override
  String get tip3 => 'Ընտրեք մուլտիմոդալ մոդել՝ պատկերներ ներմուծելու համար';

  @override
  String get tip4 => 'Չաթերը ավտոմատ պահպանվում են';

  @override
  String get deleteChat => 'Ջնջել';

  @override
  String get renameChat => 'Վերանվանել';

  @override
  String get takeImage => 'Լուսանկարել';

  @override
  String get uploadImage => 'Վերբեռնել Պատկեր';

  @override
  String get notAValidImage => 'Պատկերը վավեր չէ';

  @override
  String get imageOnlyConversation => 'Միայն Պատկերով Խոսակցություն';

  @override
  String get messageInputPlaceholder => 'Հաղորդագրություն';

  @override
  String get tooltipAttachment => 'Ավելացնել կցորդ';

  @override
  String get tooltipSend => 'Ուղարկել';

  @override
  String get tooltipSave => 'Պահպանել';

  @override
  String get tooltipLetAIThink => 'Թող AI-ն մտածի';

  @override
  String get tooltipAddHostHeaders => 'Ավելացնել հոսթի վերնագրեր';

  @override
  String get tooltipReset => 'Վերակայել ընթացիկ չաթը';

  @override
  String get tooltipOptions => 'Ցուցադրել ընտրանքները';

  @override
  String get noModelSelected => 'Մոդել ընտրված չէ';

  @override
  String get noHostSelected => 'Հոսթ ընտրված չէ, բացեք կարգավորումները՝ մեկը սահմանելու համար';

  @override
  String get noSelectedModel => '<selector>';

  @override
  String get newChatTitle => 'Անանուն Չաթ';

  @override
  String get modelDialogAddModel => 'Ավելացնել';

  @override
  String get modelDialogAddPromptTitle => 'Ավելացնել նոր մոդել';

  @override
  String get modelDialogAddPromptDescription => 'Սա կարող է լինել կամ սովորական անուն (օր. \'llama3\'), կամ անուն և թեգ (օր. \'llama3:70b\').';

  @override
  String get modelDialogAddPromptAlreadyExists => 'Մոդելն արդեն գոյություն ունի';

  @override
  String get modelDialogAddPromptInvalid => 'Մոդելի անունը վավեր չէ';

  @override
  String get modelDialogAddAllowanceTitle => 'Թույլատրել պրոքսին';

  @override
  String get modelDialogAddAllowanceDescription => 'Ollama App-ը պետք է ստուգի, թե արդյոք մուտքագրված մոդելը վավեր է: Դրա համար սովորաբար մենք վեբ-հարցում ենք ուղարկում Ollama-ի մոդելների ցանկին և ստուգում կարգավիճակի կոդը, բայց քանի որ դուք օգտագործում եք վեբ հաճախորդը, մենք դա ուղղակիորեն անել չենք կարող: Փոխարենը հավելվածը հարցումը կուղարկի մեկ այլ API-ի՝ JHubi1-ի կողմից տեղակայված, որպեսզի ստուգի մեր փոխարեն:\nՍա միանվագ հարցում է և կուղարկվի միայն այն դեպքում, երբ ավելացնեք նոր մոդել:\nՁեր IP հասցեն կուղարկվի հարցման հետ և կարող է պահպանվել մինչև տասը րոպե՝ սպամը և պոտենցիալ վնասակար մտադրությունները կանխելու համար:\nԵթե ընդունեք, ձեր ընտրությունը կհիշվի ապագայում. այլապես ոչինչ չի ուղարկվի, և մոդելը չի ավելացվի:';

  @override
  String get modelDialogAddAllowanceAllow => 'Թույլատրել';

  @override
  String get modelDialogAddAllowanceDeny => 'Մերժել';

  @override
  String modelDialogAddAssuranceTitle(String model) {
    return 'Ավելացնե՞լ $model';
  }

  @override
  String modelDialogAddAssuranceDescription(String model) {
    return '\'Ավելացնել\' սեղմելիս \'$model\' մոդելը ուղղակիորեն ներբեռնվելու է Ollama սերվերից ձեր հոսթի վրա:\nԿախված ձեր ինտերնետ կապից, դա կարող է որոշ ժամանակ տևել: Գործողությունը չեղարկել չի կարել:\nԵթե հավելվածը փակվի ներբեռնման ընթացքում, այն կշարունակվի, երբ դարձյալ մուտքագրեք անունը մոդելի երկխոսության մեջ:';
  }

  @override
  String get modelDialogAddAssuranceAdd => 'Ավելացնել';

  @override
  String get modelDialogAddAssuranceCancel => 'Չեղարկել';

  @override
  String get modelDialogAddDownloadPercentLoading => 'ներբեռնման ընթացք';

  @override
  String modelDialogAddDownloadPercent(String percent) {
    return 'ներբեռնումը՝ $percent%';
  }

  @override
  String get modelDialogAddDownloadFailed => 'Կապն ընդհատվել է, փորձեք կրկին';

  @override
  String get modelDialogAddDownloadSuccess => 'Ներբեռնումը հաջողվեց';

  @override
  String get deleteDialogTitle => 'Ջնջել Չաթը';

  @override
  String get deleteDialogDescription => 'Վստահ եք, որ ցանկանում եք շարունակել: Սա կջնջի այս չաթի ողջ հիշողությունը և չի կարող հետարկվել:\nԱյս երկխոսությունը անջատելու համար այցելեք կարգավորումները:';

  @override
  String get deleteDialogDelete => 'Ջնջել';

  @override
  String get deleteDialogCancel => 'Չեղարկել';

  @override
  String get dialogEnterNewTitle => 'Մուտքագրեք նոր վերնագիր';

  @override
  String get dialogEditMessageTitle => 'Խմբագրել հաղորդագրությունը';

  @override
  String get settingsTitleBehavior => 'Վարքագիծ';

  @override
  String get settingsDescriptionBehavior => 'Փոխեք AI-ի վարքագիծը ձեր հայեցողությամբ:';

  @override
  String get settingsTitleInterface => 'Միջերես';

  @override
  String get settingsDescriptionInterface => 'Խմբագրեք Ollama App-ի տեսքն ու վարքագիծը:';

  @override
  String get settingsTitleVoice => 'Ձայն';

  @override
  String get settingsDescriptionVoice => 'Միացրեք ձայնային ռեժիմը և կարգավորեք ձայնի կարգավորումները:';

  @override
  String get settingsTitleExport => 'Արտահանում';

  @override
  String get settingsDescriptionExport => 'Արտահանեք և ներմուծեք ձեր չաթերի պատմությունը:';

  @override
  String get settingsTitleAbout => 'Մասին';

  @override
  String get settingsDescriptionAbout => 'Ստուգեք թարմացումները և իմացեք ավելին Ollama App-ի մասին:';

  @override
  String get settingsSavedAutomatically => 'Կարգավորումները ավտոմատ պահպանվում են';

  @override
  String get settingsExperimentalAlpha => 'ալֆա';

  @override
  String get settingsExperimentalAlphaDescription => 'Այս հնարավորությունը ալֆա փուլում է և կարող է չաշխատել նախատեսված կամ սպասված ձևով:\nՉի կարելի բացառել լուրջ խնդիրներ և/կամ մշտական լուրջ վնաս սարքին և/կամ օգտագործվող ծառայություններին:\nՕգտագործեք ձեր սեփական ռիսկի տակ: Հավելվածի հեղինակը որևէ պատասխանատվություն չի կրում:';

  @override
  String get settingsExperimentalAlphaFeature => 'Ալֆա հնարավորություն, պահեք սեղմված՝ ավելին իմանալու համար';

  @override
  String get settingsExperimentalBeta => 'բետա';

  @override
  String get settingsExperimentalBetaDescription => 'Այս հնարավորությունը բետա փուլում է և կարող է չաշխատել նախատեսված կամ սպասված ձևով:\nԿարող են առաջանալ, կամ էլ չառաջանալ ավելի թեթև խնդիրներ: Վնասը չպետք է լինի լուրջ:\nՕգտագործեք ձեր սեփական ռիսկի տակ:';

  @override
  String get settingsExperimentalBetaFeature => 'Բետա հնարավորություն, պահեք սեղմված՝ ավելին իմանալու համար';

  @override
  String get settingsExperimentalDeprecated => 'հնացած';

  @override
  String get settingsExperimentalDeprecatedDescription => 'Այս հնարավորությունը հնացած է և կհեռացվի ապագա տարբերակում:\nԱյն կարող է չաշխատել նախատեսված կամ սպասված ձևով: Օգտագործեք ձեր սեփական ռիսկի տակ:';

  @override
  String get settingsExperimentalDeprecatedFeature => 'Հնացած հնարավորություն, պահեք սեղմված՝ ավելին իմանալու համար';

  @override
  String get settingsHost => 'Հոսթ';

  @override
  String get settingsHostValid => 'Վավեր Հոսթ';

  @override
  String get settingsHostChecking => 'Հոսթը ստուգվում է';

  @override
  String settingsHostInvalid(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'url': 'Վավեր չէ URL-ը',
        'host': 'Վավեր չէ հոսթը',
        'auth': 'Նույնականացումը ձախողվեց',
        'timeout': 'Հարցումը ձախողվեց: Սերվերի խնդիրներ',
        'ratelimit': 'Չափազանց շատ հարցումներ',
        'other': 'Հարցումը ձախողվեց',
      },
    );
    return 'Խնդիր. $_temp0';
  }

  @override
  String get settingsHostHeaderTitle => 'Սահմանել հոսթի վերնագիր';

  @override
  String get settingsHostHeaderInvalid => 'Մուտքագրված տեքստը վավեր վերնագրի JSON օբյեկտ չէ';

  @override
  String settingsHostInvalidDetailed(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'url': 'Մուտքագրած URL-ը վավեր չէ: Օգտագործեք ամբողջական URL՝ սկսվող http:// կամ https://-ով — օրինակ՝ http://localhost:11434 տեղային Ollama սերվերի համար, կամ https://ollama.com՝ Ollama Cloud-ի համար: Մի ավելացրեք ավարտական թեք գծիկ կամ /api ուղի:',
        'host': 'Մուտքագրած հոսթը վավեր չէ: Այն հասանելի չէ: Ստուգեք հոսթը և փորձեք կրկին:',
        'auth': 'Սերվերը մերժեց հարցումը (401/403): Եթե միանում եք Ollama Cloud-ին (https://ollama.com), մուտքագրեք ձեր API բանալին ստորև՝ տոկենի դաշտում — կարող եք այն ստեղծել կամ պատճենել https://ollama.com/keys էջում — և պահպանել այն: Եթե օգտագործում եք սեփական տեղակայված սերվեր, ստուգեք հոսթի համար կարգավորված Authorization վերնագիրը:',
        'other': 'Մուտքագրած հոսթը վավեր չէ: Այն հասանելի չէ: Ստուգեք հոսթը և փորձեք կրկին:',
      },
    );
    return '$_temp0';
  }

  @override
  String get settingsApiTokenInvalid => 'API տոկենը մերժվեց';

  @override
  String get settingsApiTokenInvalidDetailed => 'API տոկենը մերժվեց սերվերի կողմից (401/403): Ստուգեք, որ այն պատճենվել է ճիշտ այնպես, ինչպես ցուցադրվում է https://ollama.com/keys էջում — այդ էջում կարելի է ստեղծել նոր բանալի — և կրկին պահպանեք այն: Տոկենը պետք է սահմանված լինի այն ժամանակ, երբ հոսթը https://ollama.com է:';

  @override
  String get settingsApiTokenVerified => 'API տոկենը պահպանվեց և ստուգվեց';

  @override
  String get settingsApiToken => 'Ollama Cloud API Տոկեն';

  @override
  String get settingsApiTokenHint => 'Տոկենը տեղադրեք ollama.com-ից';

  @override
  String get tooltipShowToken => 'Ցուցադրել տոկենը';

  @override
  String get tooltipHideToken => 'Թաքցնել տոկենը';

  @override
  String voiceLanguageInstruction(String language) {
    return 'Դուք պետք է գրեք հետևյալ լեզվով՝ $language!';
  }

  @override
  String get settingsSystemMessage => 'Համակարգային հաղորդագրություն';

  @override
  String get settingsUseSystem => 'Օգտագործել համակարգային հաղորդագրությունը';

  @override
  String get settingsUseSystemDescription => 'Անջատում է վերևում նշված համակարգային հաղորդագրության սահմանումը և փոխարենը օգտագործում է մոդելինը: Կարող է օգտակար լինել մոդելային ֆայլեր ունեցող մոդելների համար';

  @override
  String get settingsDisableMarkdown => 'Անջատել markdown-ը';

  @override
  String get settingsBehaviorNotUpdatedForOlderChats => 'Վարքագծի կարգավորումները չեն թարմացվում հին չաթերի համար';

  @override
  String get settingsShowModelTags => 'Ցուցադրել մոդելի թեգերը';

  @override
  String get settingsPreloadModels => 'Նախաբեռնել մոդելները';

  @override
  String get settingsResetOnModelChange => 'Վերակայել մոդելի փոփոխության դեպքում';

  @override
  String get settingsRequestTypeStream => 'Stream';

  @override
  String get settingsRequestTypeRequest => 'Request';

  @override
  String get settingsGenerateTitles => 'Ստեղծել վերնագրեր';

  @override
  String get settingsEnableEditing => 'Հաղորդագրությունների խմբագրում';

  @override
  String get settingsAskBeforeDelete => 'Հարցել չաթը ջնջելուց առաջ';

  @override
  String get settingsShowTips => 'Ցուցադրել խորհուրդները կողմնային վահանակում';

  @override
  String get settingsKeepModelLoadedAlways => 'Պահել մոդելը միշտ բեռնված';

  @override
  String get settingsKeepModelLoadedNever => 'Չպահել մոդելը բեռնված';

  @override
  String get settingsKeepModelLoadedFor => 'Սահմանել մոդելի բեռնված մնալու որոշակի ժամանակ';

  @override
  String settingsKeepModelLoadedSet(String minutes) {
    return 'Պահել մոդելը բեռնված $minutes րոպե';
  }

  @override
  String get settingsTimeoutMultiplier => 'Սահմանաժամանակի գործակից';

  @override
  String get settingsTimeoutMultiplierDescription => 'Ընտրեք այն գործակիցը, որը կիրառվում է հավելվածի բոլոր սահմանաժամանակների նկատմամբ: Կարող է օգտակար լինել դանդաղ ինտերնետ կապի կամ դանդաղ հոսթի դեպքում:';

  @override
  String get settingsTimeoutMultiplierExample => 'Օրինակ՝ հաղորդագրության սահմանաժամանակ.';

  @override
  String get settingsEnableHapticFeedback => 'Միացնել շոշափողական հետադարձ կապը';

  @override
  String get settingsMaximizeOnStart => 'Մեծացված գործարկել';

  @override
  String get settingsBrightnessSystem => 'Համակարգ';

  @override
  String get settingsBrightnessLight => 'Բաց';

  @override
  String get settingsBrightnessDark => 'Մուգ';

  @override
  String get settingsThemeDevice => 'Սարք';

  @override
  String get settingsThemeOllama => 'Ollama';

  @override
  String get settingsTemporaryFixes => 'Ժամանակավոր միջերեսային ուղղումներ';

  @override
  String get settingsTemporaryFixesDescription => 'Միացրեք ժամանակավոր ուղղումներ միջերեսի խնդիրների համար:\nՍեղմեք երկար առանձին ընտրանքների վրա՝ ավելին իմանալու համար:';

  @override
  String get settingsTemporaryFixesInstructions => 'Մի միացրեք այս կարգավորումներից որևէ մեկը, եթե չգիտեք, թե ինչ եք անում: Տրված լուծումները կարող են չաշխատել սպասված ձևով:\nԴրանք չեն կարող համարվել վերջնական և պետք է այդպես գնահատվեն: Խնդիրներ կարող են առաջանալ:';

  @override
  String get settingsTemporaryFixesNoFixes => 'Ուղղումներ հասանելի չեն';

  @override
  String get settingsVoicePermissionLoading => 'Բեռնվում են ձայնային թույլտվությունները ...';

  @override
  String get settingsVoiceTtsNotSupported => 'Տեքստից խոսքը չի աջակցվում';

  @override
  String get settingsVoiceTtsNotSupportedDescription => 'Տեքստից խոսքի ծառայությունները չեն աջակցվում ընտրված լեզվի համար: Ընտրեք այլ լեզու լեզվի ընտրացանկում՝ դրանք կրկին միացնելու համար:\nԱյլ ծառայությունները, ինչպիսիք են ձայնի ճանաչումը և AI-ի մտածելը, կաշխատեն սովորականի պես, բայց փոխազդեցությունը կարող է այնքան սահուն չլինել:';

  @override
  String get settingsVoicePermissionNot => 'Թույլտվությունները տրված չեն';

  @override
  String get settingsVoiceNotEnabled => 'Ձայնային ռեժիմը միացված չէ';

  @override
  String get settingsVoiceNotSupported => 'Ձայնային ռեժիմը չի աջակցվում';

  @override
  String get settingsVoiceEnable => 'Միացնել ձայնային ռեժիմը';

  @override
  String get settingsVoiceNoLanguage => 'Լեզու ընտրված չէ';

  @override
  String get settingsVoiceLimitLanguage => 'Սահմանափակել ընտրված լեզվով';

  @override
  String get settingsVoicePunctuation => 'Միացնել AI-ի կետադրությունը';

  @override
  String get settingsExportChats => 'Արտահանել չաթերը';

  @override
  String get settingsExportChatsSuccess => 'Չաթերը հաջողությամբ արտահանվեցին';

  @override
  String get settingsImportChats => 'Ներմուծել չաթերը';

  @override
  String get settingsImportChatsTitle => 'Ներմուծում';

  @override
  String get settingsImportChatsDescription => 'Հաջորդ քայլը ներմուծելու է չաթերը ընտրված ֆայլից: Սա կփոխարինի բոլոր ներկա առկա չաթերը:\nՑանկանու՞մ եք շարունակել:';

  @override
  String get settingsImportChatsImport => 'Ներմուծել և Ջնջել';

  @override
  String get settingsImportChatsCancel => 'Չեղարկել';

  @override
  String get settingsImportChatsSuccess => 'Չաթերը հաջողությամբ ներմուծվեցին';

  @override
  String get settingsExportInfo => 'Այս ընտրանքը թույլ է տալիս արտահանել և ներմուծել ձեր չաթերի պատմությունը: Սա կարող է օգտակար լինել, եթե ցանկանում եք ձեր չաթերի պատմությունը փոխանցել այլ սարքի կամ պահուստավորել այն';

  @override
  String get settingsExportWarning => 'Մի քանի չաթի պատմություններ չեն միավորվի: Կկորցնեք ձեր ընթացիկ չաթի պատմությունը, եթե ներմուծեք նորը';

  @override
  String get settingsUpdateCheck => 'Ստուգել թարմացումները';

  @override
  String get settingsUpdateChecking => 'Ստուգվում են թարմացումները ...';

  @override
  String get settingsUpdateLatest => 'Դուք օգտագործում եք վերջին տարբերակը';

  @override
  String settingsUpdateAvailable(String version) {
    return 'Թարմացում հասանելի է (v$version)';
  }

  @override
  String get settingsUpdateRateLimit => 'Հնարավոր չէ ստուգել, գերազանցվել է API-ի սահմանը';

  @override
  String get settingsUpdateIssue => 'Խնդիր է առաջացել';

  @override
  String get settingsUpdateDialogTitle => 'Նոր տարբերակ հասանելի է';

  @override
  String get settingsUpdateDialogDescription => 'Ollama-ի նոր տարբերակ է հասանելի: Ցանկանու՞մ եք այն հիմա ներբեռնել և տեղադրել:';

  @override
  String get settingsUpdateChangeLog => 'Փոփոխությունների մատյան';

  @override
  String get settingsUpdateDialogUpdate => 'Թարմացնել';

  @override
  String get settingsUpdateDialogCancel => 'Չեղարկել';

  @override
  String get settingsCheckForUpdates => 'Բացելիս ստուգել թարմացումները';

  @override
  String get settingsGithub => 'GitHub';

  @override
  String get settingsReportIssue => 'Հաղորդել Խնդիր';

  @override
  String get settingsLicenses => 'Արտոնագրեր';

  @override
  String settingsVersion(String version) {
    return 'Ollama App v$version';
  }

  @override
  String get settingsTitleAccessibility => 'Հասանելիություն';

  @override
  String get settingsDescriptionAccessibility => 'Հասանելիության հայտարարություն, ստուգման արդյունքներ և խնդիր հաղորդելու եղանակ:';

  @override
  String get accessibilityStatementTitle => 'Հասանելիության հայտարարություն';

  @override
  String get accessibilityCommitmentIntro => 'Ollama-ն պետք է օգտագործելի լինի բոլոր կարողություններով մարդկանց համար՝ մեր աջակցվող ամեն լեզվով: Ձայնային կառավարումը, էկրանի ընթերցողները, ստեղնաշարով նավարկությունը և բարձր կոնտրաստով պատկերումը այս հավելվածն օգտագործելու լիարժեք եղանակներ են, ոչ թե հետագա ավելացումներ:';

  @override
  String get accessibilityCommitmentDetails => 'Գործնականում դա նշանակում է. ամեն փոխազդեցիկ կառավարիչ ունի անուն, որը հայտարարում է էկրանի ընթերցողը (ներառյալ ձայնային ռեժիմի վիճակը), կոճակները պահպանում են առնվազն 48dp հպման թիրախ, ստեղնաշարի ֆոկուսը հետևում է միջերեսի տեսողական հերթականությանը, կարգավիճակի հաղորդագրությունները հայտարարվում են փոփոխվելիս, և միջերեսը մնում է օգտագործելի մեծ տեքստի չափսերի և և՛ բաց, և՛ մուգ թեմաների դեպքում:';

  @override
  String get accessibilityConformanceTitle => 'Համապատասխանության կարգավիճակ';

  @override
  String get accessibilityConformanceStatus => 'Այս հավելվածը նախագծված է համապատասխանելու Վեբ Բովանդակության Հասանելիության Ուղեցույցներին (WCAG) 2.2 մակարդակ AA: Համապատասխանությունը երրորդ կողմի կողմից անկախ վկայագրված չէ. այն հիմնված է մեր սեփական ավտոմատ ստուգումների վրա: Որտեղ հնարավոր է, մենք գերազանցում ենք AA-ն և կիրառում ենք WCAG AAA միջոցներ, որոնք ներկայացված են ստորև:';

  @override
  String get accessibilityAaaMeasuresTitle => 'AA-ից բարձր (AAA միջոցներ)';

  @override
  String get accessibilityAaaMeasures => 'Հիմնական տեքստը օգտագործում է 21:1 կոնտրաստ երկու թեմաներում (AAA-ն պահանջում է 7:1), խոնարհված երկրորդային տեքստը՝ 10:1 կամ ավելի լավ, հաջողության և նախազգուշացումների կարգավիճակի գույները հասնում են AAA կոնտրաստի երկու թեմաներում, իսկ սխալի տեքստը մուգ թեմայում հասնում է AAA կոնտրաստի: AAA-ն լրացուցիչ պահանջում է միջոցներ, որոնք անիրագործելի են այս չափի չաթ հավելվածի համար (օրինակ՝ 7:1 կոնտրաստ բացարձակապես ամեն տեքստի վրա և ընթերցանության մակարդակի սահմանափակումներ), ուստի մենք AA-ն ընդունում ենք որպես երաշխիք, իսկ այս AAA միջոցները՝ որպես լրացումներ:';

  @override
  String get accessibilityAodaTitle => 'Հասանելիություն Օնտարիոյի հաշմանդամություն ունեցող անձանց համար ակտ (AODA)';

  @override
  String get accessibilityAodaText => 'Օնտարիոյի «Հասանելիություն Օնտարիոյի հաշմանդամություն ունեցող անձանց համար» ակտը (AODA) պահանջում է, որ թվային արտադրանքները հասնեն WCAG 2.0/2.1 մակարդակ AA-ին: Այս հավելվածի WCAG 2.2 մակարդակ AA նպատակը հասնում և գերազանցում է այդ բազային մակարդակին: Հասանելիության վերաբերյալ արձագանքը ողջունվում է այս էջի կապի ձևի միջոցով՝ համապատասխան AODA-ի՝ արձագանքի ուղիները հասանելի դարձնելու պահանջին:';

  @override
  String get accessibilityStandardsEuropeTitle => 'Եվրոպական չափորոշիչներ (EN 301 549)';

  @override
  String get accessibilityStandardsEuropeText => 'Եվրոպական Միությունում ներդաշնակեցված EN 301 549 չափորոշիչը սահմանում է Եվրոպական Հասանելիության Ակտի ICT հասանելիության պահանջները, որը հղում է կատարում WCAG 2.1 մակարդակ AA-ին: Այս հավելվածի WCAG 2.2 մակարդակ AA նպատակը ծածկում է այդ պահանջները՝ աջակցելով եվրոպական հասանելիության պարտավորություններին, որոնք ուժի մեջ են մտնում 2025 թ. հունիսի 28-ից:';

  @override
  String get accessibilityStandardsUsTitle => 'Միացյալ Նահանգների չափորոշիչներ (ADA / Section 508)';

  @override
  String get accessibilityStandardsUsText => 'Միացյալ Նահանգներում Հաշմանդամություն ունեցող ամերիկացիների ակտը (ADA) ընդհանուր ոչ խտրականության բազային մակարդակն է, իսկ Վերականգնման ակտի Section 508-ը պահանջում է WCAG 2.0 մակարդակ AA դաշնային տեխնոլոգիաների համար (Section 504-ը նման պարտավորություններ է տարածում ֆինանսավորվող ծրագրերի վրա): Այս հավելվածի WCAG 2.2 մակարդակ AA նպատակը հասնում և գերազանցում է այդ բազային մակարդակներին:';

  @override
  String get accessibilityKnownIssuesTitle => 'Հայտնի սահմանափակումներ';

  @override
  String get accessibilityKnownIssues => 'Աշխատասեղանի պատուհանի վերնագրի կոճակները (նվազագույնի հասցնել, առավելագույնի հասցնել, փակել) տրամադրվում են օպերացիոն համակարգի ինտեգրման կողմից և հասանելի չեն հավելվածի էկրանի ընթերցողի ծառին: Չաթի գրադարանը պատկերում է սեփական միջերեսի փոքր մասը, որը դեռ կարող է հասանելի չլինել բոլոր լեզուներով: Ձայնային ռեժիմում պատասխանի տեքստը գունաթափվում է էկրանի եզրին մոտ, և չաթի չափազանց երկար տողերը կարող են կրճատվել էլիպսիսով, երբ համակարգային տեքստի չափը էականորեն մեծացվում է:';

  @override
  String accessibilityLastValidated(String version) {
    return 'Ավտոմատ ստուգումները վերջին անգամ ստուգվել են Ollama App v$version տարբերակի դեմ:';
  }

  @override
  String get accessibilityTestsTitle => 'Ստուգման արդյունքներ';

  @override
  String get accessibilityTestsIntro => 'Հետևյալ ավտոմատ հասանելիության ստուգումները այս հավելվածի ստուգման հավաքածուի մաս են և գործարկվում են ամեն հանձնառության ժամանակ:';

  @override
  String get accessibilityTestsCheckColumn => 'Ստուգում';

  @override
  String get accessibilityTestsStatusColumn => 'Կարգավիճակ';

  @override
  String get accessibilityTestsPass => 'Հաջողված';

  @override
  String get accessibilityTestsCiNote => 'Ամբողջական հավաքածուն (ստատիկ վերլուծություն և ավտոմատ ստուգումներ) գործարկվում է ամեն հանձնառության ժամանակ շարունակական ինտեգրման խողովակաշարում:';

  @override
  String get accessibilityTestContrast => 'Տեքստի կոնտրաստը հասնում է WCAG մակարդակների բաց և մուգ թեմաներում';

  @override
  String get accessibilityTestLabeledTapTarget => 'Հպելի թիրախները ունեն էկրանի ընթերցողի պիտակներ';

  @override
  String get accessibilityTestAndroidTapTarget => 'Հպման թիրախները առնվազն 48x48dp են (Android-ի ուղեցույց)';

  @override
  String get accessibilityTestIosTapTarget => 'Հպման թիրախները առնվազն 44x44dp են (iOS-ի ուղեցույց)';

  @override
  String get accessibilityTestSemanticsPresent => 'Էկրանի ընթերցողի պիտակներ կան բոլոր սեփական կառավարիչների համար';

  @override
  String get accessibilityTestTraversalOrder => 'Ստեղնաշարի ֆոկուսի հերթականությունը հետևում է տեսողական հերթականությանը';

  @override
  String get accessibilityTestLocalesRender => 'Բոլոր միջերեսի լեզուները պատկերվում են առանց սխալների';

  @override
  String get accessibilityTestFormValidation => 'Ձևի դաշտերը հայտարարում են վավերացման սխալները';

  @override
  String get accessibilityContactTitle => 'Հաղորդել հասանելիության խնդիր';

  @override
  String get accessibilityContactIntro => 'Օգտագործեք այս ձևը՝ հասանելիության տեղեկատվություն խնդրելու, լուծում պահանջելու կամ հասանելիության խոչընդոտ հաղորդելու համար: Ձեր հաղորդումը կազմվում է հաղորդագրության մեջ, որը կարող եք ուղարկել էլ. փոստով կամ որպես հանրային խնդիր GitHub-ում:';

  @override
  String get accessibilityFormName => 'Անուն (ոչ պարտադիր)';

  @override
  String get accessibilityFormEmail => 'Էլ. փոստ (ոչ պարտադիր)';

  @override
  String get accessibilityFormAssistiveTech => 'Օգտագործվող օժանդակ տեխնոլոգիա (ոչ պարտադիր)';

  @override
  String get accessibilityFormDescription => 'Նկարագրեք խնդիրը (պարտադիր)';

  @override
  String get accessibilityFormDescriptionHint => 'Ի՞նչ էիք փորձում անել, և ի՞նչ խանգարեց ձեզ:';

  @override
  String get accessibilityFormErrorDescription => 'Ուղարկելուց առաջ նկարագրեք խնդիրը:';

  @override
  String get accessibilityFormErrorEmail => 'Մուտքագրեք վավեր էլ. փոստի հասցե կամ թողեք դաշտը դատարկ:';


  @override
  String get accessibilityFormSendGithub => 'Բացել GitHub խնդիր';

  @override
  String get accessibilityFormEmailSubject => 'Հասանելիության հաղորդում (Ollama App)';

  @override
  String get accessibilityFormCopiedFallback => 'Հղումը բացել չհաջողվեց: Հաղորդումը պատճենվեց սեղմատախտակին:';

  @override
  String get tooltipResetChat => 'Վերակայել ընթացիկ չաթը';

  @override
  String get tooltipVoiceClose => 'Փակել ձայնային ռեժիմը';

  @override
  String get tooltipVoiceSettings => 'Բացել ձայնի կարգավորումները';

  @override
  String get tooltipVoiceScrollToEnd => 'Ոլորել մինչև վերջին տեքստը';

  @override
  String get tooltipWelcomeNext => 'Հաջորդ էջ';

  @override
  String get tooltipWelcomeFinish => 'Սկսել օգտագործել Ollama-ն';

  @override
  String get accessibilityVoiceOrbListening => 'Ձայնային ռեժիմը լսում է: Սեղմեք՝ լսումը դադարեցնելու համար:';

  @override
  String get accessibilityVoiceOrbSpeaking => 'Պատասխանը ընթերցվում է բարձրաձայն: Սեղմեք՝ դադարեցնելու համար:';

  @override
  String get accessibilityVoiceOrbThinking => 'AI-ն պատասխան է պատրաստում: Սեղմեք՝ չեղարկելու համար:';

  @override
  String get accessibilityAppLogo => 'Ollama';

  @override
  String get accessibilityWelcomePage1 => 'Բարի գալուստ Ollama: Այս ներածությունը ցուցադրում է երեք կարճ նկար:';

  @override
  String get accessibilityWelcomePage2 => 'Ներածության 2-րդ էջը 3-ից: Նկարը ցուցադրում է, թե ինչպես ընտրել մոդել և սկսել չաթել:';

  @override
  String get accessibilityWelcomePage3 => 'Ներածության 3-րդ էջը 3-ից: Նկարը ցուցադրում է, թե որտեղ գտնել կարգավորումները և ձայնային ռեժիմը:';

  @override
  String get accessibilitySummaryConformance => 'Այս հավելվածը նպատակադրում է WCAG 2.2 մակարդակ AA և կիրառում է AAA մակարդակի լրացումներ: Որոշ հնարավորություններ ունեն սահմանափակումներ, որոնք նկարագրված են ամեն բաժնի ներսում:';

  @override
  String get accessibilitySectionStatementSummary => 'Մեր պարտավորությունը, համապատասխանության կարգավիճակը և AA-ից դուրս կիրառվող միջոցները:';

  @override
  String get accessibilitySectionTestsSummary => 'Ամեն կառուցման ժամանակ անցնում են 8 ավտոմատ հասանելիության ստուգումներ:';

  @override
  String get accessibilitySectionStandardsSummary => 'Ինչպես ենք մենք աջակցում AODA-ին, եվրոպական EN 301 549 չափորոշիչին և ԱՄՆ ADA / Section 508-ին:';

  @override
  String get accessibilitySectionContactSummary => 'Հաղորդեք հասանելիության խնդիր էլ. փոստով կամ GitHub-ում: Մենք պատասխանում ենք բոլոր հաղորդումներին:';

  @override
  String get accessibilitySupportLevelLimited => 'Սահմանափակ աջակցություն';

  @override
  String get accessibilitySupportLevelCompliantWithLimitations => 'Համապատասխան՝ սահմանափակումներով';
}