import 'package:flutter/material.dart';

import '../l10n/gen/app_localizations.dart';

class AlphaBadge extends StatelessWidget {
  const AlphaBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);
    final appLocalizations = AppLocalizations.of(context);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: colorScheme.errorContainer,
        shape: const StadiumBorder(),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      alignment: Alignment.center,
      child: Text(
        appLocalizations.settingsExperimentalAlpha,
        style: textTheme.labelSmall!.copyWith(
          color: colorScheme.onErrorContainer,
        ),
        textAlign: TextAlign.center,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}

class Alpha extends StatelessWidget {
  final Widget child;
  final bool showBadge;
  const Alpha({super.key, required this.child, this.showBadge = true});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Flexible(child: child),
      if (showBadge) ...[
        const SizedBox(width: 2),
        Transform.translate(
          offset: const Offset(0, -4),
          child: const AlphaBadge(),
        ),
      ],
    ],
  );
}

class BetaBadge extends StatelessWidget {
  const BetaBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);
    final appLocalizations = AppLocalizations.of(context);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: colorScheme.primaryContainer,
        shape: const StadiumBorder(),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      alignment: Alignment.center,
      child: Text(
        appLocalizations.settingsExperimentalBeta,
        style: textTheme.labelSmall!.copyWith(
          color: colorScheme.onPrimaryContainer,
        ),
        textAlign: TextAlign.center,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}

class Beta extends StatelessWidget {
  final Widget child;
  final bool showBadge;
  const Beta({super.key, required this.child, this.showBadge = true});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Flexible(child: child),
      if (showBadge) ...[
        const SizedBox(width: 2),
        Transform.translate(
          offset: const Offset(0, -4),
          child: const BetaBadge(),
        ),
      ],
    ],
  );
}
