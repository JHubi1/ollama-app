import 'package:flutter/material.dart';

// idk why this fixes the cut off on the bottom, but it does, so anyways
Tween<Rect?> heroTextCreateRectTween(Rect? begin, Rect? end) =>
    RectTween(begin: begin, end: end);

Widget heroTextFlightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  var fromText = (fromHeroContext.widget as Hero).child as Text;
  var toText = (toHeroContext.widget as Hero).child as Text;

  var begin = fromText.style ?? DefaultTextStyle.of(fromHeroContext).style;
  var end = toText.style ?? DefaultTextStyle.of(toHeroContext).style;

  if (flightDirection == HeroFlightDirection.pop) {
    (fromText, toText) = (toText, fromText);
    (begin, end) = (end, begin);
  }

  var styleTween = TextStyleTween(begin: begin, end: end);
  var textString = fromText.data ?? toText.data ?? "";

  return AnimatedBuilder(
    animation: animation,
    builder: (context, child) {
      var currentStyle = styleTween.lerp(animation.value);
      return Material(
        type: MaterialType.transparency,
        child: Center(
          child: Text(
            textString,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: currentStyle,
          ),
        ),
      );
    },
  );
}
