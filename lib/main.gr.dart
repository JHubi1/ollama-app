// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:ollama_app/screens/chat.dart' as _i1;
import 'package:ollama_app/screens/main.dart' as _i2;
import 'package:ollama_app/screens/settings.dart' as _i3;

/// generated route for
/// [_i1.ScreenChat]
class RouteChat extends _i4.PageRouteInfo<RouteChatArgs> {
  RouteChat({_i5.Key? key, String? chatId, List<_i4.PageRouteInfo>? children})
    : super(
        RouteChat.name,
        args: RouteChatArgs(key: key, chatId: chatId),
        rawPathParams: {'id': chatId},
        initialChildren: children,
      );

  static const String name = 'RouteChat';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<RouteChatArgs>(
        orElse: () => RouteChatArgs(chatId: pathParams.optString('id')),
      );
      return _i1.ScreenChat(key: args.key, chatId: args.chatId);
    },
  );
}

class RouteChatArgs {
  const RouteChatArgs({this.key, this.chatId});

  final _i5.Key? key;

  final String? chatId;

  @override
  String toString() {
    return 'RouteChatArgs{key: $key, chatId: $chatId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RouteChatArgs) return false;
    return key == other.key && chatId == other.chatId;
  }

  @override
  int get hashCode => key.hashCode ^ chatId.hashCode;
}

/// generated route for
/// [_i2.ScreenMain]
class RouteMain extends _i4.PageRouteInfo<void> {
  const RouteMain({List<_i4.PageRouteInfo>? children})
    : super(RouteMain.name, initialChildren: children);

  static const String name = 'RouteMain';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.ScreenMain();
    },
  );
}

/// generated route for
/// [_i1.ScreenNewChat]
class RouteNewChat extends _i4.PageRouteInfo<void> {
  const RouteNewChat({List<_i4.PageRouteInfo>? children})
    : super(RouteNewChat.name, initialChildren: children);

  static const String name = 'RouteNewChat';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.ScreenNewChat();
    },
  );
}

/// generated route for
/// [_i3.ScreenSettings]
class RouteSettings extends _i4.PageRouteInfo<void> {
  const RouteSettings({List<_i4.PageRouteInfo>? children})
    : super(RouteSettings.name, initialChildren: children);

  static const String name = 'RouteSettings';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.ScreenSettings();
    },
  );
}

/// generated route for
/// [_i3.ScreenSettingsAbout]
class RouteSettingsAbout extends _i4.PageRouteInfo<void> {
  const RouteSettingsAbout({List<_i4.PageRouteInfo>? children})
    : super(RouteSettingsAbout.name, initialChildren: children);

  static const String name = 'RouteSettingsAbout';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.ScreenSettingsAbout();
    },
  );
}

/// generated route for
/// [_i3.ScreenSettingsBehavior]
class RouteSettingsBehavior extends _i4.PageRouteInfo<void> {
  const RouteSettingsBehavior({List<_i4.PageRouteInfo>? children})
    : super(RouteSettingsBehavior.name, initialChildren: children);

  static const String name = 'RouteSettingsBehavior';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.ScreenSettingsBehavior();
    },
  );
}

/// generated route for
/// [_i3.ScreenSettingsExport]
class RouteSettingsExport extends _i4.PageRouteInfo<void> {
  const RouteSettingsExport({List<_i4.PageRouteInfo>? children})
    : super(RouteSettingsExport.name, initialChildren: children);

  static const String name = 'RouteSettingsExport';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.ScreenSettingsExport();
    },
  );
}

/// generated route for
/// [_i3.ScreenSettingsInterface]
class RouteSettingsInterface extends _i4.PageRouteInfo<void> {
  const RouteSettingsInterface({List<_i4.PageRouteInfo>? children})
    : super(RouteSettingsInterface.name, initialChildren: children);

  static const String name = 'RouteSettingsInterface';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.ScreenSettingsInterface();
    },
  );
}

/// generated route for
/// [_i3.ScreenSettingsOverview]
class RouteSettingsOverview extends _i4.PageRouteInfo<void> {
  const RouteSettingsOverview({List<_i4.PageRouteInfo>? children})
    : super(RouteSettingsOverview.name, initialChildren: children);

  static const String name = 'RouteSettingsOverview';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.ScreenSettingsOverview();
    },
  );
}

/// generated route for
/// [_i3.ScreenSettingsShell]
class RouteSettingsShell extends _i4.PageRouteInfo<void> {
  const RouteSettingsShell({List<_i4.PageRouteInfo>? children})
    : super(RouteSettingsShell.name, initialChildren: children);

  static const String name = 'RouteSettingsShell';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.ScreenSettingsShell();
    },
  );
}

/// generated route for
/// [_i3.ScreenSettingsVoice]
class RouteSettingsVoice extends _i4.PageRouteInfo<void> {
  const RouteSettingsVoice({List<_i4.PageRouteInfo>? children})
    : super(RouteSettingsVoice.name, initialChildren: children);

  static const String name = 'RouteSettingsVoice';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.ScreenSettingsVoice();
    },
  );
}
