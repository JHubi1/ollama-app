// Localization regression tests.
//
// Pure Dart: no bindings, no async, no reflection. Every public member of
// AppLocalizations is exercised explicitly through a per-group helper, so a
// missing/renamed getter breaks the build instead of silently skipping.

import 'package:flutter/widgets.dart' show Locale;
import 'package:flutter_test/flutter_test.dart';

import 'package:ollama_app/l10n/gen/app_localizations.dart';
import 'package:ollama_app/l10n/gen/app_localizations_de.dart';
import 'package:ollama_app/l10n/gen/app_localizations_en.dart';
import 'package:ollama_app/l10n/gen/app_localizations_es.dart';
import 'package:ollama_app/l10n/gen/app_localizations_fa.dart';
import 'package:ollama_app/l10n/gen/app_localizations_fr.dart';
import 'package:ollama_app/l10n/gen/app_localizations_fr_ca.dart';
import 'package:ollama_app/l10n/gen/app_localizations_hy.dart';
import 'package:ollama_app/l10n/gen/app_localizations_it.dart';
import 'package:ollama_app/l10n/gen/app_localizations_pt.dart';
import 'package:ollama_app/l10n/gen/app_localizations_pt_br.dart';
import 'package:ollama_app/l10n/gen/app_localizations_ru.dart';
import 'package:ollama_app/l10n/gen/app_localizations_tr.dart';
import 'package:ollama_app/l10n/gen/app_localizations_zh.dart';

/// Expected concrete class per entry of AppLocalizations.supportedLocales.
final Map<Locale, Type> _expectedTypes = <Locale, Type>{
  const Locale('en'): AppLocalizationsEn,
  const Locale('de'): AppLocalizationsDe,
  const Locale('fa'): AppLocalizationsFa,
  const Locale('it'): AppLocalizationsIt,
  const Locale('tr'): AppLocalizationsTr,
  const Locale('zh'): AppLocalizationsZh,
  const Locale('hy'): AppLocalizationsHy,
  const Locale('ru'): AppLocalizationsRu,
  const Locale('fr'): AppLocalizationsFr,
  const Locale('es'): AppLocalizationsEs,
  const Locale('pt'): AppLocalizationsPt,
  const Locale('fr', 'CA'): AppLocalizationsFrCa,
  const Locale('pt', 'BR'): AppLocalizationsPtBr,
};

/// Untranslated ICU placeholder braces leaking into a rendered string,
/// e.g. "{model}" or "{percent}".
final RegExp _unresolvedPlaceholder = RegExp(r'\{[a-zA-Z]+\}');

/// A leaked Dart/intl `null` (e.g. an unhandled select case interpolated as
/// "null"). Word-bounded so legitimate words like Italian "Annulla" or
/// "annullata" do not trigger a false positive.
final RegExp _leakedNull = RegExp(r'\bnull\b');

/// A single localization value together with the member it came from, so
/// failures can name the exact member that misbehaved.
class _L10nString {
  const _L10nString(this.member, this.value);

  final String member;
  final String value;
}

_L10nString _s(String member, String value) => _L10nString(member, value);

// ---------------------------------------------------------------------------
// Member enumeration. Each helper covers one coherent member group; together
// they must cover every public member of the abstract AppLocalizations class.
// ---------------------------------------------------------------------------

List<_L10nString> _chatStrings(AppLocalizations l) => <_L10nString>[
      _s('appTitle', l.appTitle),
      _s('optionNewChat', l.optionNewChat),
      _s('optionSettings', l.optionSettings),
      _s('optionInstallPwa', l.optionInstallPwa),
      _s('optionNoChatFound', l.optionNoChatFound),
      _s('tipPrefix', l.tipPrefix),
      _s('tip0', l.tip0),
      _s('tip1', l.tip1),
      _s('tip2', l.tip2),
      _s('tip3', l.tip3),
      _s('tip4', l.tip4),
      _s('deleteChat', l.deleteChat),
      _s('renameChat', l.renameChat),
      _s('takeImage', l.takeImage),
      _s('uploadImage', l.uploadImage),
      _s('notAValidImage', l.notAValidImage),
      _s('imageOnlyConversation', l.imageOnlyConversation),
      _s('messageInputPlaceholder', l.messageInputPlaceholder),
    ];

List<_L10nString> _tooltipStrings(AppLocalizations l) => <_L10nString>[
      _s('tooltipAttachment', l.tooltipAttachment),
      _s('tooltipSend', l.tooltipSend),
      _s('tooltipSave', l.tooltipSave),
      _s('tooltipLetAIThink', l.tooltipLetAIThink),
      _s('tooltipAddHostHeaders', l.tooltipAddHostHeaders),
      _s('tooltipReset', l.tooltipReset),
      _s('tooltipOptions', l.tooltipOptions),
      _s('noModelSelected', l.noModelSelected),
      _s('noHostSelected', l.noHostSelected),
      _s('noSelectedModel', l.noSelectedModel),
      _s('newChatTitle', l.newChatTitle),
    ];

List<_L10nString> _modelDialogStrings(AppLocalizations l) => <_L10nString>[
      _s('modelDialogAddModel', l.modelDialogAddModel),
      _s('modelDialogAddPromptTitle', l.modelDialogAddPromptTitle),
      _s('modelDialogAddPromptDescription', l.modelDialogAddPromptDescription),
      _s('modelDialogAddPromptAlreadyExists',
          l.modelDialogAddPromptAlreadyExists),
      _s('modelDialogAddPromptInvalid', l.modelDialogAddPromptInvalid),
      _s('modelDialogAddAllowanceTitle', l.modelDialogAddAllowanceTitle),
      _s('modelDialogAddAllowanceDescription',
          l.modelDialogAddAllowanceDescription),
      _s('modelDialogAddAllowanceAllow', l.modelDialogAddAllowanceAllow),
      _s('modelDialogAddAllowanceDeny', l.modelDialogAddAllowanceDeny),
      _s('modelDialogAddAssuranceAdd', l.modelDialogAddAssuranceAdd),
      _s('modelDialogAddAssuranceCancel', l.modelDialogAddAssuranceCancel),
      _s('modelDialogAddDownloadPercentLoading',
          l.modelDialogAddDownloadPercentLoading),
      _s('modelDialogAddDownloadFailed', l.modelDialogAddDownloadFailed),
      _s('modelDialogAddDownloadSuccess', l.modelDialogAddDownloadSuccess),
    ];

List<_L10nString> _dialogStrings(AppLocalizations l) => <_L10nString>[
      _s('deleteDialogTitle', l.deleteDialogTitle),
      _s('deleteDialogDescription', l.deleteDialogDescription),
      _s('deleteDialogDelete', l.deleteDialogDelete),
      _s('deleteDialogCancel', l.deleteDialogCancel),
      _s('dialogEnterNewTitle', l.dialogEnterNewTitle),
      _s('dialogEditMessageTitle', l.dialogEditMessageTitle),
    ];

List<_L10nString> _settingsSectionStrings(AppLocalizations l) => <_L10nString>[
      _s('settingsTitleBehavior', l.settingsTitleBehavior),
      _s('settingsDescriptionBehavior', l.settingsDescriptionBehavior),
      _s('settingsTitleInterface', l.settingsTitleInterface),
      _s('settingsDescriptionInterface', l.settingsDescriptionInterface),
      _s('settingsTitleVoice', l.settingsTitleVoice),
      _s('settingsDescriptionVoice', l.settingsDescriptionVoice),
      _s('settingsTitleExport', l.settingsTitleExport),
      _s('settingsDescriptionExport', l.settingsDescriptionExport),
      _s('settingsTitleAbout', l.settingsTitleAbout),
      _s('settingsDescriptionAbout', l.settingsDescriptionAbout),
      _s('settingsSavedAutomatically', l.settingsSavedAutomatically),
      _s('settingsExperimentalAlpha', l.settingsExperimentalAlpha),
      _s('settingsExperimentalAlphaDescription',
          l.settingsExperimentalAlphaDescription),
      _s('settingsExperimentalAlphaFeature',
          l.settingsExperimentalAlphaFeature),
      _s('settingsExperimentalBeta', l.settingsExperimentalBeta),
      _s('settingsExperimentalBetaDescription',
          l.settingsExperimentalBetaDescription),
      _s('settingsExperimentalBetaFeature', l.settingsExperimentalBetaFeature),
      _s('settingsExperimentalDeprecated', l.settingsExperimentalDeprecated),
      _s('settingsExperimentalDeprecatedDescription',
          l.settingsExperimentalDeprecatedDescription),
      _s('settingsExperimentalDeprecatedFeature',
          l.settingsExperimentalDeprecatedFeature),
    ];

List<_L10nString> _hostStrings(AppLocalizations l) => <_L10nString>[
      _s('settingsHost', l.settingsHost),
      _s('settingsHostValid', l.settingsHostValid),
      _s('settingsHostChecking', l.settingsHostChecking),
      _s('settingsHostHeaderTitle', l.settingsHostHeaderTitle),
      _s('settingsHostHeaderInvalid', l.settingsHostHeaderInvalid),
    ];

List<_L10nString> _apiTokenStrings(AppLocalizations l) => <_L10nString>[
      _s('settingsApiTokenInvalid', l.settingsApiTokenInvalid),
      _s('settingsApiTokenInvalidDetailed', l.settingsApiTokenInvalidDetailed),
      _s('settingsApiTokenVerified', l.settingsApiTokenVerified),
      _s('settingsApiToken', l.settingsApiToken),
      _s('settingsApiTokenHint', l.settingsApiTokenHint),
      _s('tooltipShowToken', l.tooltipShowToken),
      _s('tooltipHideToken', l.tooltipHideToken),
    ];

List<_L10nString> _behaviorStrings(AppLocalizations l) => <_L10nString>[
      _s('settingsSystemMessage', l.settingsSystemMessage),
      _s('settingsUseSystem', l.settingsUseSystem),
      _s('settingsUseSystemDescription', l.settingsUseSystemDescription),
      _s('settingsDisableMarkdown', l.settingsDisableMarkdown),
      _s('settingsBehaviorNotUpdatedForOlderChats',
          l.settingsBehaviorNotUpdatedForOlderChats),
      _s('settingsShowModelTags', l.settingsShowModelTags),
      _s('settingsPreloadModels', l.settingsPreloadModels),
      _s('settingsResetOnModelChange', l.settingsResetOnModelChange),
      _s('settingsRequestTypeStream', l.settingsRequestTypeStream),
      _s('settingsRequestTypeRequest', l.settingsRequestTypeRequest),
      _s('settingsGenerateTitles', l.settingsGenerateTitles),
      _s('settingsEnableEditing', l.settingsEnableEditing),
      _s('settingsAskBeforeDelete', l.settingsAskBeforeDelete),
      _s('settingsShowTips', l.settingsShowTips),
      _s('settingsKeepModelLoadedAlways', l.settingsKeepModelLoadedAlways),
      _s('settingsKeepModelLoadedNever', l.settingsKeepModelLoadedNever),
      _s('settingsKeepModelLoadedFor', l.settingsKeepModelLoadedFor),
      _s('settingsTimeoutMultiplier', l.settingsTimeoutMultiplier),
      _s('settingsTimeoutMultiplierDescription',
          l.settingsTimeoutMultiplierDescription),
      _s('settingsTimeoutMultiplierExample',
          l.settingsTimeoutMultiplierExample),
      _s('settingsEnableHapticFeedback', l.settingsEnableHapticFeedback),
      _s('settingsMaximizeOnStart', l.settingsMaximizeOnStart),
      _s('settingsBrightnessSystem', l.settingsBrightnessSystem),
      _s('settingsBrightnessLight', l.settingsBrightnessLight),
      _s('settingsBrightnessDark', l.settingsBrightnessDark),
      _s('settingsThemeDevice', l.settingsThemeDevice),
      _s('settingsThemeOllama', l.settingsThemeOllama),
      _s('settingsTemporaryFixes', l.settingsTemporaryFixes),
      _s('settingsTemporaryFixesDescription',
          l.settingsTemporaryFixesDescription),
      _s('settingsTemporaryFixesInstructions',
          l.settingsTemporaryFixesInstructions),
      _s('settingsTemporaryFixesNoFixes', l.settingsTemporaryFixesNoFixes),
    ];

List<_L10nString> _voiceStrings(AppLocalizations l) => <_L10nString>[
      _s('settingsVoicePermissionLoading', l.settingsVoicePermissionLoading),
      _s('settingsVoiceTtsNotSupported', l.settingsVoiceTtsNotSupported),
      _s('settingsVoiceTtsNotSupportedDescription',
          l.settingsVoiceTtsNotSupportedDescription),
      _s('settingsVoicePermissionNot', l.settingsVoicePermissionNot),
      _s('settingsVoiceNotEnabled', l.settingsVoiceNotEnabled),
      _s('settingsVoiceNotSupported', l.settingsVoiceNotSupported),
      _s('settingsVoiceEnable', l.settingsVoiceEnable),
      _s('settingsVoiceNoLanguage', l.settingsVoiceNoLanguage),
      _s('settingsVoiceLimitLanguage', l.settingsVoiceLimitLanguage),
      _s('settingsVoicePunctuation', l.settingsVoicePunctuation),
    ];

List<_L10nString> _exportStrings(AppLocalizations l) => <_L10nString>[
      _s('settingsExportChats', l.settingsExportChats),
      _s('settingsExportChatsSuccess', l.settingsExportChatsSuccess),
      _s('settingsImportChats', l.settingsImportChats),
      _s('settingsImportChatsTitle', l.settingsImportChatsTitle),
      _s('settingsImportChatsDescription', l.settingsImportChatsDescription),
      _s('settingsImportChatsImport', l.settingsImportChatsImport),
      _s('settingsImportChatsCancel', l.settingsImportChatsCancel),
      _s('settingsImportChatsSuccess', l.settingsImportChatsSuccess),
      _s('settingsExportInfo', l.settingsExportInfo),
      _s('settingsExportWarning', l.settingsExportWarning),
    ];

List<_L10nString> _updateStrings(AppLocalizations l) => <_L10nString>[
      _s('settingsUpdateCheck', l.settingsUpdateCheck),
      _s('settingsUpdateChecking', l.settingsUpdateChecking),
      _s('settingsUpdateLatest', l.settingsUpdateLatest),
      _s('settingsUpdateRateLimit', l.settingsUpdateRateLimit),
      _s('settingsUpdateIssue', l.settingsUpdateIssue),
      _s('settingsUpdateDialogTitle', l.settingsUpdateDialogTitle),
      _s('settingsUpdateDialogDescription',
          l.settingsUpdateDialogDescription),
      _s('settingsUpdateChangeLog', l.settingsUpdateChangeLog),
      _s('settingsUpdateDialogUpdate', l.settingsUpdateDialogUpdate),
      _s('settingsUpdateDialogCancel', l.settingsUpdateDialogCancel),
      _s('settingsCheckForUpdates', l.settingsCheckForUpdates),
      _s('settingsGithub', l.settingsGithub),
      _s('settingsReportIssue', l.settingsReportIssue),
      _s('settingsLicenses', l.settingsLicenses),
    ];

/// Every parameterized member, called once per realistic argument.
List<_L10nString> _parameterizedStrings(AppLocalizations l) => <_L10nString>[
      _s('modelDialogAddAssuranceTitle(llama3)',
          l.modelDialogAddAssuranceTitle('llama3')),
      _s('modelDialogAddAssuranceDescription(llama3)',
          l.modelDialogAddAssuranceDescription('llama3')),
      _s('modelDialogAddDownloadPercent(42)',
          l.modelDialogAddDownloadPercent('42')),
      _s('settingsHostInvalid(url)', l.settingsHostInvalid('url')),
      _s('settingsHostInvalid(host)', l.settingsHostInvalid('host')),
      _s('settingsHostInvalid(auth)', l.settingsHostInvalid('auth')),
      _s('settingsHostInvalid(timeout)', l.settingsHostInvalid('timeout')),
      _s('settingsHostInvalid(ratelimit)', l.settingsHostInvalid('ratelimit')),
      _s('settingsHostInvalid(other)', l.settingsHostInvalid('other')),
      _s('settingsHostInvalidDetailed(url)',
          l.settingsHostInvalidDetailed('url')),
      _s('settingsHostInvalidDetailed(host)',
          l.settingsHostInvalidDetailed('host')),
      _s('settingsHostInvalidDetailed(auth)',
          l.settingsHostInvalidDetailed('auth')),
      _s('settingsHostInvalidDetailed(other)',
          l.settingsHostInvalidDetailed('other')),
      _s('voiceLanguageInstruction(en_US)',
          l.voiceLanguageInstruction('en_US')),
      _s('settingsKeepModelLoadedSet(15)',
          l.settingsKeepModelLoadedSet('15')),
      _s('settingsUpdateAvailable(1.2.1)',
          l.settingsUpdateAvailable('1.2.1')),
      _s('settingsVersion(1.2.0)', l.settingsVersion('1.2.0')),
    ];

/// The accessibility-page strings, the screen-reader labels, and the
/// contact-form strings added with the accessibility work.
List<_L10nString> _accessibilityStrings(AppLocalizations l) =>
    <_L10nString>[
      _s('settingsTitleAccessibility', l.settingsTitleAccessibility),
      _s('settingsDescriptionAccessibility',
          l.settingsDescriptionAccessibility),
      _s('accessibilityStatementTitle', l.accessibilityStatementTitle),
      _s('accessibilityCommitmentIntro', l.accessibilityCommitmentIntro),
      _s('accessibilityCommitmentDetails', l.accessibilityCommitmentDetails),
      _s('accessibilityConformanceTitle', l.accessibilityConformanceTitle),
      _s('accessibilityConformanceStatus', l.accessibilityConformanceStatus),
      _s('accessibilityAaaMeasuresTitle', l.accessibilityAaaMeasuresTitle),
      _s('accessibilityAaaMeasures', l.accessibilityAaaMeasures),
      _s('accessibilityAodaTitle', l.accessibilityAodaTitle),
      _s('accessibilityAodaText', l.accessibilityAodaText),
      _s('accessibilityStandardsEuropeTitle',
          l.accessibilityStandardsEuropeTitle),
      _s('accessibilityStandardsEuropeText',
          l.accessibilityStandardsEuropeText),
      _s('accessibilityStandardsUsTitle', l.accessibilityStandardsUsTitle),
      _s('accessibilityStandardsUsText', l.accessibilityStandardsUsText),
      _s('accessibilityKnownIssuesTitle', l.accessibilityKnownIssuesTitle),
      _s('accessibilityKnownIssues', l.accessibilityKnownIssues),
      _s('accessibilityLastValidated(1.2.0)',
          l.accessibilityLastValidated('1.2.0')),
      _s('accessibilityTestsTitle', l.accessibilityTestsTitle),
      _s('accessibilityTestsIntro', l.accessibilityTestsIntro),
      _s('accessibilityTestsCheckColumn', l.accessibilityTestsCheckColumn),
      _s('accessibilityTestsStatusColumn', l.accessibilityTestsStatusColumn),
      _s('accessibilityTestsPass', l.accessibilityTestsPass),
      _s('accessibilityTestsCiNote', l.accessibilityTestsCiNote),
      _s('accessibilityTestContrast', l.accessibilityTestContrast),
      _s('accessibilityTestLabeledTapTarget',
          l.accessibilityTestLabeledTapTarget),
      _s('accessibilityTestAndroidTapTarget',
          l.accessibilityTestAndroidTapTarget),
      _s('accessibilityTestIosTapTarget', l.accessibilityTestIosTapTarget),
      _s('accessibilityTestSemanticsPresent',
          l.accessibilityTestSemanticsPresent),
      _s('accessibilityTestTraversalOrder',
          l.accessibilityTestTraversalOrder),
      _s('accessibilityTestLocalesRender', l.accessibilityTestLocalesRender),
      _s('accessibilityTestFormValidation',
          l.accessibilityTestFormValidation),
      _s('accessibilityContactTitle', l.accessibilityContactTitle),
      _s('accessibilityContactIntro', l.accessibilityContactIntro),
      _s('accessibilityFormName', l.accessibilityFormName),
      _s('accessibilityFormEmail', l.accessibilityFormEmail),
      _s('accessibilityFormAssistiveTech', l.accessibilityFormAssistiveTech),
      _s('accessibilityFormDescription', l.accessibilityFormDescription),
      _s('accessibilityFormDescriptionHint',
          l.accessibilityFormDescriptionHint),
      _s('accessibilityFormErrorDescription',
          l.accessibilityFormErrorDescription),
      _s('accessibilityFormErrorEmail', l.accessibilityFormErrorEmail),
      _s('accessibilityFormSendGithub', l.accessibilityFormSendGithub),
      _s('accessibilityFormEmailSubject', l.accessibilityFormEmailSubject),
      _s('accessibilityFormCopiedFallback',
          l.accessibilityFormCopiedFallback),
      _s('accessibilitySummaryConformance',
          l.accessibilitySummaryConformance),
      _s('accessibilitySectionStatementSummary',
          l.accessibilitySectionStatementSummary),
      _s('accessibilitySectionTestsSummary',
          l.accessibilitySectionTestsSummary),
      _s('accessibilitySectionStandardsSummary',
          l.accessibilitySectionStandardsSummary),
      _s('accessibilitySectionContactSummary',
          l.accessibilitySectionContactSummary),
      _s('accessibilitySupportLevelLimited',
          l.accessibilitySupportLevelLimited),
      _s('accessibilitySupportLevelCompliantWithLimitations',
          l.accessibilitySupportLevelCompliantWithLimitations),
      _s('tooltipResetChat', l.tooltipResetChat),
      _s('tooltipVoiceClose', l.tooltipVoiceClose),
      _s('tooltipVoiceSettings', l.tooltipVoiceSettings),
      _s('tooltipVoiceScrollToEnd', l.tooltipVoiceScrollToEnd),
      _s('tooltipWelcomeNext', l.tooltipWelcomeNext),
      _s('tooltipWelcomeFinish', l.tooltipWelcomeFinish),
      _s('accessibilityVoiceOrbListening',
          l.accessibilityVoiceOrbListening),
      _s('accessibilityVoiceOrbSpeaking',
          l.accessibilityVoiceOrbSpeaking),
      _s('accessibilityVoiceOrbThinking',
          l.accessibilityVoiceOrbThinking),
      _s('accessibilityAppLogo', l.accessibilityAppLogo),
      _s('accessibilityWelcomePage1', l.accessibilityWelcomePage1),
      _s('accessibilityWelcomePage2', l.accessibilityWelcomePage2),
      _s('accessibilityWelcomePage3', l.accessibilityWelcomePage3),
    ];

/// All 220 public members of AppLocalizations, evaluated for [l].
List<_L10nString> collectAllStrings(AppLocalizations l) => <_L10nString>[
      ..._chatStrings(l),
      ..._tooltipStrings(l),
      ..._modelDialogStrings(l),
      ..._dialogStrings(l),
      ..._settingsSectionStrings(l),
      ..._hostStrings(l),
      ..._apiTokenStrings(l),
      ..._behaviorStrings(l),
      ..._voiceStrings(l),
      ..._exportStrings(l),
      ..._updateStrings(l),
      ..._accessibilityStrings(l),
      ..._parameterizedStrings(l),
    ];

void main() {
  // ---------------------------------------------------------------------
  group('locale resolution', () {
    test('expectation map covers every supported locale', () {
      for (final locale in AppLocalizations.supportedLocales) {
        expect(_expectedTypes, containsPair(locale, isNotNull),
            reason: 'no expected concrete class mapped for $locale');
      }
    });

    for (final locale in AppLocalizations.supportedLocales) {
      final Type? expected = _expectedTypes[locale];
      test('lookupAppLocalizations($locale) returns the expected class', () {
        expect(expected, isNotNull,
            reason: 'no expected concrete class mapped for $locale');

        late AppLocalizations resolved;
        expect(() => resolved = lookupAppLocalizations(locale),
            returnsNormally);

        expect(resolved.runtimeType, expected,
            reason: '$locale resolved to the wrong concrete class');
        expect(resolved.localeName, locale.toString(),
            reason: 'localeName not canonicalized for $locale');
      });
    }

    test('fr_CA instance reports localeName fr_CA', () {
      final frCa = lookupAppLocalizations(const Locale('fr', 'CA'));
      expect(frCa, isA<AppLocalizationsFrCa>());
      expect(frCa.localeName, 'fr_CA');
    });

    test('pt_BR instance reports localeName pt_BR', () {
      final ptBr = lookupAppLocalizations(const Locale('pt', 'BR'));
      expect(ptBr, isA<AppLocalizationsPtBr>());
      expect(ptBr.localeName, 'pt_BR');
    });
  });

  // ---------------------------------------------------------------------
  for (final locale in AppLocalizations.supportedLocales) {
    final tag = locale.toString();

    group('all strings non-empty and crash-free [$tag]', () {
      test('every public member yields a usable string', () {
        final l = lookupAppLocalizations(locale);
        final strings = collectAllStrings(l);

        // 219 members; settingsHostInvalid is called with 6 select arguments
        // and settingsHostInvalidDetailed with 4, hence 227 values.
        expect(strings.length, 227,
            reason: 'member enumeration drifted from the abstract class');

        for (final item in strings) {
          final reason = '$tag: ${item.member}';
          expect(item.value.trim(), isNotEmpty, reason: reason);
          expectLater(item.value, isNot(matches(_unresolvedPlaceholder)),
              reason: '$reason has an unresolved ICU placeholder');
          expect(item.value.contains(_leakedNull), isFalse,
              reason: '$reason contains a leaked null');
        }
      });

      test('settingsHostInvalid select cases stay distinct', () {
        final l = lookupAppLocalizations(locale);
        final url = l.settingsHostInvalid('url');
        final auth = l.settingsHostInvalid('auth');
        final other = l.settingsHostInvalid('other');

        expect(url, isNot(equals(auth)),
            reason: '$tag: url and auth select cases collapsed');
        expect(auth, isNot(equals(other)),
            reason: '$tag: auth fell back to the other case');
      });

      test('settingsHostInvalidDetailed select cases stay distinct', () {
        final l = lookupAppLocalizations(locale);
        final url = l.settingsHostInvalidDetailed('url');
        final auth = l.settingsHostInvalidDetailed('auth');
        final other = l.settingsHostInvalidDetailed('other');

        expect(url, isNot(equals(auth)),
            reason: '$tag: detailed url and auth cases collapsed');
        expect(auth, isNot(equals(other)),
            reason: '$tag: detailed auth fell back to the other case');
      });

      test('critical error strings are present', () {
        final l = lookupAppLocalizations(locale);

        final critical = <String, String>{
          'settingsApiTokenInvalid': l.settingsApiTokenInvalid,
          'settingsApiTokenInvalidDetailed': l.settingsApiTokenInvalidDetailed,
          'settingsApiTokenVerified': l.settingsApiTokenVerified,
          'settingsApiToken': l.settingsApiToken,
          'settingsApiTokenHint': l.settingsApiTokenHint,
          'tooltipShowToken': l.tooltipShowToken,
          'tooltipHideToken': l.tooltipHideToken,
          'voiceLanguageInstruction(en_US)': l.voiceLanguageInstruction('en_US'),
        };
        for (final entry in critical.entries) {
          expect(entry.value.trim(), isNotEmpty,
              reason: '$tag: ${entry.key} is empty');
        }

        expect(l.settingsApiTokenInvalidDetailed,
            isNot(equals(l.settingsApiTokenInvalid)),
            reason: '$tag: detailed token guidance is identical to the '
                'short error');
      });
    });
  }
}