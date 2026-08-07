import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum BreakpointNavigationType {
  navigationBar,
  navigationRail,
  navigationRailExtended,
  navigationRailModal,
}

enum Breakpoint {
  compact(
    null,
    599,
    panes: [1],
    panesRecommended: 1,
    navigation: [.navigationBar, .navigationRailModal],
    fullScreenDialogRecommended: true,
    spacing: 16,
  ),
  medium(
    600,
    839,
    panes: [1, 2],
    panesRecommended: 1,
    navigation: [.navigationBar, .navigationRail],
    spacing: 24,
  ),
  expanded(
    840,
    1199,
    panes: [1, 2],
    panesRecommended: 2,
    panesFixedWidth: 360,
    navigation: [.navigationRail, .navigationRailExtended],
    spacing: 24,
  ),
  large(
    1200,
    1599,
    panes: [1, 2],
    panesRecommended: 2,
    panesFixedWidth: 412,
    navigation: [.navigationRail, .navigationRailExtended],
    spacing: 24,
  ),
  extraLarge(
    1600,
    null,
    panes: [1, 2, 3],
    panesRecommended: 2,
    panesFixedWidth: 412,
    panesThirdFixedWidth: 400,
    navigation: [.navigationRail, .navigationRailExtended],
    spacing: 24,
  );

  final int? from;
  final int? to;

  /// List of possible pane numbers according to specification.
  ///
  /// [panesRecommended] is always included in this list. It is the recommended
  /// number of panes for this breakpoint. If not using the recommended number
  /// of panes, good reasoning should be documented.
  ///
  /// The first two panes can use either of the following layout types:
  /// - Split-pane layout:
  ///   - The two panes are displayed side by side, with the same width. If the
  /// navigation rail is used, it is counted into the 50 percent split of the
  /// pane next to it, typically the first one.
  /// - Fixed-and-flexible layout:
  ///   - One pane, typically the first one, has the fixed width of
  /// [panesFixedWidth]. The other pane takes up the remaining space.
  ///   - This layout option is only supported if [panesFixedWidth] is not null.
  ///
  /// All panes are separated by [spacing] and have that much space to the
  /// screen edge as well.
  ///
  /// The third pane of the [extraLarge] breakpoint is largely independent of
  /// the rules for the first two panes. It must always have the width of
  /// [panesThirdFixedWidth]. It is separated from the other panes by [spacing].
  /// Stylistically, according to the specification, it should be a *standard
  /// side sheet*.
  final List<int> panes;

  /// The number of panes that are recommended for this breakpoint.
  final int panesRecommended;

  /// The fixed width for the fixed pane in a fixed-and-flexible layout.
  ///
  /// See the documentation for [panes] for more details on usage of this
  /// property.
  ///
  /// If this is null, a fixed-and-flexible layout is not supported for this
  /// breakpoint.
  final double? panesFixedWidth;

  /// The fixed width for the third pane in the [extraLarge] breakpoint.
  ///
  /// This is only used for the third pane in the [extraLarge] breakpoint. If a
  /// third pane is used, the width of ot must always be set to this value.
  ///
  /// The third pane is separated from the other panes by [spacing].
  /// Stylistically, according to the specification, it should be a *standard
  /// side sheet*.
  final double? panesThirdFixedWidth;

  /// The navigation types that are recommended for this breakpoint.
  final List<BreakpointNavigationType> navigation;

  /// Whether a full screen dialog is recommended for this breakpoint.
  ///
  /// If this is false, using a normal dialog is recommended instead. Normal
  /// dialogs can still be used for this breakpoint if this is true.
  final bool fullScreenDialogRecommended;

  /// The spacing between panes, and between panes and the screen edge.
  ///
  /// This is the spacing that is recommended for this breakpoint.
  ///
  /// Please note that the Material specification also includes a complicated
  /// set of guidelines for spacing using rulers. Usually these can be sidelined
  /// in favor of a single spacing value that is used everywhere. Read more
  /// here: https://m3.material.io/foundations/layout/grids-spacing/grids
  final double spacing;

  const Breakpoint(
    this.from,
    this.to, {
    required this.panes,
    required this.panesRecommended,
    this.panesFixedWidth,
    this.panesThirdFixedWidth,
    required this.navigation,
    this.fullScreenDialogRecommended = false,
    required this.spacing,
  });

  /// Returns the [Breakpoint] for the given [BuildContext].
  static Breakpoint of(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width.ceil();
    return Breakpoint.values.firstWhere(
      (breakpoint) =>
          width >= (breakpoint.from ?? double.negativeInfinity) &&
          width <= (breakpoint.to ?? double.infinity),
    );
  }

  bool operator >(Breakpoint b) =>
      (to ?? double.infinity) > (b.from ?? double.negativeInfinity);
  bool operator <(Breakpoint b) =>
      (from ?? double.negativeInfinity) < (b.to ?? double.infinity);
  bool operator >=(Breakpoint b) => this > b || this == b;
  bool operator <=(Breakpoint b) => this < b || this == b;

  @override
  String toString() =>
      "Breakpoint.$name(from: $from, to: $to, panes: $panes, panesRecommended: $panesRecommended, navigation: $navigation, fullScreenDialogRecommended: $fullScreenDialogRecommended, spacing: $spacing)";
  String toPrettyString() =>
      "Breakpoint.$name(\n\tfrom: $from,\n\tto: $to,\n\tpanes: $panes,\n\tpanesRecommended: $panesRecommended,\n\tnavigation: [${navigation.map((n) => n.name).join(", ")}],\n\tfullScreenDialogRecommended: $fullScreenDialogRecommended,\n\tspacing: $spacing\n)";
}

class LayoutFeature {
  LayoutFeature();

  static bool desktop({bool allowWeb = false}) {
    if (!kIsWeb) {
      return io.Platform.isWindows ||
          io.Platform.isLinux ||
          io.Platform.isMacOS;
    }
    return allowWeb && kIsWeb;
  }
}
