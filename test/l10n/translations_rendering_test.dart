// Widget tests for the localized UI strings of the app.
//
// Goal: prove that every supported locale resolves to a working
// AppLocalizations bundle and that a representative set of strings —
// including the longest / heaviest ones — actually render as Text widgets
// inside a constrained surface without crashing the widget tree.
//
// These tests deliberately avoid asserting specific translated words: they
// only assert that resolved strings are non-empty and that the Text widgets
// the probe rendered can be found on screen. That keeps them valid for any
// translation quality level.
//
// NOTE: the `pt`, `pt_br` and `fr_ca` generated localization files are (or
// may be) written concurrently; this file never imports them. It references
// those bundles only through `AppLocalizations.supportedLocales`,
// `AppLocalizations.localizationsDelegates` and `localeName`.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ollama_app/l10n/gen/app_localizations.dart';
import 'package:ollama_app/l10n/gen/app_localizations_de.dart';
import 'package:ollama_app/l10n/gen/app_localizations_en.dart';
import 'package:ollama_app/l10n/gen/app_localizations_es.dart';
import 'package:ollama_app/l10n/gen/app_localizations_fa.dart';
import 'package:ollama_app/l10n/gen/app_localizations_fr.dart';
import 'package:ollama_app/l10n/gen/app_localizations_hy.dart';
import 'package:ollama_app/l10n/gen/app_localizations_it.dart';
import 'package:ollama_app/l10n/gen/app_localizations_ru.dart';
import 'package:ollama_app/l10n/gen/app_localizations_tr.dart';
import 'package:ollama_app/l10n/gen/app_localizations_zh.dart';

/// Logical size of the constrained surface every probe is pumped into.
const Size _probeSurface = Size(360, 640);

/// Key on the probe's scroll view, used to grab the probe's BuildContext.
const Key _probeScrollKey = Key('l10n-probe-scroll');

/// A helper widget that renders a representative slice of the app's
/// localized strings (including the longest ones) inside a scroll view.
class L10nProbe extends StatelessWidget {
  const L10nProbe({super.key});

  /// The localized strings the probe renders, in render order.
  ///
  /// Kept as a static helper so tests can assert against exactly the strings
  /// that were rendered without duplicating the list.
  static List<String> probeStrings(AppLocalizations l10n) => <String>[
        // Generic app strings.
        l10n.appTitle,
        l10n.messageInputPlaceholder,
        // Longest / heaviest validation + hint strings.
        l10n.settingsHostInvalidDetailed('url'),
        l10n.settingsHostInvalidDetailed('host'),
        l10n.settingsHostInvalidDetailed('auth'),
        l10n.settingsHostInvalidDetailed('other'),
        l10n.settingsApiTokenInvalidDetailed,
        l10n.settingsApiTokenHint,
        l10n.settingsApiToken,
        // Experimental/beta/deprecation explanations.
        l10n.settingsExperimentalAlphaDescription,
        l10n.settingsExperimentalBetaDescription,
        l10n.settingsExperimentalDeprecatedDescription,
        // Dialog descriptions.
        l10n.deleteDialogDescription,
        l10n.modelDialogAddAllowanceDescription,
        l10n.modelDialogAddAssuranceDescription('llama3'),
        // Settings explanations.
        l10n.settingsTemporaryFixesDescription,
        l10n.settingsTemporaryFixesInstructions,
        l10n.settingsExportWarning,
        l10n.settingsExportInfo,
        l10n.settingsUseSystemDescription,
        l10n.settingsTimeoutMultiplierDescription,
        l10n.settingsVoiceTtsNotSupportedDescription,
        l10n.settingsImportChatsDescription,
        // Parameterized strings.
        l10n.voiceLanguageInstruction('en_US'),
        l10n.settingsVersion('1.2.0'),
        l10n.settingsUpdateAvailable('1.2.1'),
        l10n.settingsKeepModelLoadedSet('15'),
        l10n.modelDialogAddDownloadPercent('42'),
        // Tips: rendered both as the bare prefix and composed the way the
        // sidebar composes them (tipPrefix + tipN).
        l10n.tipPrefix,
        l10n.tipPrefix + l10n.tip0,
        l10n.tipPrefix + l10n.tip1,
        l10n.tipPrefix + l10n.tip2,
        l10n.tipPrefix + l10n.tip3,
        l10n.tipPrefix + l10n.tip4,
        // Accessibility page: the longest statement / standards paragraphs
        // plus the collapsed-section summaries and support-level labels.
        l10n.accessibilitySummaryConformance,
        l10n.accessibilityCommitmentIntro,
        l10n.accessibilityCommitmentDetails,
        l10n.accessibilityConformanceStatus,
        l10n.accessibilityAaaMeasures,
        l10n.accessibilityAodaText,
        l10n.accessibilityStandardsEuropeText,
        l10n.accessibilityStandardsUsText,
        l10n.accessibilityKnownIssues,
        l10n.accessibilityLastValidated('1.2.0'),
        l10n.accessibilityTestsIntro,
        l10n.accessibilityTestLabeledTapTarget,
        l10n.accessibilityTestAndroidTapTarget,
        l10n.accessibilityTestIosTapTarget,
        l10n.accessibilityTestSemanticsPresent,
        l10n.accessibilityTestTraversalOrder,
        l10n.accessibilityTestFormValidation,
        l10n.accessibilitySectionStatementSummary,
        l10n.accessibilitySectionTestsSummary,
        l10n.accessibilitySectionStandardsSummary,
        l10n.accessibilitySectionContactSummary,
        l10n.accessibilitySupportLevelLimited,
        l10n.accessibilitySupportLevelCompliantWithLimitations,
        l10n.accessibilityContactIntro,
        l10n.accessibilityFormDescriptionHint,
        l10n.accessibilityFormErrorDescription,
        l10n.accessibilityFormErrorEmail,
        l10n.accessibilityFormCopiedFallback,
        l10n.accessibilityVoiceOrbListening,
        l10n.accessibilityVoiceOrbSpeaking,
        l10n.accessibilityVoiceOrbThinking,
        l10n.accessibilityWelcomePage2,
        l10n.accessibilityWelcomePage3,
      ];

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      key: _probeScrollKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (final String message in probeStrings(l10n))
            Text(message, softWrap: true),
        ],
      ),
    );
  }
}

/// Concrete bundle classes that are safe to import statically (the `pt`,
/// `pt_br` and `fr_ca` gen files are intentionally absent here; the
/// country-variant locales `fr-CA` and `pt-BR` are asserted via `localeName`
/// instead).
const Map<String, Type> _concreteBundleTypes = <String, Type>{
  'en': AppLocalizationsEn,
  'de': AppLocalizationsDe,
  'es': AppLocalizationsEs,
  'fa': AppLocalizationsFa,
  'fr': AppLocalizationsFr,
  'hy': AppLocalizationsHy,
  'it': AppLocalizationsIt,
  'ru': AppLocalizationsRu,
  'tr': AppLocalizationsTr,
  'zh': AppLocalizationsZh,
};

/// Resolves the AppLocalizations bundle that is in scope at the probe's
/// scroll view and returns it (with an assertion that resolution worked).
AppLocalizations _resolvedLocalizations(WidgetTester tester) {
  final BuildContext probeContext = tester.element(find.byKey(_probeScrollKey));
  final AppLocalizations? resolved = AppLocalizations.of(probeContext);
  expect(resolved, isNotNull,
      reason: 'AppLocalizations.of(context) must resolve inside L10nProbe');
  return resolved!;
}

/// Asserts that a rendered Text is actually on screen (not clipped away
/// entirely) inside the constrained probe surface [_probeSurface].
void _expectVisible(Rect rect) {
  expect(rect.right, greaterThan(0), reason: 'rendered Text is off-screen');
  expect(rect.bottom, greaterThan(0), reason: 'rendered Text is off-screen');
  expect(rect.left, lessThan(_probeSurface.width),
      reason: 'rendered Text is off-screen');
  expect(rect.top, lessThan(_probeSurface.height),
      reason: 'rendered Text is off-screen');
}

/// Pumps the probe for [locale] on a constrained 360x640 surface.
Future<void> _pumpProbe(WidgetTester tester, Locale locale) async {
  // Constrain the test surface itself so visibility rects live in the
  // probe's own coordinate space (an RTL locale would otherwise shift the
  // home widget to the right side of the default 800x600 test window and
  // break the absolute off-screen checks).
  await tester.binding.setSurfaceSize(_probeSurface);
  addTearDown(() async {
    await tester.binding.setSurfaceSize(null);
  });
  await tester.pumpWidget(
    SizedBox(
      width: _probeSurface.width,
      height: _probeSurface.height,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        home: locale.languageCode == 'fa'
            // RTL extra check: force the ambient direction explicitly for fa,
            // on top of what Material derives from the locale itself.
            ? const Directionality(
                textDirection: TextDirection.rtl,
                child: L10nProbe(),
              )
            : const L10nProbe(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

/// Pumps only the single longest localized string in a tight 300x500 box.
///
/// This catches strings that crash layout (constraints/unbounded sizes),
/// independent of the scrollable probe. Cosmetic overflow inside the
/// scrollable probe is intentionally out of scope here.
Future<void> _pumpLongestString(WidgetTester tester, Locale locale) async {
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale,
      home: Scaffold(
        body: SizedBox(
          width: 300,
          height: 500,
          child: Builder(builder: (BuildContext context) {
            final AppLocalizations l10n = AppLocalizations.of(context)!;
            return Text(
              l10n.settingsExperimentalAlphaDescription,
              softWrap: true,
            );
          }),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // 1) One test per supported locale: probe renders, nothing crashes, the
  //    bundle resolves to the expected concrete class, and representative
  //    strings are actually on screen.
  for (final Locale locale in AppLocalizations.supportedLocales) {
    final String tag = locale.toLanguageTag();
    testWidgets('l10n rendering: $tag renders representative strings',
        (WidgetTester tester) async {
      await _pumpProbe(tester, locale);

      expect(tester.takeException(), isNull,
          reason: 'rendering localized strings crashed for locale $tag');

      final AppLocalizations resolved = _resolvedLocalizations(tester);

      // Concrete bundle type for base-language locales (the fr_ca/pt_br gen
      // files are intentionally not imported; country-variant locales are
      // asserted via localeName instead).
      final Type? expectedType = locale.countryCode == null
          ? _concreteBundleTypes[locale.languageCode]
          : null;
      if (expectedType != null) {
        expect(resolved.runtimeType, expectedType,
            reason: 'locale $tag resolved to the wrong localization bundle');
      } else {
        final String expectedLocaleName = locale.countryCode == 'CA'
            ? 'fr_CA'
            : locale.countryCode == 'BR'
                ? 'pt_BR'
                : locale.languageCode;
        expect(resolved.localeName, expectedLocaleName,
            reason: 'locale $tag resolved to the wrong localization bundle');
      }

      if (locale.languageCode == 'fa') {
        expect(Directionality.of(tester.element(find.byKey(_probeScrollKey))),
            TextDirection.rtl,
            reason: 'fa must render under RTL directionality');
      }

      // Representative strings: findable and non-empty.
      final Finder titleFinder = find.text(resolved.appTitle);
      expect(titleFinder, findsWidgets,
          reason: 'appTitle not rendered for locale $tag');
      final Text titleText = tester.widget<Text>(titleFinder.first);
      expect(titleText.data, isNotNull);
      expect(titleText.data, isNotEmpty,
          reason: 'appTitle is empty for locale $tag');

      final Finder inputFinder = find.text(resolved.messageInputPlaceholder);
      expect(inputFinder, findsWidgets,
          reason: 'messageInputPlaceholder not rendered for locale $tag');
      final Text inputText = tester.widget<Text>(inputFinder.first);
      expect(inputText.data, isNotNull);
      expect(inputText.data, isNotEmpty,
          reason: 'messageInputPlaceholder is empty for locale $tag');

      // Every string the probe rendered can be found on screen.
      final List<String> rendered = L10nProbe.probeStrings(resolved);
      for (final String message in rendered) {
        expect(find.text(message), findsWidgets,
            reason: 'rendered string missing from tree for locale $tag: '
                '"$message"');
      }

      // And they are not all clipped off-screen.
      _expectVisible(tester.getRect(titleFinder.first));
    });
  }

  // 2) fr_CA: the bundle exists (AppLocalizationsFrCa extends
  //    AppLocalizationsFr). Use a Localizations widget to load the delegate
  //    with the fr_CA locale directly and verify the French-Canada bundle
  //    renders too.
  testWidgets('l10n rendering: fr-CA bundle renders via Localizations',
      (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(_probeSurface);
    addTearDown(() async {
      await tester.binding.setSurfaceSize(null);
    });
    await tester.pumpWidget(
      SizedBox(
        width: _probeSurface.width,
        height: _probeSurface.height,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Localizations(
            locale: const Locale('fr', 'CA'),
            delegates: AppLocalizations.localizationsDelegates,
            child: const L10nProbe(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull,
        reason: 'rendering localized strings crashed for locale fr-CA');

    final AppLocalizations resolved = _resolvedLocalizations(tester);
    expect(resolved.localeName, 'fr_CA',
        reason: 'fr-CA locale must resolve to the fr_CA bundle');
    // AppLocalizationsFrCa extends AppLocalizationsFr, so this also proves a
    // French-family bundle loaded without importing the fr_ca gen file.
    expect(resolved, isA<AppLocalizationsFr>());

    final Finder titleFinder = find.text(resolved.appTitle);
    expect(titleFinder, findsWidgets,
        reason: 'appTitle not rendered for locale fr-CA');
    final Text titleText = tester.widget<Text>(titleFinder.first);
    expect(titleText.data, isNotNull);
    expect(titleText.data, isNotEmpty,
        reason: 'appTitle is empty for locale fr-CA');

    for (final String message in L10nProbe.probeStrings(resolved)) {
      expect(find.text(message), findsWidgets,
          reason: 'rendered string missing from tree for locale fr-CA: '
              '"$message"');
    }
    _expectVisible(tester.getRect(titleFinder.first));
  });

  // 3) Overflow guard: the single longest string inside a tight 300x500 box
  //    must lay out without throwing (de and hy are representatives; hy
  //    additionally exercises a non-Latin script).
  testWidgets('l10n rendering: longest string lays out in tight box (de)',
      (WidgetTester tester) async {
    await _pumpLongestString(tester, const Locale('de'));
    expect(tester.takeException(), isNull,
        reason: 'settingsExperimentalAlphaDescription crashed layout in de');
  });

  testWidgets('l10n rendering: longest string lays out in tight box (hy)',
      (WidgetTester tester) async {
    await _pumpLongestString(tester, const Locale('hy'));
    expect(tester.takeException(), isNull,
        reason: 'settingsExperimentalAlphaDescription crashed layout in hy');
  });
}