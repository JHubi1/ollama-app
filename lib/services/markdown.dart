import 'dart:math' as math;

import 'package:dynamic_system_colors/dynamic_system_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_math_fork/flutter_math.dart' as latex;
import 'package:markdown/markdown.dart' as md;
import 'package:ogp_data_extract/ogp_data_extract.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/hero_text_flight_shuttle_builder.dart';
import 'clients.dart';
import 'haptic.dart';
import 'theme.dart';

typedef Tree = List<md.Node>;

String get exampleMarkdown => r"""
# GitHub Flavored Markdown (GFM) Feature Test

This document demonstrates **every feature of GitHub Flavored Markdown**, including LaTeX math.

---

## 1. Headings

# H1
## H2
### H3
#### H4
##### H5
###### H6

---

## 2. Emphasis

- *Italic*
- *Italic*
- **Bold**
- **Bold**
- ***Bold Italic***
- ~~Strikethrough~~
- ^Superscript^
- ~Subscript~

---

- H~2~O
- E = mc^2^

---

## 3. Blockquotes

> This is a blockquote.
>
> > Nested blockquote.

### Alert

> [!NOTE]
> This is a note alert.

> [!TIP]
> This is a tip alert.

> [!IMPORTANT]
> This is an important alert.

> [!WARNING]
> This is a warning alert.

> [!CAUTION]
> This is a caution alert.

> [!OTHER]
>
> This is an alert with an unknown type.

---

## 4. Lists

### Unordered

* Item 1
  * Subitem 1
  * Subitem 2
* Item 2

### Ordered

1. First
2. Second
    1. Sub-step A
    2. Sub-step B

### Task Lists

* [x] Completed task
* [ ] Incomplete task
* [ ] Another incomplete task

---

## 5. Code

### Inline Code

Here is `inline code`.

Single word: `word`

Here is `inline code that will surely get an overflow because` the `viewport is way too small to fit it all in one line and it just keeps going.`

### Color Swatch

- This is red: `#ff0000`
- Purple with alpha: `#80008040`
- Green shorthand: `#0f0`

### Fenced Code Block

```python
print("Hello, world!")
```

```
void hello() {
  return "Hello, world!";
}
```

---

## 6. Links

* [GitHub](https://github.com)
* Autolink: https://github.com
* [Relative Link](./README.md)

---

## 7. Images

![A cat](https://cats.con.bz/1920/1080 "Cat Image")

![Another cat](https://cats.con.bz/64/64 "Another Cat")

![](https://cats.con.bz/256/256)

### With link

[![Linked cat](https://cats.con.bz/128/128)](https://github.com)

This is badge: [![](https://img.shields.io/badge/any_text-you_like-blue.png "THE BADGE")](https://google.com)

---

## 8. Tables

| Syntax    | Description |
| --------- | ----------- |
| Header    | Title       |
| Paragraph | Text        |

### Alignment

| Left | Center | Right |
| :--- | :----: | ----: |
| One  |   Two  | Three |
| Four |  Five  |   Six |

### Overflow

| This is a very long header that will surely overflow, in its very own heading even. Incredible! | Centered Header | Right Aligned Header |
| :---------------------------------------------------------------------------------------------- | :-------------: | -------------------: |
| This is a very long cell that will surely overflow and keep going and going and going and going and going and going and going and going | Centered Cell | Right Aligned Cell |

### Images

| ![banner 1: home screen](assets/screenshots/flutter_24.png) | ![banner 2: model selector](assets/screenshots/flutter_15.png) | ![banner 3: sample message](assets/screenshots/flutter_18.png) | ![banner 4: opened sidebar](assets/screenshots/flutter_26.png) |
|-|-|-|-|

---

## 9. Horizontal Rules

---
---
---

---

## 10. Escaping

\*This text is surrounded by literal asterisks\*

---

## 11. Emojis

:smile: :+1: :tada: :heart:

---

## 12. Footnotes

Here is a statement with a footnote.[^1]

[^1]: This is the footnote content.

A second one.[^2]

[^2]: This is a longer footnote that spans multiple lines. It even includes **formatting** and other elements.

And a big one.[^3]

[^3]: This is a
    bigger footnote

One with a link.[^4]

[^4]: https://github.com/JHubi1/ollama-app

And a RickRoll![^5]

[^5]: https://www.youtube.com/watch?v=dQw4w9WgXcQ

Other webpage…[^6]

[^6]: https://upsheep.net

---

## 13. Details/Spoiler

<details>
  <summary>Click to expand!</summary>
  Hidden content inside a collapsible section.
  With **formatting**, `inline code`, and even [links](https://github.com).
</details>
<details open>
  <summary>Formatting broken</summary>
  Because there is *no newline* after the summary tag.
  This **won't** be formatted, as expected.
  But *this* **will** `be` formatted `correctly`.
  With **formatting**, `inline code`, and even [links](https://github.com).
</details>
<details open>
  <summary></summary>
  Empty title.
</details>

---

## 14. LaTeX Math

Inline: $E = mc^2$

### Block

$$x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}$$

$$
\int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}
$$

---

## 15. Highlighting

<mark>Highlighted text</mark>

<mark>With *stylized* **content**, `inline code`, and even [links](https://github.com)</mark>

<mark></mark>

---

## 16. Checkbox Interactivity

* [ ] Check me
* [x] Or me
* Me not

---

## 17. Mixed Features

> Combining **bold**, `inline code`, and [links](https://github.com) in a blockquote.

---

End of test document.""";

final class _MarkdownPayload {
  final BuildContext context;
  final Uri? rootUrl;
  final Markdown markdown;
  final md.Document document;
  final Tree tree;
  final Tree sourceTree;
  final TextStyle? textStyle;
  final TapLongPressGestureRecognizer? recognizer;

  _MarkdownPayload({
    required this.context,
    this.rootUrl,
    required this.markdown,
    required this.document,
    required this.tree,
    this.textStyle,
    this.recognizer,
  }) : sourceTree = List.unmodifiable(tree);

  _MarkdownPayload._({
    required this.context,
    required this.rootUrl,
    required this.markdown,
    required this.document,
    required this.tree,
    required this.sourceTree,
    required this.textStyle,
    required this.recognizer,
  });

  _MarkdownPayload copy({
    required Tree? tree,
    TextStyle? textStyle,
    TapLongPressGestureRecognizer? recognizer,
  }) {
    return _MarkdownPayload._(
      context: context,
      rootUrl: rootUrl,
      markdown: markdown,
      document: document,
      tree: tree ?? [],
      sourceTree: sourceTree,
      textStyle: textStyle ?? this.textStyle,
      recognizer: recognizer ?? this.recognizer,
    );
  }

  Uri resolveUri(String uri) {
    if (rootUrl == null) return Uri.parse(uri);
    var rootUrlBased = rootUrl!.replace();
    if (rootUrlBased.pathSegments.last.isNotEmpty) {
      rootUrlBased = rootUrlBased.replace(
        pathSegments: [...rootUrlBased.pathSegments, ""],
      );
    }
    while (uri.startsWith("/")) {
      uri = uri.substring(1);
    }
    return rootUrlBased.resolve(uri);
  }
}

final class Markdown {
  final document = md.Document(
    blockSyntaxes: [
      LatexBlockSyntax(),
      DetailsBlockSyntax(),
      const md.AlertBlockSyntax(),
    ],
    inlineSyntaxes: [
      SuperscriptSyntax(),
      SubscriptSyntax(),
      MarkSyntax(),
      LatexInlineSyntax(),
      md.EmojiSyntax(),
      md.ColorSwatchSyntax(),
    ],
    extensionSet: md.ExtensionSet.gitHubFlavored,
    encodeHtml: false,
  );

  final String content;
  Tree get tree => document.parse(
    content.trim().replaceAll(RegExp(r"<!--.*?-->", dotAll: true), ""),
  );

  final Uri? _rootUrl;
  final TextStyle? _textStyle;
  final TapLongPressGestureRecognizer? _recognizer;

  Markdown(
    this.content, {
    Uri? rootUrl,
    TextStyle? textStyle,
    TapLongPressGestureRecognizer? recognizer,
  }) : _rootUrl = rootUrl,
       _textStyle = textStyle,
       _recognizer = recognizer;

  double get _paragraphHeight => (TextPainter(
    text: TextSpan(text: "A", style: _textStyle),
    textDirection: TextDirection.ltr,
  )..layout()).preferredLineHeight;
  final _paragraphBreak = const TextSpan(
    text: "\n\n",
    style: TextStyle(height: 0.85),
  );
  Widget _imageErrorBuilder(context, _, _) => Padding(
    padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
    child: Image.asset(
      "assets/logo512error.png",
      height: _paragraphHeight * 3,
      filterQuality: FilterQuality.low,
      color: Theme.of(context).colorScheme.onSurface,
    ),
  );

  TextStyle _mergeOrOther(TextStyle? style, TextStyle other) =>
      style?.merge(other) ?? other;

  TextSpan toTextSpan(BuildContext context) =>
      TextSpan(children: toInlineSpans(context), style: _textStyle);

  List<InlineSpan> toInlineSpans(BuildContext context) => _toInlineSpans(
    _MarkdownPayload(
      context: context,
      rootUrl: _rootUrl,
      markdown: this,
      document: document,
      tree: tree,
      textStyle: _textStyle,
      recognizer: _recognizer,
    ),
    block: true,
  );
  List<InlineSpan> _toInlineSpans(
    _MarkdownPayload payload, {
    bool block = false,
  }) {
    var context = payload.context;
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    var codeBox = BoxDecoration(
      color: colorScheme.surfaceContainerHigh,
      border: Border.all(color: colorScheme.outline),
      borderRadius: BorderRadius.circular(6),
    );

    var spans = <InlineSpan>[];
    for (var nodePair in payload.tree.asMap().entries) {
      var skipParagraphBreak = false;
      var node = nodePair.value;
      if (node is md.Text) {
        var text = node.text.replaceAll("\n", " ");
        while (text.contains("  ")) {
          text = text.replaceAll("  ", " ");
        }

        var nodeStyle = const TextStyle(
          // height: kTextHeightNone,
          fontFeatures: [FontFeature.tabularFigures()],
        );
        spans.addAll(
          text
              .split(r"(?=\s|\/|\\)")
              .map(
                (t) => TextSpan(
                  text: t,
                  style: _mergeOrOther(payload.textStyle, nodeStyle),
                  recognizer: payload.recognizer,
                ),
              ),
        );
      } else if (node is md.Element) {
        switch (node.tag) {
          case "p": // MARK: Paragraph
            var block =
                node.children!.length == 1 &&
                node.children![0] is md.Element &&
                (node.children![0] as md.Element).tag == "img";
            node.children![0] = node.children![0] is md.Text
                ? md.Text((node.children![0] as md.Text).text.trimLeft())
                : node.children![0];
            spans.addAll(
              _toInlineSpans(payload.copy(tree: node.children), block: block),
            );
          case "hr": // MARK: Horizontal Rule
            spans.add(const WidgetSpan(child: Divider()));
          case "h1" || "h2" || "h3" || "h4" || "h5" || "h6": // MARK: Headings
            var multiplier =
                (payload.textStyle?.fontSize ?? kDefaultFontSize) /
                kDefaultFontSize;
            var size =
                switch (node.tag) {
                  // stolen from HTML
                  "h1" => 32,
                  "h2" => 24,
                  "h3" => 18.72,
                  "h4" => 16,
                  "h5" => 13.28,
                  "h6" => 10.72,
                  _ => kDefaultFontSize,
                } -
                2;
            var nodeStyle = TextStyle(
              fontSize: multiplier * size,
              fontWeight: FontWeight.bold,
            );
            spans.addAll(
              _toInlineSpans(
                payload.copy(
                  tree: node.children,
                  textStyle: _mergeOrOther(payload.textStyle, nodeStyle),
                ),
              ),
            );
          case "em": // MARK: Italic
            var nodeStyle = const TextStyle(fontStyle: FontStyle.italic);
            spans.addAll(
              _toInlineSpans(
                payload.copy(
                  tree: node.children,
                  textStyle: _mergeOrOther(payload.textStyle, nodeStyle),
                ),
              ),
            );
          case "strong": // MARK: Bold
            var nodeStyle = const TextStyle(fontWeight: FontWeight.bold);
            spans.addAll(
              _toInlineSpans(
                payload.copy(
                  tree: node.children,
                  textStyle: _mergeOrOther(payload.textStyle, nodeStyle),
                ),
              ),
            );
          case "del": // MARK: Strikethrough
            var nodeStyle = const TextStyle(
              decoration: TextDecoration.lineThrough,
            );
            spans.addAll(
              _toInlineSpans(
                payload.copy(
                  tree: node.children,
                  textStyle: _mergeOrOther(payload.textStyle, nodeStyle),
                ),
              ),
            );
          case "mark": // MARK: Highlight
            var color = Colors.amberAccent
                .harmonizeWith(colorScheme.primary)
                .withValues(alpha: 0.6);
            var nodeStyle = TextStyle(
              color: color.computeLuminance() > 0.5
                  ? Colors.black
                  : Colors.white,
              backgroundColor: color,
            );
            spans.addAll(
              _toInlineSpans(
                payload.copy(
                  tree: node.children,
                  textStyle: _mergeOrOther(payload.textStyle, nodeStyle),
                ),
              ),
            );
          case "a": // MARK: Link
            var href = node.attributes["href"];
            var parsed = href == null ? null : Uri.tryParse(href);
            var valid =
                href != null &&
                parsed != null &&
                ["http", "https"].contains(parsed.scheme);
            var recognizer = valid
                ? TapLongPressGestureRecognizer(
                    onTap: () => launchUrl(payload.resolveUri(href)),
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(text: href));
                      if (!kIsWeb) lightHaptic();
                    },
                  )
                : null;

            var linkColor = Colors.lightBlue.harmonizeWith(colorScheme.primary);
            var nodeStyle = TextStyle(
              color: valid ? linkColor : theme.disabledColor,
              decoration: TextDecoration.underline,
              decorationThickness: 1.2,
              decorationColor: linkColor,
              fontStyle: valid ? null : FontStyle.italic,
            );

            spans.addAll(
              _toInlineSpans(
                payload.copy(
                  tree: node.children,
                  textStyle: _mergeOrOther(payload.textStyle, nodeStyle),
                  recognizer: recognizer,
                ),
              ),
            );
          case "sub": // MARK: Subscript/Superscript
          case "sup":
            var isSup = node.tag == "sup";

            var referenceTo =
                isSup && node.attributes["class"] == "footnote-ref"
                ? (node.children!.first as md.Element).attributes["href"]
                      ?.substring(1)
                : null;
            if (referenceTo != null) {
              md.Element? referenced;
              try {
                referenced =
                    payload.sourceTree.firstWhere(
                          (e) =>
                              e is md.Element &&
                              e.attributes["class"] == "footnotes",
                        )
                        as md.Element;
                referenced = referenced =
                    referenced.children!.first as md.Element;
                referenced =
                    referenced.children!.firstWhere(
                          (e) =>
                              e is md.Element &&
                              e.tag == "li" &&
                              e.attributes["id"] == referenceTo,
                        )
                        as md.Element;
              } catch (_) {}
              if (referenced == null) break;

              var referencedTree = List<md.Element>.from(referenced.children!);
              if (referencedTree.isEmpty) break;

              referencedTree.last = md.Element(
                referencedTree.last.tag,
                referencedTree.last.children!.sublist(
                  0,
                  referencedTree.last.children!.length - 2,
                ),
              );

              spans.add(
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Builder(
                    builder: (context) {
                      var nodeStyle = TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: math.max(
                          8.0,
                          (DefaultTextStyle.of(context).style.fontSize ??
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontSize ??
                                  14) -
                              4,
                        ),
                        fontWeight: FontWeight.w500,
                        height: kTextHeightNone,
                      );
                      return GestureDetector(
                        onTap: () {
                          if (!kIsWeb) lightHaptic();
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => _MarkdownFootnoteModal(
                              payload: payload.copy(tree: referencedTree),
                            ),
                          );
                        },
                        child: Transform.translate(
                          offset: const Offset(0, -4),
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorScheme.surfaceContainerHighest,
                              border: Border.all(color: colorScheme.outline),
                              borderRadius: BorderRadius.circular(64),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              referenceTo.substring(3),
                              style: _mergeOrOther(
                                payload.textStyle,
                                nodeStyle,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
              break;
            }

            spans.addAll(
              _toInlineSpans(payload.copy(tree: node.children)).map(
                (s) => WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Builder(
                    builder: (context) {
                      var nodeStyle = TextStyle(
                        fontSize: math.max(
                          8.0,
                          (DefaultTextStyle.of(context).style.fontSize ??
                                  theme.textTheme.bodyMedium?.fontSize ??
                                  14) -
                              4,
                        ),
                        fontWeight: FontWeight.w500,
                      );
                      return Transform.translate(
                        offset: Offset(0, 4 * (isSup ? -1 : 1)),
                        child: Text.rich(
                          s,
                          style: _mergeOrOther(payload.textStyle, nodeStyle),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          case "code": // MARK: Inline code
            var text = (node.children!.first as md.Text).text;

            var backgroundColor =
                node.attributes.containsKey("class") &&
                    node.attributes["class"] == "gfm-color_chip"
                ? (node.children!.firstWhere(
                            (e) => e is md.Element && e.tag == "span",
                          )
                          as md.Element)
                      .attributes["style"]
                : null;
            var colorCode =
                backgroundColor != null &&
                    backgroundColor.startsWith("background-color:")
                ? backgroundColor
                      .substring(17)
                      .trim()
                      .replaceAll(RegExp(r"^#|;$"), "")
                : null;
            var color = colorCode != null
                ? switch (colorCode.length) {
                    3 || 4 => () {
                      var r = int.tryParse(colorCode[0] * 2, radix: 16);
                      var g = int.tryParse(colorCode[1] * 2, radix: 16);
                      var b = int.tryParse(colorCode[2] * 2, radix: 16);
                      var a = int.tryParse(
                        (colorCode.length == 4 ? colorCode[3] : "F") * 2,
                        radix: 16,
                      );
                      return Color.fromARGB(a ?? 255, r ?? 0, g ?? 0, b ?? 0);
                    }(),
                    6 || 8 => () {
                      var r = int.tryParse(
                        colorCode.substring(0, 2),
                        radix: 16,
                      );
                      var g = int.tryParse(
                        colorCode.substring(2, 4),
                        radix: 16,
                      );
                      var b = int.tryParse(
                        colorCode.substring(4, 6),
                        radix: 16,
                      );
                      var a = int.tryParse(
                        (colorCode.length == 8
                            ? colorCode.substring(6, 8)
                            : "FF"),
                        radix: 16,
                      );
                      return Color.fromARGB(a ?? 255, r ?? 0, g ?? 0, b ?? 0);
                    }(),
                    _ => null,
                  }
                : null;

            var textStyle = _mergeOrOther(
              payload.textStyle,
              TextStyle(
                fontFamily: "monospace",
                fontSize: 14,
                backgroundColor: Colors.transparent,
                color:
                    theme.textTheme.bodyMedium?.color ??
                    theme.colorScheme.onSurface,
              ),
            );
            var parts = <Widget>[
              ...text
                  .split(RegExp(r"(?<=\s|\/|\\)"))
                  .map((t) => Text(t, style: textStyle)),
            ];
            if (color != null) {
              parts.add(
                Container(
                  height: _paragraphHeight - 1,
                  margin: const EdgeInsets.all(3),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: color,
                      border: Border.all(color: theme.colorScheme.outline),
                      shape: BoxShape.circle,
                    ),
                    child: const SizedBox.square(dimension: 10),
                  ),
                ),
              );
            }

            for (var w in parts.asMap().entries) {
              var isStart = w.key == 0;
              var isEnd = w.key == parts.length - 1;

              var decoration = BoxDecoration(
                color: codeBox.color,
                // border: Border(
                //   top: codeBox.border!.top,
                //   bottom: codeBox.border!.bottom,
                //   left: isStart
                //       ? (codeBox.border! as Border).left
                //       : BorderSide.none,
                //   right: isEnd
                //       ? (codeBox.border! as Border).right
                //       : BorderSide.none,
                // ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    isStart
                        ? (codeBox.borderRadius! as BorderRadius).topLeft.x
                        : 0,
                  ),
                  bottomLeft: Radius.circular(
                    isStart
                        ? (codeBox.borderRadius! as BorderRadius).bottomLeft.x
                        : 0,
                  ),
                  topRight: Radius.circular(
                    isEnd
                        ? (codeBox.borderRadius! as BorderRadius).topRight.x
                        : 0,
                  ),
                  bottomRight: Radius.circular(
                    isEnd
                        ? (codeBox.borderRadius! as BorderRadius).bottomRight.x
                        : 0,
                  ),
                ),
              );
              var padding = EdgeInsets.only(
                left: isStart ? 2 : 0,
                right: isEnd ? 2 : 0,
              );

              spans.addAll([
                if (w.key != 0)
                  TextSpan(
                    text: "\u{200B}",
                    style: TextStyle(
                      height: kTextHeightNone,
                      backgroundColor: decoration.color,
                    ),
                  ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    decoration: decoration,
                    padding: padding,
                    child: w.value,
                  ),
                ),
              ]);
            }
          case "pre": // MARK: Fenced code block
            var codeElement = node.children!.first as md.Element;
            var text = (codeElement.children!.first as md.Text).text.trim();
            var lang =
                codeElement.attributes.containsKey("class") &&
                    codeElement.attributes["class"]!.startsWith("language-")
                ? codeElement.attributes["class"]!.substring(9)
                : null;
            spans.add(
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        decoration: codeBox,
                        padding: const EdgeInsets.all(2),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ).copyWith(right: 24),
                            child: HighlightView(
                              text,
                              language: lang,
                              autoDetection: true,
                              theme: (theme.brightness == Brightness.light)
                                  ? preHighlightGithubThemeLight
                                  : preHighlightGithubThemeDark,
                              padding: EdgeInsets.zero,
                              textStyle: const TextStyle(
                                height: kTextHeightNone,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Transform.translate(
                        offset: const Offset(-2, 2),
                        child: Container(
                          decoration: BoxDecoration(
                            color: codeBox.color,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(2),
                              topRight: Radius.circular(2),
                            ),
                          ),
                          height: 34.6,
                          width: 34.6,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: text));
                              if (!kIsWeb) lightHaptic();
                            },
                            icon: Icon(Icons.copy, size: _paragraphHeight),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                style: const TextStyle(),
              ),
            );
          case "img": // MARK: Image
            var alt = (node.attributes["alt"] ?? "").trim();
            var title = node.attributes["title"]?.trim();
            var src = node.attributes["src"];

            void imageScreen(String src) => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => _MarkdownImageScreen(
                  src: src,
                  imageErrorBuilder: _imageErrorBuilder,
                  title: title,
                ),
              ),
            );

            if (src != null) {
              src = payload.resolveUri(src).toString();
              spans.add(
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Semantics(
                    image: true,
                    label: alt.isEmpty ? "Unlabeled image" : alt,
                    child: InkWell(
                      onTap: payload.recognizer != null
                          ? payload.recognizer!.onTap
                          : () => imageScreen(src!),
                      onLongPress: payload.recognizer != null
                          ? () {
                              payload.recognizer!.onLongPress?.call();
                            }
                          : null,
                      onDoubleTap: payload.recognizer != null
                          ? () => imageScreen(src!)
                          : null,
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: colorScheme.outline),
                          borderRadius: BorderRadius.circular(6),
                          color: colorScheme.surfaceContainer,
                        ),
                        padding: EdgeInsets.zero,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Hero(
                                tag: src,
                                child: Image.network(
                                  src,
                                  filterQuality: FilterQuality.medium,
                                  fit: BoxFit.scaleDown,
                                  errorBuilder: _imageErrorBuilder,
                                ),
                              ),
                              if (title != null && block) ...[
                                const Divider(height: 1),
                                ColoredBox(
                                  color: colorScheme.surfaceContainerHigh,
                                  child: ListTile(
                                    title: Hero(
                                      tag: title,
                                      createRectTween: heroTextCreateRectTween,
                                      flightShuttleBuilder:
                                          heroTextFlightShuttleBuilder,
                                      child: Text(
                                        title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    dense: true,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  style: const TextStyle(),
                ),
              );
            } else {
              spans.add(
                TextSpan(
                  text: alt,
                  style: _mergeOrOther(
                    payload.textStyle,
                    const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              );
            }
          case "blockquote": // MARK: Blockquote
          case "div"
              when node.attributes["class"]
                      ?.split(" ")
                      .contains("markdown-alert") ??
                  false:
            var alertType =
                node.attributes.containsKey("class") &&
                    (node.attributes["class"]?.split(" ").length ?? 0) >= 2 &&
                    node.attributes["class"]!.startsWith("markdown-alert")
                ? node.attributes["class"]!
                      .split(" ")[1]
                      .replaceFirst(RegExp("^markdown-alert-"), "")
                : null;
            if (![
              "note",
              "tip",
              "important",
              "warning",
              "caution",
            ].contains(alertType)) {
              alertType = null;
            }
            var alertTitle = alertType != null
                ? node.children!.removeAt(
                        node.children!.indexWhere(
                          (e) =>
                              e is md.Element &&
                              e.attributes["class"] == "markdown-alert-title",
                        ),
                      )
                      as md.Element
                : null;
            var alertIcon = alertType != null
                ? switch (alertType) {
                    "note" => Icons.info_outline,
                    "tip" => Icons.lightbulb_outline,
                    "important" || "warning" => Icons.feedback_outlined,
                    "caution" => Icons.report_outlined,
                    _ => null,
                  }
                : null;
            var alertColor = alertType != null
                ? (switch (alertType) {
                    "note" => Colors.blue[600],
                    "tip" => Colors.green[600],
                    "important" => Colors.purple[400],
                    "warning" => Colors.amber[800],
                    "caution" => Colors.red[700],
                    _ => null,
                  })?.harmonizeWith(colorScheme.primary)
                : null;

            var contentSpans = _toInlineSpans(
              payload.copy(tree: node.children),
              block: true,
            );
            if (alertType != null && alertTitle != null) {
              var titleSpans = _toInlineSpans(
                payload.copy(tree: alertTitle.children),
              );
              contentSpans.insertAll(0, [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(alertIcon!, size: 18, color: alertColor!),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text.rich(
                          TextSpan(children: titleSpans),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: alertColor,
                            height: kTextHeightNone,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _paragraphBreak,
              ]);
            }
            spans.add(
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: alertColor ?? colorScheme.outline,
                        width: 3,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 12, top: 4, bottom: 4),
                  margin: const EdgeInsets.only(left: 1.5),
                  child: Text.rich(TextSpan(children: contentSpans)),
                ),
              ),
            );
          case "table": // MARK: Table
            var head =
                node.children!.firstWhere(
                      (e) => e is md.Element && e.tag == "thead",
                    )
                    as md.Element;
            var body =
                node.children!.firstWhere(
                      (e) => e is md.Element && e.tag == "tbody",
                      orElse: () => md.Element("tbody", []),
                    )
                    as md.Element;

            spans.add(
              WidgetSpan(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    showCheckboxColumn: false,
                    border: TableBorder.all(
                      color: colorScheme.outline,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    dividerThickness: 0.4,
                    headingRowColor: WidgetStatePropertyAll(
                      colorScheme.surfaceContainerLow,
                    ),
                    columns: (head.children!.first as md.Element).children!.map((
                      e,
                    ) {
                      e as md.Element;
                      var align = switch (e.attributes["align"]) {
                        "left" => MainAxisAlignment.start,
                        "right" => MainAxisAlignment.end,
                        _ => MainAxisAlignment.center,
                      };
                      return DataColumn(
                        label: Padding(
                          padding: const EdgeInsets.only(top: 4, bottom: 4),
                          child: Text(
                            // TODO: Reimplement table to better fit rendered content. Then use [Text.rich] here.
                            TextSpan(
                              children: _toInlineSpans(
                                payload.copy(tree: e.children),
                              ),
                            ).toPlainText(),
                          ),
                        ),
                        headingRowAlignment: align,
                      );
                    }).toList(),
                    rows: body.children!.map((e) {
                      return DataRow(
                        cells: (e as md.Element).children!.map((c) {
                          c as md.Element;
                          var align = switch (c.attributes["align"]) {
                            "right" => Alignment.centerRight,
                            "center" => Alignment.center,
                            _ => Alignment.centerLeft,
                          };
                          return DataCell(
                            Align(
                              alignment: align,
                              child: Text(
                                // TODO: Reimplement table to better fit rendered content. Then use [Text.rich] here.
                                TextSpan(
                                  children: _toInlineSpans(
                                    payload.copy(tree: c.children),
                                  ),
                                ).toPlainText(),
                              ),
                            ),
                          );
                        }).toList(),
                        color: const WidgetStatePropertyAll(Colors.transparent),
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          case "ol": // MARK: Ordered/Unordered List
          case "ul":
            var ordered = node.tag == "ol";

            var checkboxes = <int, bool>{};
            var elements = <InlineSpan>[];
            for (var child in (node.children ?? []).asMap().entries) {
              if (child.value is md.Element &&
                  (child.value as md.Element).tag == "li") {
                var childElement = child.value as md.Element;
                var children = childElement.children ?? [];

                if (!ordered &&
                    childElement.attributes.containsKey("class") &&
                    childElement.attributes["class"] == "task-list-item") {
                  var checkbox =
                      childElement.children!.firstWhere(
                            (e) =>
                                e is md.Element &&
                                e.tag == "input" &&
                                e.attributes["type"] == "checkbox",
                          )
                          as md.Element;
                  var isChecked = checkbox.attributes.containsKey("checked");
                  checkboxes[child.key] = isChecked;
                  children.removeAt(0);
                }

                elements.add(
                  TextSpan(
                    children: _toInlineSpans(payload.copy(tree: children)),
                  ),
                );
              }
            }

            spans.add(
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: elements.asMap().entries.map((e) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: _paragraphHeight * 2,
                          margin: EdgeInsets.only(right: _paragraphHeight / 2),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: (e.value is! TextSpan)
                                ? const SizedBox.shrink()
                                : checkboxes.containsKey(e.key)
                                ? Transform.translate(
                                    offset: const Offset(6, 1),
                                    child: Container(
                                      height: _paragraphHeight,
                                      width: _paragraphHeight,
                                      margin: const EdgeInsets.only(right: 4),
                                      child: Transform.scale(
                                        scale: 0.8,
                                        child: Checkbox(
                                          value: checkboxes[e.key],
                                          onChanged: null,
                                        ),
                                      ),
                                    ),
                                  )
                                : ExcludeSemantics(
                                    child: Text(
                                      ordered ? "${e.key + 1}." : "•",
                                      style: TextStyle(
                                        height:
                                            payload.textStyle?.height ??
                                            kTextHeightNone,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        Expanded(child: Text.rich(e.value)),
                      ],
                    );
                  }).toList(),
                ),
                style: const TextStyle(),
              ),
            );
          case "details": // MARK: Details
            var opened =
                node.attributes.containsKey("class") &&
                node.attributes["class"]!
                    .split(" ")
                    .contains("markdown-details-open");
            var summary =
                (node.children!.removeAt(
                              node.children!.indexWhere(
                                (e) =>
                                    e is md.Element &&
                                    e.attributes["class"] ==
                                        "markdown-details-summary",
                              ),
                            )
                            as md.Element)
                        .children!
                        .first
                    as md.Text;
            spans.add(
              WidgetSpan(
                alignment: PlaceholderAlignment.top,
                child: SizedBox(
                  width: double.infinity,
                  child: _MarkdownDetails(
                    initialOpened: opened,
                    summary: summary.text,
                    contentSpans: _toInlineSpans(
                      payload.copy(tree: node.children),
                      block: true,
                    ),
                    textStyle: payload.textStyle,
                    paragraphHeight: _paragraphHeight,
                  ),
                ),
              ),
            );
          case "latex": // MARK: LaTeX Block
            var text = (node.children!.first as md.Text).text;
            var errorStyle = TextStyle(
              color: colorScheme.error,
              fontStyle: FontStyle.italic,
            );
            spans.add(
              WidgetSpan(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(text: text));
                      if (!kIsWeb) lightHaptic();
                    },
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: latex.Math.tex(
                          text,
                          mathStyle: latex.MathStyle.display,
                          onErrorFallback: (e) => Text(
                            "LaTeX Error: ${e.message}",
                            style: _mergeOrOther(payload.textStyle, errorStyle),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          case "latexInline": // MARK: LaTeX Inline
            var text = (node.children!.first as md.Text).text;
            var errorStyle = TextStyle(
              color: colorScheme.error,
              fontStyle: FontStyle.italic,
            );
            spans.addAll(
              latex.Math.tex(
                text,
                mathStyle: latex.MathStyle.text,
                onErrorFallback: (e) => Text(
                  "LaTeX Error: ${e.message}",
                  style: _mergeOrOther(payload.textStyle, errorStyle),
                ),
              ).texBreak().parts.map(
                (m) => WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: SizedBox(child: m),
                ),
              ),
            );
          case "section":
            // ignore block, it's used in footnotes
            skipParagraphBreak = true;
          default:
            if (kDebugMode) print(node.toInfoString());
            spans.addAll(_toInlineSpans(payload.copy(tree: node.children)));
        }
      }
      if (block &&
          !skipParagraphBreak &&
          nodePair.key != payload.tree.length - 1) {
        spans.add(_paragraphBreak);
      }
    }
    return spans;
  }
}

class SuperscriptSyntax extends md.InlineSyntax {
  SuperscriptSyntax() : super(r"\^.+\^");

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    var text = match[0]!.substring(1);
    text = text.substring(0, text.length - 1).trim();
    if (text.isEmpty) {
      parser.addNode(md.Text(match[0]!));
    } else {
      parser.addNode(md.Element("sup", [md.Text(text)]));
    }
    return true;
  }
}

class SubscriptSyntax extends md.InlineSyntax {
  SubscriptSyntax() : super(r"(?<!~)~[^~]+~(?!~)");

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    var text = match[0]!.substring(1);
    text = text.substring(0, text.length - 1).trim();
    if (text.isEmpty) {
      parser.addNode(md.Text(match[0]!));
    } else {
      parser.addNode(md.Element("sub", [md.Text(text)]));
    }
    return true;
  }
}

class MarkSyntax extends md.InlineSyntax {
  MarkSyntax() : super(r"<\s*mark\s*>(.*)<\/\s*mark\s*>");

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    var text = match[1]!.trim();
    if (text.isEmpty) {
      parser.addNode(md.Text(match[0]!));
    } else {
      parser.addNode(md.Element("mark", parser.document.parseInline(text)));
    }
    return true;
  }
}

class LatexBlockSyntax extends md.BlockSyntax {
  @override
  md.Node? parse(md.BlockParser parser) {
    var opening = parser.current.content;
    var m = pattern.firstMatch(opening)!;
    var after = opening.substring(m.end);
    parser.advance();

    var buf = StringBuffer();

    var closeSame = after.indexOf(_pattern);
    if (closeSame != -1) {
      buf.write(after.substring(0, closeSame));
      return _toElement(buf);
    }

    if (after.isNotEmpty) buf.write(after);
    while (!parser.isDone) {
      var line = parser.current.content;
      var ci = line.indexOf(_pattern);
      if (ci != -1) {
        buf.write(line.substring(0, ci));
        parser.advance();
        return _toElement(buf);
      }
      buf.writeln(line);
      parser.advance();
    }

    return _toElement(buf);
  }

  md.Element _toElement(StringBuffer buf) =>
      md.Element("latex", [md.Text(buf.toString())]);

  @override
  RegExp get pattern => RegExp(RegExp.escape(_pattern));
  final _pattern = r"$$";
}

class LatexInlineSyntax extends md.InlineSyntax {
  LatexInlineSyntax() : super(r"\$.+\$");

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    var text = match[0]!.substring(1);
    text = text.substring(0, text.length - 1).trim();
    if (text.isEmpty || [r"$", r"$$"].contains(text)) {
      parser.addNode(md.Text(match[0]!));
    } else {
      parser.addNode(md.Element("latexInline", [md.Text(text)]));
    }
    return true;
  }
}

class DetailsBlockSyntax extends md.BlockSyntax {
  @override
  md.Node? parse(md.BlockParser parser) {
    var opening = parser.current.content;
    var m = pattern.firstMatch(opening)!;
    var after = opening.substring(m.end);
    parser.advance();

    var buf = StringBuffer();

    var closeSame = after.indexOf(_closePattern);
    if (closeSame != -1) {
      buf.write(after.substring(0, closeSame));
      return _toElement(parser.document, buf);
    }

    if (after.isNotEmpty) buf.write(after);
    while (!parser.isDone) {
      var line = parser.current.content;
      var ci = line.indexOf(_closePattern);
      if (ci != -1) {
        buf.write(line.substring(0, ci));
        parser.advance();
        return _toElement(parser.document, buf);
      }
      buf.writeln(line);
      parser.advance();
    }

    return _toElement(parser.document, buf);
  }

  md.Element? _toElement(md.Document doc, StringBuffer buf) {
    var m = _realPattern.firstMatch("<details$buf</details>");
    if (m == null) return null;

    var className = "markdown-details";
    if (m.namedGroup("argument") != null) {
      var argument = m.namedGroup("argument")!.trim();
      if (argument.isNotEmpty && ["open"].contains(argument)) {
        className += " markdown-details-$argument";
      }
    }

    var summary = m.namedGroup("summary")!.trim();
    while (summary.contains("\n")) {
      summary = summary.replaceAll("\n", " ");
    }
    while (summary.contains(" " * 2)) {
      summary = summary.replaceAll(" " * 2, " " * 1);
    }

    var content = m.namedGroup("content")!.trimRight().split("\n\n");
    var contentFirstLine = content.removeAt(0);
    var contentNodes = <md.Node>[
      md.Element("p", [md.Text(summary)])
        ..attributes["class"] = "markdown-details-summary",
      if (contentFirstLine.trim().isNotEmpty)
        md.Element("p", [md.Text(contentFirstLine.trim())]),
      ...doc.parse(content.join("\n\n").trim()),
    ];

    return md.Element("details", contentNodes)..attributes["class"] = className;
  }

  @override
  RegExp get pattern => RegExp(r"^<\s*details");
  final _closePattern = RegExp(r"<\/details\s*>");
  final _realPattern = RegExp(
    r"<\s*details\s*(?<argument>.*?)\s*>\s*<\s*summary\s*>(?<summary>.*?)<\/summary\s*>(?<content>.*?)<\/details>",
    dotAll: true,
  );
}

const preHighlightGithubThemeLight = {
  "root": TextStyle(
    color: Color(0xff24292e),
    backgroundColor: Colors.transparent,
  ),
  "comment": TextStyle(color: Color(0xff6a737d), fontStyle: FontStyle.italic),
  "quote": TextStyle(color: Color(0xff6a737d), fontStyle: FontStyle.italic),
  "keyword": TextStyle(color: Color(0xffd73a49), fontWeight: FontWeight.bold),
  "selector-tag": TextStyle(
    color: Color(0xffd73a49),
    fontWeight: FontWeight.bold,
  ),
  "subst": TextStyle(color: Color(0xff24292e), fontWeight: FontWeight.normal),
  "number": TextStyle(color: Color(0xff005cc5)),
  "literal": TextStyle(color: Color(0xff005cc5)),
  "variable": TextStyle(color: Color(0xffe36209)),
  "template-variable": TextStyle(color: Color(0xffe36209)),
  "string": TextStyle(color: Color(0xff032f62)),
  "doctag": TextStyle(color: Color(0xff032f62)),
  "title": TextStyle(color: Color(0xff6f42c1), fontWeight: FontWeight.bold),
  "section": TextStyle(color: Color(0xff6f42c1), fontWeight: FontWeight.bold),
  "selector-id": TextStyle(
    color: Color(0xff6f42c1),
    fontWeight: FontWeight.bold,
  ),
  "type": TextStyle(color: Color(0xff005cc5), fontWeight: FontWeight.bold),
  "tag": TextStyle(color: Color(0xff22863a), fontWeight: FontWeight.normal),
  "name": TextStyle(color: Color(0xff22863a), fontWeight: FontWeight.normal),
  "attribute": TextStyle(
    color: Color(0xff22863a),
    fontWeight: FontWeight.normal,
  ),
  "regexp": TextStyle(color: Color(0xff032f62)),
  "link": TextStyle(color: Color(0xff032f62)),
  "symbol": TextStyle(color: Color(0xffe36209)),
  "bullet": TextStyle(color: Color(0xffe36209)),
  "built_in": TextStyle(color: Color(0xff005cc5)),
  "builtin-name": TextStyle(color: Color(0xff005cc5)),
  "meta": TextStyle(color: Color(0xff6a737d), fontWeight: FontWeight.bold),
  "deletion": TextStyle(backgroundColor: Color(0xffffdddd)),
  "addition": TextStyle(backgroundColor: Color(0xffddffdd)),
  "emphasis": TextStyle(fontStyle: FontStyle.italic),
  "strong": TextStyle(fontWeight: FontWeight.bold),
};

const preHighlightGithubThemeDark = {
  "root": TextStyle(
    color: Color(0xfff6f8fa),
    backgroundColor: Colors.transparent,
  ),
  "comment": TextStyle(color: Color(0xff959da5), fontStyle: FontStyle.italic),
  "quote": TextStyle(color: Color(0xff959da5), fontStyle: FontStyle.italic),
  "keyword": TextStyle(color: Color(0xffea4a5a), fontWeight: FontWeight.bold),
  "selector-tag": TextStyle(
    color: Color(0xffea4a5a),
    fontWeight: FontWeight.bold,
  ),
  "subst": TextStyle(color: Color(0xfff6f8fa), fontWeight: FontWeight.normal),
  "number": TextStyle(color: Color(0xffc8e1ff)),
  "literal": TextStyle(color: Color(0xffc8e1ff)),
  "variable": TextStyle(color: Color(0xfffb8532)),
  "template-variable": TextStyle(color: Color(0xfffb8532)),
  "string": TextStyle(color: Color(0xff79b8ff)),
  "doctag": TextStyle(color: Color(0xff79b8ff)),
  "title": TextStyle(color: Color(0xffb392f0), fontWeight: FontWeight.bold),
  "section": TextStyle(color: Color(0xffb392f0), fontWeight: FontWeight.bold),
  "selector-id": TextStyle(
    color: Color(0xffb392f0),
    fontWeight: FontWeight.bold,
  ),
  "type": TextStyle(color: Color(0xff0366d6), fontWeight: FontWeight.bold),
  "tag": TextStyle(color: Color(0xff7bcc72), fontWeight: FontWeight.normal),
  "name": TextStyle(color: Color(0xff7bcc72), fontWeight: FontWeight.normal),
  "attribute": TextStyle(
    color: Color(0xff7bcc72),
    fontWeight: FontWeight.normal,
  ),
  "regexp": TextStyle(color: Color(0xff79b8ff)),
  "link": TextStyle(color: Color(0xff79b8ff)),
  "symbol": TextStyle(color: Color(0xfffb8532)),
  "bullet": TextStyle(color: Color(0xfffb8532)),
  "built_in": TextStyle(color: Color(0xff0366d6)),
  "builtin-name": TextStyle(color: Color(0xff0366d6)),
  "meta": TextStyle(color: Color(0xff959da5), fontWeight: FontWeight.bold),
  "deletion": TextStyle(backgroundColor: Color(0xff67060c)),
  "addition": TextStyle(backgroundColor: Color(0xff033a16)),
  "emphasis": TextStyle(fontStyle: FontStyle.italic),
  "strong": TextStyle(fontWeight: FontWeight.bold),
};

class _MarkdownDetails extends StatefulWidget {
  final bool initialOpened;
  final String summary;
  final List<InlineSpan> contentSpans;
  final TextStyle? textStyle;
  final double? paragraphHeight;

  const _MarkdownDetails({
    required this.initialOpened,
    required this.summary,
    required this.contentSpans,
    this.textStyle,
    this.paragraphHeight,
  });

  @override
  State<_MarkdownDetails> createState() => _MarkdownDetailsState();
}

class _MarkdownFootnoteModal extends StatefulWidget {
  final _MarkdownPayload payload;

  const _MarkdownFootnoteModal({required this.payload});

  @override
  State<_MarkdownFootnoteModal> createState() => _MarkdownFootnoteModalState();
}

class _MarkdownFootnoteModalState extends State<_MarkdownFootnoteModal> {
  var urlMode = false;

  late final Uri? urlModeUrl;
  OgpData? urlModeData;
  bool _loadedData = false;
  Uri? urlModeFavicon;

  @override
  void initState() {
    super.initState();
    urlModeUrl = Uri.tryParse(
      widget.payload.tree.map((e) => e.textContent).join(" "),
    );
    urlMode =
        urlModeUrl != null && ["http", "https"].contains(urlModeUrl!.scheme);
    if (urlMode) {
      OgpDataExtract.execute(urlModeUrl!.toString(), userAgent: userAgent).then(
        (v) {
          _loadedData = true;
          if (mounted) setState(() {});
          urlModeData = v;
          if (mounted) setState(() {});
        },
      );
      OgpDataExtract.fetchFavicon(
        urlModeUrl!.toString(),
        userAgent: userAgent,
      ).then((v) async {
        for (var i in v) {
          if (i == null) continue;
          var req = await httpClient.head(Uri.parse(i));
          if (req.statusCode == 200 &&
              [
                "image/jpeg",
                "image/png",
              ].contains(req.headers["content-type"])) {
            urlModeFavicon = Uri.parse(i);
            if (mounted && _loadedData) setState(() {});
            break;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (urlMode) {
      var image = urlModeData?.image;
      var title = urlModeData?.title ?? urlModeUrl.toString();
      var description = urlModeData?.description;

      var duration = kThemeAnimationDuration;
      var curve = Curves.fastEaseInToSlowEaseOut;

      child = InkWell(
        onTap: () async {
          await launchUrl(urlModeUrl!, mode: LaunchMode.inAppBrowserView);
          if (context.mounted) Navigator.of(context).pop();
        },
        borderRadius: BorderRadius.circular(12),
        child: Card.filled(
          margin: EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!_loadedData || image != null)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: AnimatedSize(
                        duration: duration,
                        curve: curve,
                        alignment: Alignment.topCenter,
                        child: image != null
                            ? Image.network(
                                image,
                                loadingBuilder: (_, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return SizedBox(
                                    width: double.infinity,
                                    child: LinearProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                          : null,
                                    ),
                                  );
                                },
                              )
                            : const SizedBox(
                                width: double.infinity,
                                child: LinearProgressIndicator(),
                              ),
                      ),
                    ),
                    if (_loadedData) const Divider(height: 1),
                  ],
                ),
              AnimatedSize(
                duration: duration,
                curve: curve,
                child: ListTile(
                  leading: SizedBox(
                    height: 24,
                    width: 24,
                    child: AnimatedSwitcher(
                      duration: duration,
                      child: urlModeFavicon != null
                          ? Image.network(
                              urlModeFavicon.toString(),
                              height: 24,
                              width: 24,
                              filterQuality: FilterQuality.low,
                              loadingBuilder: (_, child, loadingProgress) =>
                                  loadingProgress != null
                                  ? CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                          : null,
                                    )
                                  : child,
                              errorBuilder: (_, _, _) =>
                                  const Icon(Icons.public),
                            )
                          : const Icon(Icons.public),
                    ),
                  ),
                  title: AnimatedSize(
                    duration: duration,
                    curve: curve,
                    child: AnimatedSwitcher(
                      duration: duration,
                      switchInCurve: curve,
                      switchOutCurve: curve.flipped,
                      child: SizedBox(
                        key: ValueKey(title),
                        width: double.infinity,
                        child: Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  subtitle: !_loadedData || (_loadedData && description == null)
                      ? null
                      : AnimatedSize(
                          duration: duration,
                          curve: curve,
                          child: SizedBox(
                            key: ValueKey(description),
                            width: double.infinity,
                            child: Text(
                              description ?? "",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      child = Text.rich(
        TextSpan(
          children: widget.payload.markdown._toInlineSpans(
            widget.payload,
            block: true,
          ),
        ),
      );
    }
    return SingleChildScrollView(
      child: SafeArea(
        top: false,
        left: false,
        right: false,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          child: child,
        ),
      ),
    );
  }
}

class _MarkdownDetailsState extends State<_MarkdownDetails>
    with TickerProviderStateMixin {
  bool _expanded = false;
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      value: widget.initialOpened ? 1.0 : 0.0,
      duration: kThemeAnimationDuration,
      vsync: this,
    );
    _expanded = widget.initialOpened;

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastEaseInToSlowEaseOut,
    );
  }

  void _toggleAnimation() {
    if (!kIsWeb) selectionHaptic();
    setState(() {
      _expanded = !_expanded;
      _expanded
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          child: GestureDetector(
            onTap: _toggleAnimation,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: widget.paragraphHeight,
                  width: widget.paragraphHeight,
                  margin: EdgeInsets.only(
                    right: widget.paragraphHeight != null
                        ? widget.paragraphHeight! / 3
                        : 6,
                  ),
                  child: ExpandIcon(
                    size: widget.paragraphHeight ?? 16,
                    onPressed: null,
                    isExpanded: _expanded,
                    padding: EdgeInsets.zero,
                  ),
                ),
                Expanded(child: Text(widget.summary)),
              ],
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: _animation,
          axisAlignment: -1,
          child: Text.rich(
            TextSpan(children: widget.contentSpans),
            style: widget.textStyle,
          ),
        ),
      ],
    );
  }
}

class _MarkdownImageScreen extends StatefulWidget {
  final String src;
  final ImageErrorWidgetBuilder imageErrorBuilder;
  final String? title;

  const _MarkdownImageScreen({
    required this.src,
    required this.imageErrorBuilder,
    required this.title,
  });

  @override
  State<_MarkdownImageScreen> createState() => _MarkdownImageScreenState();
}

class _MarkdownImageScreenState extends State<_MarkdownImageScreen>
    with TickerProviderStateMixin {
  final TransformationController _controller = TransformationController();
  late final Image _image;
  Size? _imageSize;

  double _minScale = 1.0;
  double _maxScale = 8.0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(onUpdate);

    _image = Image.network(widget.src);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _image.image
          .resolve(ImageConfiguration.empty)
          .addListener(
            ImageStreamListener((ImageInfo image, _) {
              _imageSize = Size(
                image.image.width.toDouble(),
                image.image.height.toDouble(),
              );

              _minScale = math.min(
                1,
                _toInverseScale(
                  1,
                  _imageSize!,
                  BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                    maxHeight: MediaQuery.of(context).size.height,
                  ),
                ),
              );
              _maxScale = math.max(
                1,
                _toInverseScale(
                  8,
                  _imageSize!,
                  BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                    maxHeight: MediaQuery.of(context).size.height,
                  ),
                ),
              );

              if (mounted) setState(() {});
            }),
          ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(onUpdate);
    super.dispose();
  }

  void onUpdate() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var finalTitle = widget.title ?? "Untitled Image";
    var titleWidget = Text(
      finalTitle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
    return Theme(
      data: ThemeBuilderData.current!.themeDark(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          var ratio = _ratioFromDouble(_imageSize?.aspectRatio ?? 1);
          var realScale = _imageSize != null
              ? (_toRealScale(
                          _controller.value.getMaxScaleOnAxis(),
                          _imageSize!,
                          constraints,
                        ) *
                        100)
                    .round()
              : 100;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.7),
              automaticallyImplyLeading: true,
              title: widget.title != null
                  ? Hero(
                      tag: widget.title!,
                      createRectTween: heroTextCreateRectTween,
                      flightShuttleBuilder: heroTextFlightShuttleBuilder,
                      child: titleWidget,
                    )
                  : titleWidget,
              actions: [
                IconButton(
                  onPressed: () {
                    launchUrl(Uri.parse(widget.src));
                    if (!kIsWeb) lightHaptic();
                  },
                  icon: const Icon(Icons.open_in_new),
                ),
              ],
            ),
            extendBodyBehindAppBar: true,
            body: Stack(
              children: [
                SizedBox.expand(
                  child: InteractiveViewer(
                    transformationController: _controller,
                    minScale: _minScale,
                    maxScale: _maxScale,
                    trackpadScrollCausesScale: true,
                    child: Hero(
                      tag: widget.src,
                      child: Image(
                        image: _image.image,
                        filterQuality: FilterQuality.high,
                        isAntiAlias: true,
                        errorBuilder: widget.imageErrorBuilder,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                if (_imageSize != null)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                        ),
                      ),
                      child: SafeArea(
                        top: false,
                        left: false,
                        right: false,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              if (realScale.toString().length < 3)
                                const TextSpan(
                                  text: "0",
                                  style: TextStyle(color: Colors.transparent),
                                ),
                              TextSpan(
                                text: "$realScale%",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const TextSpan(text: "  •  "),
                              TextSpan(
                                text:
                                    "${_imageSize!.width.round()}×${_imageSize!.height.round()}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    "  (${[ratio.numerator, ratio.denominator].join("/")})",
                                style: const TextStyle(
                                  fontFeatures: [FontFeature.fractions()],
                                ),
                              ),
                            ],
                          ),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  double _toRealScale(
    double scale,
    Size imageSize,
    BoxConstraints constraints,
  ) {
    var iw = imageSize.width;
    var ih = imageSize.height;
    var cw = constraints.maxWidth;
    var ch = constraints.maxHeight;

    if (iw <= 0 || ih <= 0 || cw <= 0 || ch <= 0) return scale;

    var fitScale = (iw / ih > cw / ch) ? cw / iw : ch / ih;
    return scale * fitScale;
  }

  double _toInverseScale(
    double realScale,
    Size imageSize,
    BoxConstraints constraints,
  ) {
    var iw = imageSize.width * (constraints.maxWidth / imageSize.width);
    var ih = imageSize.height * (constraints.maxHeight / imageSize.height);
    var cw = constraints.maxWidth;
    var ch = constraints.maxHeight;

    if (iw <= 0 || ih <= 0) return realScale;
    if (!cw.isFinite || !ch.isFinite) return realScale;
    if (cw <= 0 || ch <= 0) return realScale;

    // if (iw <= cw && ih <= ch) return realScale;
    var fitScale = (iw / ih > cw / ch) ? cw / iw : ch / ih;
    return (realScale / fitScale) * (imageSize.width / constraints.maxWidth);
  }

  ({int denominator, int numerator}) _ratioFromDouble(
    double v, {
    int maxDen = 1000,
    bool preferWidth = true,
  }) {
    if (!v.isFinite || v <= 0) {
      throw ArgumentError.value(v, 'v', 'must be > 0 and finite');
    }
    var inverted = preferWidth && v < 1.0;
    if (inverted) v = 1.0 / v;

    var a0 = v.floor();
    if ((v - a0).abs() < 1e-12) {
      return inverted
          ? (denominator: 1, numerator: a0)
          : (numerator: a0, denominator: 1);
    }

    var p0 = 1;
    var q0 = 0;
    var p1 = a0;
    var q1 = 1;
    var frac = v - a0;

    while (true) {
      if (frac.abs() < 1e-12) break;
      var x = 1.0 / frac;
      var a = x.floor();
      var p2 = a * p1 + p0;
      var q2 = a * q1 + q0;
      if (q2 > maxDen) {
        var k = (maxDen - q0) ~/ q1;
        if (k <= 0) {
          p2 = p1;
          q2 = q1;
        } else {
          p2 = k * p1 + p0;
          q2 = k * q1 + q0;
        }
        p1 = p2;
        q1 = q2;
        break;
      }
      p0 = p1;
      q0 = q1;
      p1 = p2;
      q1 = q2;
      frac = x - a;
    }

    int g(int a, int b) {
      a = a.abs();
      b = b.abs();
      while (b != 0) {
        var t = a % b;
        a = b;
        b = t;
      }
      return a;
    }

    var num = p1;
    var den = q1;
    if (inverted) {
      var t = num;
      num = den;
      den = t;
    }
    var gg = g(num, den);
    return (numerator: num ~/ gg, denominator: den ~/ gg);
  }
}

class TapLongPressGestureRecognizer extends GestureRecognizer {
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  final TapGestureRecognizer _tap = TapGestureRecognizer();
  final LongPressGestureRecognizer _longPress = LongPressGestureRecognizer();

  TapLongPressGestureRecognizer({this.onTap, this.onLongPress}) {
    _tap.onTap = onTap;
    _longPress.onLongPress = onLongPress;
  }

  @override
  void addPointer(PointerDownEvent event) {
    _tap.addPointer(event);
    _longPress.addPointer(event);
  }

  @override
  void acceptGesture(int pointer) {
    _tap.acceptGesture(pointer);
    _longPress.acceptGesture(pointer);
  }

  @override
  void rejectGesture(int pointer) {
    _tap.rejectGesture(pointer);
    _longPress.rejectGesture(pointer);
  }

  @override
  void dispose() {
    _tap.dispose();
    _longPress.dispose();
    super.dispose();
  }

  @override
  String get debugDescription => "TapLongPressGestureRecognizer";
}

extension on md.Node {
  String toInfoString() {
    switch (this) {
      case md.Text e:
        return 'Text("${e.text}")';
      case md.Element e:
        return 'Element(tag: ${e.tag}, attributes: ${e.attributes}, children: [${e.children?.map((e) => e.toInfoString()).join(", ")}])';
      default:
        return 'Node()';
    }
  }
}

// extension on InlineSpan {
//   String toInfoString() {
//     switch (this) {
//       case TextSpan e:
//         return 'TextSpan(text: ${e.text}, style: ${e.style}, children: [${e.children?.map((e) => e.toInfoString()).join(", ")}])';
//       case WidgetSpan e:
//         return 'WidgetSpan(widget: ${e.child}, style: ${e.style})';
//       default:
//         return 'InlineSpan()';
//     }
//   }
// }
