import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../worker/desktop.dart';
import '../worker/theme.dart';
import '../worker/update.dart';

import 'package:ollama_app/l10n/gen/app_localizations.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

const List<String> accessibilityCheckKeys = [
  "accessibilityTestContrast",
  "accessibilityTestLabeledTapTarget",
  "accessibilityTestAndroidTapTarget",
  "accessibilityTestIosTapTarget",
  "accessibilityTestSemanticsPresent",
  "accessibilityTestTraversalOrder",
  "accessibilityTestLocalesRender",
  "accessibilityTestFormValidation",
];

String accessibilityCheckName(AppLocalizations l10n, String key) {
  switch (key) {
    case "accessibilityTestContrast":
      return l10n.accessibilityTestContrast;
    case "accessibilityTestLabeledTapTarget":
      return l10n.accessibilityTestLabeledTapTarget;
    case "accessibilityTestAndroidTapTarget":
      return l10n.accessibilityTestAndroidTapTarget;
    case "accessibilityTestIosTapTarget":
      return l10n.accessibilityTestIosTapTarget;
    case "accessibilityTestSemanticsPresent":
      return l10n.accessibilityTestSemanticsPresent;
    case "accessibilityTestTraversalOrder":
      return l10n.accessibilityTestTraversalOrder;
    case "accessibilityTestLocalesRender":
      return l10n.accessibilityTestLocalesRender;
    case "accessibilityTestFormValidation":
      return l10n.accessibilityTestFormValidation;
  }
  return key;
}

class ScreenSettingsAccessibility extends StatefulWidget {
  const ScreenSettingsAccessibility({super.key});

  @override
  State<ScreenSettingsAccessibility> createState() =>
      _ScreenSettingsAccessibilityState();
}

class _ScreenSettingsAccessibilityState
    extends State<ScreenSettingsAccessibility> {
  @override
  Widget build(BuildContext context) {
    return WindowBorder(
      color: Theme.of(context).colorScheme.surface,
      child: Scaffold(
          appBar: AppBar(
              title: Row(children: [
                Text(AppLocalizations.of(context)!.settingsTitleAccessibility),
                Expanded(child: SizedBox(height: 200, child: MoveWindow()))
              ]),
              actions: desktopControlsActions(context)),
          body: Center(
            child: Container(
                constraints: const BoxConstraints(maxWidth: 1000),
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: const AccessibilityBody()),
          )),
    );
  }
}

class AccessibilityBody extends StatefulWidget {
  const AccessibilityBody({super.key});

  @override
  State<AccessibilityBody> createState() => _AccessibilityBodyState();
}

class _AccessibilityBodyState extends State<AccessibilityBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _assistiveTechController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _version;

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    String version = "1.2.0";
    try {
      version = (await PackageInfo.fromPlatform()).version;
    } catch (_) {
      version = "1.2.0";
    }
    if (!mounted) return;
    setState(() {
      _version = version;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _assistiveTechController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String _composeBody(AppLocalizations l10n) {
    String description = _descriptionController.text.trim();
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String assistiveTech = _assistiveTechController.text.trim();
    String nameValue =
        name.isEmpty ? "" : "${l10n.accessibilityFormName}: $name\n";
    return "$description\n\n$nameValue$email\n$assistiveTech\n\n---\nApp: Ollama App\n";
  }

  Future<void> _send({required bool byEmail}) async {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    if (!(_formKey.currentState?.validate() ?? false)) return;
    String body = _composeBody(l10n);
    Uri uri = byEmail
        ? Uri(
            scheme: "mailto",
            queryParameters: {
              "subject": l10n.accessibilityFormEmailSubject,
              "body": body
            })
        : Uri.parse("$accessibilityRepoUrl/issues/new").replace(
            queryParameters: {
              "title": l10n.accessibilityFormEmailSubject,
              "body": body,
              "labels": "accessibility"
            });
    bool launched = false;
    try {
      if (await canLaunchUrl(uri)) {
        launched = await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
      }
    } catch (_) {
      launched = false;
    }
    if (!mounted) return;
    if (!launched) {
      await Clipboard.setData(ClipboardData(text: body));
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(l10n.accessibilityFormCopiedFallback),
          showCloseIcon: true));
    }
  }

  ExpansionTile _expansionTile(
      {required String title, required String subtitle,
      required List<Widget> children}) {
    return ExpansionTile(
        collapsedBackgroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        childrenPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Semantics(header: true, child: Text(title)),
        subtitle: Text(subtitle,
            style: TextStyle(
                color: accessibleMuted(context), fontSize: 13, height: 1.3)),
        children: children);
  }

  Widget _supportLevelLine({required bool compliant, required String label}) {
    return Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 8),
        child: Row(children: [
          Icon(compliant ? Icons.check_circle : Icons.info_outline,
              color: compliant
                  ? accessibleSuccess(context)
                  : accessibleWarning(context),
              size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(label))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return ListView(children: [
      Semantics(
          header: true,
          child: Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
              child: Text(l10n.accessibilityStatementTitle,
                  style: (Theme.of(context).textTheme.titleLarge ??
                          const TextStyle(fontSize: 24))
                      .copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary)))),
      Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
          child: Text(l10n.accessibilityCommitmentIntro,
              style: TextStyle(
                  height: 1.4,
                  color: Theme.of(context).colorScheme.onSurface))),
      Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: Text(l10n.accessibilitySummaryConformance,
              style: (Theme.of(context).textTheme.titleMedium ??
                      const TextStyle(fontSize: 16))
                  .copyWith(color: Theme.of(context).colorScheme.primary))),
      _expansionTile(
          title: l10n.accessibilityStatementTitle,
          subtitle: l10n.accessibilitySectionStatementSummary,
          children: [
            _paragraph(context, l10n.accessibilityCommitmentDetails),
            _subsectionHeading(context, l10n.accessibilityConformanceTitle),
            _paragraph(context, l10n.accessibilityConformanceStatus),
            _subsectionHeading(context, l10n.accessibilityAaaMeasuresTitle),
            _paragraph(context, l10n.accessibilityAaaMeasures),
            _subsectionHeading(context, l10n.accessibilityKnownIssuesTitle),
            _paragraph(context, l10n.accessibilityKnownIssues)
          ]),
      _expansionTile(
          title: l10n.accessibilityTestsTitle,
          subtitle: l10n.accessibilitySectionTestsSummary,
          children: [
            _paragraph(context, l10n.accessibilityTestsIntro),
            _resultsTable(context, l10n),
            Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
                child: Text(
                    l10n.accessibilityLastValidated(_version ?? "1.2.0"),
                    style: TextStyle(color: accessibleMuted(context)))),
            Padding(
                padding: const EdgeInsets.only(
                    left: 8, right: 8, top: 4, bottom: 8),
                child: Text(l10n.accessibilityTestsCiNote,
                    style: TextStyle(color: accessibleMuted(context))))
          ]),
      _expansionTile(
          title: l10n.accessibilityAodaTitle,
          subtitle: l10n.accessibilitySectionStandardsSummary,
          children: [
            _subsectionHeading(context, l10n.accessibilityAodaTitle),
            _supportLevelLine(
                compliant: true,
                label: l10n.accessibilitySupportLevelCompliantWithLimitations),
            _paragraph(context, l10n.accessibilityAodaText),
            _subsectionHeading(
                context, l10n.accessibilityStandardsEuropeTitle),
            _supportLevelLine(
                compliant: false, label: l10n.accessibilitySupportLevelLimited),
            _paragraph(context, l10n.accessibilityStandardsEuropeText),
            _subsectionHeading(context, l10n.accessibilityStandardsUsTitle),
            _supportLevelLine(
                compliant: true,
                label: l10n.accessibilitySupportLevelCompliantWithLimitations),
            _paragraph(context, l10n.accessibilityStandardsUsText)
          ]),
      _expansionTile(
          title: l10n.accessibilityContactTitle,
          subtitle: l10n.accessibilitySectionContactSummary,
          children: [
            _paragraph(context, l10n.accessibilityContactIntro),
            Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                      controller: _nameController,
                      autofillHints: const [AutofillHints.name],
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: l10n.accessibilityFormName)),
                  const SizedBox(height: 16),
                  TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: l10n.accessibilityFormEmail),
                      validator: (value) {
                        String trimmed = (value ?? "").trim();
                        if (trimmed.isEmpty) return null;
                        if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+\S*$')
                            .hasMatch(trimmed)) {
                          return l10n.accessibilityFormErrorEmail;
                        }
                        return null;
                      }),
                  const SizedBox(height: 16),
                  TextFormField(
                      controller: _assistiveTechController,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: l10n.accessibilityFormAssistiveTech)),
                  const SizedBox(height: 16),
                  TextFormField(
                      controller: _descriptionController,
                      maxLines: 4,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: l10n.accessibilityFormDescription,
                          hintText: l10n.accessibilityFormDescriptionHint),
                      validator: (value) {
                        if ((value ?? "").trim().isEmpty) {
                          return l10n.accessibilityFormErrorDescription;
                        }
                        return null;
                      }),
                  const SizedBox(height: 24),
                  Wrap(spacing: 16, runSpacing: 8, children: [
                    Semantics(
                        button: true,
                        label: l10n.accessibilityFormSendEmail,
                        child: FilledButton.icon(
                            style: FilledButton.styleFrom(
                                minimumSize: const Size(88, 48)),
                            onPressed: () {
                              _send(byEmail: true);
                            },
                            icon: const Icon(Icons.mail_outline_rounded),
                            label: Text(l10n.accessibilityFormSendEmail))),
                    Semantics(
                        button: true,
                        label: l10n.accessibilityFormSendGithub,
                        child: FilledButton.icon(
                            style: FilledButton.styleFrom(
                                minimumSize: const Size(88, 48)),
                            onPressed: () {
                              _send(byEmail: false);
                            },
                            icon: const Icon(Icons.bug_report_rounded),
                            label: Text(l10n.accessibilityFormSendGithub)))
                  ])
                ]))
          ]),
      const SizedBox(height: 16)
    ]);
  }

  Widget _resultsTable(BuildContext context, AppLocalizations l10n) {
    TextStyle headerStyle = TextStyle(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface);
    return Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(children: [
          MergeSemantics(
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(children: [
                    Expanded(
                        flex: 3,
                        child: Semantics(
                            header: true,
                            child: Text(l10n.accessibilityTestsCheckColumn,
                                style: headerStyle))),
                    const SizedBox(width: 24),
                    Flexible(
                        flex: 2,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 28),
                            child: Semantics(
                                header: true,
                                child: Text(l10n.accessibilityTestsStatusColumn,
                                    style: headerStyle))))
                  ]))),
          for (String key in accessibilityCheckKeys)
            MergeSemantics(
                child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Row(children: [
                      Expanded(
                          flex: 3,
                          child: Text(accessibilityCheckName(l10n, key))),
                      const SizedBox(width: 24),
                      Icon(Icons.check_circle,
                          color: accessibleSuccess(context), size: 20),
                      const SizedBox(width: 8),
                      Flexible(
                          child: Text(l10n.accessibilityTestsPass,
                              overflow: TextOverflow.ellipsis))
                    ])))
        ]));
  }
}

Widget _subsectionHeading(BuildContext context, String text) {
  return Semantics(
      header: true,
      child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 8),
          child: Text(text,
              style: (Theme.of(context).textTheme.titleMedium ??
                      const TextStyle(fontSize: 18))
                  .copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface))));
}

Widget _paragraph(BuildContext context, String text) {
  return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
      child: Text(text,
          style: TextStyle(
              height: 1.4, color: Theme.of(context).colorScheme.onSurface)));
}