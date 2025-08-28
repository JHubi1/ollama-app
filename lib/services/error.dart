import 'dart:async';
import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ollama_dart/ollama_dart.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/gen/app_localizations.dart';

final _logIdRegex = RegExp(r"^[A-Z0-9]{2,16}$");

typedef ErrorGuardErrorMessageGenerator = String Function(Object exception);
typedef ErrorGuardDetailsMessageGenerator =
    String? Function(Object exception, StackTrace stackTrace);
typedef ErrorGuardIgnoreIfGenerator = bool Function(Object exception);

String _defaultErrorMessage(Object exception) => switch (exception) {
  OllamaClientException _ => "Unknown client error",
  AssertionError _ =>
    exception.toString().split(": ").elementAtOrNull(4) ??
        "An assertion failed",
  TimeoutException _ => "Request timed out",
  SocketException _ || HttpException _ => "Could not connect to server",
  TlsException _ => "Could not establish secure connection",
  StateError _ => "Invalid state encountered",
  _ => "An unknown error occurred",
};
String? _defaultDetailsMessage(
  Object exception,
  StackTrace stackTrace,
) => switch (exception) {
  OllamaClientException e =>
    e.body.toString().startsWith("ClientException with SocketException")
        ? "A network error occurred while trying to connect to the server."
              "\n\nYou may check your network connection or server reachability and try again."
        : "The Ollama API client received a faulty response with code `${e.code}`."
              "\n\nPlease check your Ollama server or proxy configuration and try again.",
  AssertionError _ =>
    "An assertion failed, meaning that the app is misconfigured or a bug occurred."
        "\n\nAssertions are used to check for conditions that should never happen."
        "\n\n<https://en.wikipedia.org/wiki/Assertion_(software_development)>",
  TimeoutException _ =>
    "Time ran out while waiting for a response from the server."
        "\n\nThis might be caused by a slow or unresponsive server, or a network issue.\nYou may try increasing the Timeout Multiplier in the settings.",
  SocketException _ || HttpException _ =>
    "A ${exception.runtimeType.toString().split(RegExp(r"(?=[A-Z])")).join(" ").toLowerCase()} might be caused by a slow or unresponsive server, or a network issue."
        "\n\nYou may check your network connection and try again.",
  TlsException _ =>
    "An error occurred while trying to establish a secure connection via TLS."
        "\n\nThis might be caused by an invalid or expired certificate, though this should not happen. Please report this issue to the developers.",
  StateError _ =>
    "Now, this is not good.\n\nYou should report this issue to the developers. Try restarting the app.",
  _ => null,
};
bool _defaultIgnoreIf(Object exception) => false;

ErrorGuardErrorMessageGenerator errorGuardErrorMessageWithFallback(
  String? Function(Object exception) errorMessage,
) => (Object exception) {
  try {
    return errorMessage.call(exception)!;
  } catch (e) {
    return _defaultErrorMessage(exception);
  }
};
ErrorGuardDetailsMessageGenerator errorGuardDetailsMessageWithFallback(
  ErrorGuardDetailsMessageGenerator detailsMessage,
) => (Object exception, StackTrace stackTrace) {
  try {
    // throws error if null, so catch block is called
    return detailsMessage.call(exception, stackTrace)!;
  } catch (_) {
    return _defaultDetailsMessage(exception, stackTrace);
  }
};

ErrorGuardErrorMessageGenerator errorGuardErrorMessageWithFallbackSingle(
  Type exceptionType,
  String message,
) => errorGuardErrorMessageWithFallback(
  (exception) => (exception.runtimeType == exceptionType) ? message : null,
);
ErrorGuardDetailsMessageGenerator errorGuardDetailsMessageWithFallbackSingle(
  Type exception,
  String message,
) => errorGuardDetailsMessageWithFallback(
  (e, _) => (e.runtimeType == exception) ? message : null,
);

/// Runs the given [action] and catches any exceptions that occur.
///
/// If the execution of [action] is successful, the result of the function is
/// returned.
///
/// If an exception occurs, a SnackBar is shown with the error message. The user
/// can then view more details about the error and where is occurred and is able
/// to report it.
///
/// If this function returns `null`, all code flow following this call should
/// be skipped.
///
/// ***Important:*** You must catch all async functions carefully! Do this using
/// [Future.catchError] with [Error.throwWithStackTrace] as the callback.
///
/// [logId] is an optional identifier for this [errorGuard] call. It is
/// displayed in the UI dialog and submitted with the report, if done. This
/// should not be a word, but rather a random string. This should be constant
/// across app restarts or re-compiles. It must be a string of 2 to 16
/// alphanumeric characters, starting with a letter. Other values will be
/// ignored. The recommended length is 8 characters.
///
/// To generate a random log ID, run: `dart run tools/logid.dart`
///
/// The [errorMessage] function is used to generate the error message. This
/// should be a short message that describes the error in a user-friendly way.
/// It should not contain any technical details or stack traces, but rather
/// a simple description of what task went wrong. The [errorMessage.exception]
/// parameter should only be used to determine the type of error and should not
/// be used to generate the message directly. The message should not be longer
/// than about 60 characters, while it is recommended to keep it under 35
/// characters.
/// An example would be "Unable to connect to the server" or "Server didn't
/// return a valid response".
///
/// The [detailsMessage] function is used to generate a more detailed message.
/// This should contain more information about the error, such as the
/// circumstances and maybe a prediction of the cause. This message should not
/// include any exception or stack trace information, because those are printed
/// separately, but rather a more detailed description of the error. The message
/// can be longer, it is not limited to a specific length, but should still be
/// direct and to the point. This message may contain a link to information
/// about the error, such as a documentation page or a Wiki article separated
/// by a new paragraph using the `<https://example.com>` syntax.
/// An example would be "The server might be down for maintenance" or "This
/// might be because of an invalid server configuration".
///
/// Both [errorMessage] and [detailsMessage] support a rudimentary Markdown-like
/// formatting for inline code (`` `code` ``), italic (`*italic*`) and links
/// (`<https://example.com>`).
///
/// [enableReporting] can be used to disable the reporting feature. This can be
/// useful if it's certain that the error is not caused by a bug in the app,
/// but rather by a user error or a misconfiguration. [forceReporting] can be
/// used to force the reporting of the error.
Future<T?> errorGuard<T>(
  BuildContext context,
  String? logId,
  FutureOr<T> Function() action, {
  ErrorGuardErrorMessageGenerator errorMessage = _defaultErrorMessage,
  ErrorGuardDetailsMessageGenerator detailsMessage = _defaultDetailsMessage,
  ErrorGuardIgnoreIfGenerator ignoreIf = _defaultIgnoreIf,
  bool instantDialog = false,
  bool enableDetails = true,
  bool enableReporting = true,
  bool forceReporting = false,
}) async {
  assert(
    logId == null || _logIdRegex.hasMatch(logId),
    "`logId` must be a string of 2 to 16 alphanumeric characters",
  );

  assert(
    enableDetails || !instantDialog,
    "`enableDetails` must be `true` if `instantDialog` is `true`",
  );
  if (instantDialog) enableDetails = true;

  assert(
    enableReporting || !forceReporting,
    "`enableReporting` must be `true` if `forceReporting` is true",
  );
  if (forceReporting) {
    enableReporting = true;
    instantDialog = true;
  }

  try {
    return await Future.value(
      action.call(),
    ).catchError(Error.throwWithStackTrace);
  } catch (exception, stackTrace) {
    if (context.mounted && !ignoreIf.call(exception)) {
      var dateTime = DateTime.now();
      var colorScheme = Theme.of(context).colorScheme;

      logId = logId?.toUpperCase();
      if (logId != null && !_logIdRegex.hasMatch(logId)) {
        logId = null;
      }

      String? exceptionText;
      try {
        exceptionText = exception.toString().trim();
        if (exceptionText.isEmpty) {
          exceptionText = null;
        }
      } catch (_) {}

      String errorMessageText;
      try {
        errorMessageText = errorMessage.call(exception);
        errorMessageText = errorMessageText.trim();
        assert(errorMessageText.isNotEmpty, "Error message must not be empty");
        if (!errorMessageText.endsWith(".")) errorMessageText += ".";
      } catch (_) {
        errorMessageText = _defaultErrorMessage(exception).trim();
      }

      String? detailsMessageText;
      try {
        detailsMessageText = detailsMessage.call(exception, stackTrace);
        detailsMessageText = detailsMessageText?.trim();
        if (detailsMessageText != null) {
          assert(
            detailsMessageText.isNotEmpty,
            "Details message must not be empty",
          );
          if (detailsMessageText.isEmpty) {
            detailsMessageText = null;
          } else if (!detailsMessageText.endsWith(".") &&
              !detailsMessageText.endsWith(">")) {
            detailsMessageText += ".";
          }
        }
      } catch (_) {
        detailsMessageText = _defaultDetailsMessage(exception, stackTrace);
      }

      void showErrorDialog() {
        if (!context.mounted) return;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => _ErrorGuardDetailsDialog(
            logId: logId,
            dateTime: dateTime,
            exception: exceptionText,
            stackTrace: stackTrace,
            errorMessage: errorMessageText,
            detailsMessage: detailsMessageText,
            enableReporting: enableReporting,
            forceReporting: forceReporting,
          ),
        );
      }

      if (instantDialog) {
        showErrorDialog();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _removeNewlines(errorMessageText),
              style: TextStyle(color: colorScheme.onErrorContainer),
            ),
            backgroundColor: colorScheme.errorContainer,
            action: !enableDetails
                ? null
                : SnackBarAction(
                    label: AppLocalizations.of(context).errorGuardDetails,
                    textColor: colorScheme.onErrorContainer,
                    onPressed: showErrorDialog,
                  ),
          ),
        );
      }
    }
    return null;
  }
}

String _removeNewlines(String content) =>
    content.replaceAll(RegExp(r"\s*\n\s*"), " ");

class _ErrorGuardDetailsDialog extends StatefulWidget {
  final String? logId;
  final DateTime dateTime;
  final String? exception;
  final StackTrace stackTrace;
  final String errorMessage;
  final String? detailsMessage;
  final bool enableReporting;
  final bool forceReporting;

  const _ErrorGuardDetailsDialog({
    required this.logId,
    required this.dateTime,
    required this.exception,
    required this.stackTrace,
    required this.errorMessage,
    required this.detailsMessage,
    required this.enableReporting,
    required this.forceReporting,
  });

  @override
  State<_ErrorGuardDetailsDialog> createState() =>
      _ErrorGuardDetailsDialogState();
}

class _ErrorGuardDetailsDialogState extends State<_ErrorGuardDetailsDialog> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !widget.forceReporting,
      child: AlertDialog(
        title: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Transform.translate(
                offset: const Offset(0, 2),
                child: Text(
                  widget.dateTime
                      .toIso8601String()
                      .split(".")
                      .first
                      .replaceFirst("T", "\n"),
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),
            Text(AppLocalizations.of(context).errorGuardTitle),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.logId != null)
              Transform.translate(
                offset: const Offset(0, -20),
                child: Text("@${widget.logId}"),
              ),

            Text.rich(_contentFormat(context, widget.errorMessage)),
            const SizedBox(height: 8),
            if (widget.detailsMessage != null) ...[
              _ErrorGuardDetailsPanel(
                icon: const Icon(Icons.announcement_outlined),
                title: AppLocalizations.of(context).errorGuardDetails,
                content: widget.detailsMessage!,
                isExpanded: true,
                monospaced: false,
              ),
              const SizedBox(height: 8),
            ],
            _ErrorGuardDetailsPanel(
              icon: const Icon(Icons.cancel_outlined),
              title: AppLocalizations.of(context).errorGuardException,
              content:
                  widget.exception ?? "Could not retrieve exception message",
              isExpanded: kDebugMode,
              monospaced: widget.exception != null,
              italic: widget.exception == null,
            ),
            if (kDebugMode) ...[
              const SizedBox(height: 8),
              _ErrorGuardDetailsPanel(
                icon: const Icon(Icons.format_list_numbered),
                title: AppLocalizations.of(context).errorGuardStackTrace,
                content: widget.stackTrace.toString(),
              ),
            ],
          ],
        ),
        actions: [
          if (widget.enableReporting)
            TextButton.icon(
              onPressed: _report,
              onLongPress: () =>
                  Clipboard.setData(ClipboardData(text: _reportText())),
              icon: const Icon(Icons.bug_report),
              label: Text(AppLocalizations.of(context).errorGuardReport),
            ),
          if (!widget.forceReporting)
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(MaterialLocalizations.of(context).closeButtonLabel),
            ),
        ],
        scrollable: true,
        alignment: Alignment.bottomCenter,
      ),
    );
  }

  static TextSpan _contentFormat(BuildContext context, String content) {
    content = content.trim().split("\n").map((l) => l.trim()).join("\n");
    if (content.isEmpty) return const TextSpan(text: "");
    // content = content.replaceAll(RegExp(r"(?=)"), "\u{00AD}");

    var paragraphs = content.split("\n\n").map((p) => p.trim()).toList();

    InlineSpan parseInline(String text) {
      var root = <String, dynamic>{
        "type": "root",
        "children": <Map<String, dynamic>>[],
      };
      var stack = <Map<String, dynamic>>[root];
      var buf = StringBuffer();

      void flushBufferToCurrent() {
        if (buf.isEmpty) return;
        var textNode = {"type": "text", "text": buf.toString()};
        (stack.last["children"] as List).add(textNode);
        buf.clear();
      }

      var i = 0;
      while (i < text.length) {
        var ch = text[i];
        if (ch == "\\" && i + 1 < text.length) {
          buf.write(text[i + 1]);
          i += 2;
          continue;
        }

        var inCode = stack.last["type"] == "code";
        if (inCode) {
          if (ch == "`") {
            flushBufferToCurrent();
            stack.removeLast();
            i++;
          } else {
            buf.write(ch);
            i++;
          }
          continue;
        }

        if (ch == '<') {
          var endIndex = text.indexOf('>', i + 1);
          if (endIndex != -1) {
            var url = text.substring(i + 1, endIndex);
            if (url.startsWith('https://') || url.startsWith('http://')) {
              flushBufferToCurrent();
              var linkNode = {"type": "link", "url": url};
              (stack.last["children"] as List).add(linkNode);
              i = endIndex + 1;
              continue;
            }
          }
        }

        if (ch == "`") {
          flushBufferToCurrent();
          var codeNode = {"type": "code", "children": <Map<String, dynamic>>[]};
          (stack.last["children"] as List).add(codeNode);
          stack.add(codeNode);
          i++;
          continue;
        }

        if (ch == "*") {
          flushBufferToCurrent();
          if (stack.last["type"] == "italic") {
            stack.removeLast();
          } else {
            var n = {"type": "italic", "children": <Map<String, dynamic>>[]};
            (stack.last['children'] as List).add(n);
            stack.add(n);
          }
          i++;
          continue;
        }

        buf.write(ch);
        i++;
      }

      flushBufferToCurrent();

      InlineSpan build(Map<String, dynamic> node) {
        var type = node["type"] as String;
        if (type == "text") {
          return TextSpan(text: node["text"] as String);
        }

        if (type == "link") {
          var url = node["url"] as String;
          return TextSpan(
            text: url,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => launchUrl(Uri.parse(url)),
          );
        }

        var children = (node["children"] as List)
            .map<InlineSpan>((c) => build(c as Map<String, dynamic>))
            .toList();

        switch (type) {
          case "root":
            return TextSpan(children: children);
          case "italic":
            return TextSpan(
              children: children,
              style: const TextStyle(fontStyle: FontStyle.italic),
            );
          case "code":
            var codeText = (node["children"] as List)
                .where((c) => (c as Map<String, dynamic>)["type"] == "text")
                .map((c) => (c as Map<String, dynamic>)["text"] as String)
                .join();
            var widget = DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text(
                  codeText,
                  style: const TextStyle(fontFamily: "monospace"),
                ),
              ),
            );
            return WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: widget,
            );
          default:
            return TextSpan(children: children);
        }
      }

      return build(root);
    }

    return TextSpan(
      children: List.generate(paragraphs.length * 2 - 1, (index) {
        if (index.isOdd) {
          return const TextSpan(
            text: "\n\n",
            style: TextStyle(height: 0.5, color: Colors.transparent),
          );
        }
        var text = paragraphs[index ~/ 2];
        return parseInline(text);
      }),
    );
  }

  String _reportText() =>
      """
An exception was thrown during the execution of the app.

<details open>
<summary>Exception</summary>

${(widget.exception != null) ? "```\n${widget.exception}\n```" : "> Not available"}

</details>

<details>
<summary>Stack Trace</summary>

```
${widget.stackTrace.toString().trim()}
```

</details>

---

The app suggested the following cause of the issue:

- ***Error Message:*** ${_removeNewlines(widget.errorMessage)}
- ***Details Message:*** ${_removeNewlines((widget.detailsMessage ?? "None provided").trim())}"""
          .trim();

  void _report() {
    var url =
        "https://github.com/JHubi1/ollama-app/issues/new?template=bug.yaml";

    url +=
        "&description=${Uri.encodeComponent('Received error: "${widget.errorMessage.replaceFirst(RegExp(r".$"), "")}"${(widget.logId != null) ? " (@${widget.logId})" : ""}')}";

    var contextText = _reportText();
    url += "&context=${Uri.encodeComponent(contextText)}";

    Clipboard.setData(ClipboardData(text: url));
    launchUrl(Uri.parse(url));
  }
}

class _ErrorGuardDetailsPanel extends StatefulWidget {
  final Widget? icon;
  final String title;
  final String content;
  final bool isExpanded;
  final bool monospaced;
  final bool italic;

  const _ErrorGuardDetailsPanel({
    this.icon,
    required this.title,
    required this.content,
    this.isExpanded = false,
    this.monospaced = true,
    this.italic = false,
  });

  @override
  State<_ErrorGuardDetailsPanel> createState() =>
      _ErrorGuardDetailsPanelState();
}

class _ErrorGuardDetailsPanelState extends State<_ErrorGuardDetailsPanel>
    with TickerProviderStateMixin {
  bool _expanded = false;
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      value: widget.isExpanded ? 1.0 : 0.0,
      duration: kThemeAnimationDuration,
      vsync: this,
    );
    _expanded = widget.isExpanded;

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastEaseInToSlowEaseOut,
    );
  }

  void _toggleAnimation() {
    setState(() {
      _expanded = !_expanded;
      _expanded
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }

  Widget _monospacedContent({required Widget child}) {
    if (!widget.monospaced) return child;
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: GestureDetector(
          onLongPress: () {
            Feedback.forLongPress(context);
            Clipboard.setData(ClipboardData(text: widget.content.trim()));
          },
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: widget.icon,
            title: Text(widget.title),
            trailing: ExpandIcon(
              onPressed: (_) => _toggleAnimation(),
              isExpanded: _expanded,
              padding: EdgeInsets.zero,
            ),
            onTap: _toggleAnimation,
            dense: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.only(left: 12),
          ),
          SizeTransition(
            sizeFactor: _animation,
            axisAlignment: -1,
            child: _monospacedContent(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                child: widget.monospaced
                    ? Text(
                        widget.content.trim(),
                        style: const TextStyle(
                          fontFamily: "monospace",
                          height: kTextHeightNone,
                        ),
                      )
                    : Text.rich(
                        _ErrorGuardDetailsDialogState._contentFormat(
                          context,
                          widget.content.trim(),
                        ),
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontStyle: widget.italic ? FontStyle.italic : null,
                          color: widget.italic ? theme.disabledColor : null,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
