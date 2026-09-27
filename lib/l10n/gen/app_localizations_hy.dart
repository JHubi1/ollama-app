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
}