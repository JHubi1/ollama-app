import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../l10n/gen/app_localizations.dart';
import 'preferences.dart';
import 'responsive.dart';

typedef ThemeBuilderBuilder =
    Widget Function(
      ThemeMode themeMode,
      ThemeData themeLight,
      ThemeData themeDark,
    );

class ThemeBuilderData {
  static ThemeBuilderData? _current;
  static ThemeBuilderData? get current => _current;

  final ColorScheme? dynamicLight;
  final ColorScheme? dynamicDark;

  ThemeBuilderData({required this.dynamicLight, required this.dynamicDark}) {
    _current = this;
  }

  ThemeData themeModifier(BuildContext context, ThemeData theme) {
    final floatingSnackbar = Breakpoint.of(context) <= Breakpoint.medium;
    return theme.copyWith(
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.linux: FadeForwardsPageTransitionsBuilder(),
        },
      ),
      sliderTheme: theme.sliderTheme.copyWith(year2023: false),
      progressIndicatorTheme: theme.progressIndicatorTheme.copyWith(
        year2023: false,
      ),
      dividerTheme: theme.dividerTheme.copyWith(
        color: theme.colorScheme.outline,
      ),
      snackBarTheme: theme.snackBarTheme.copyWith(
        behavior: SnackBarBehavior.floating,
        width: floatingSnackbar ? null : 288,
      ),
      listTileTheme: theme.listTileTheme.copyWith(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  ThemeData themeLight() {
    if (Preferences.instance.themeSystem && dynamicLight != null) {
      return ThemeData.from(colorScheme: dynamicLight!);
    } else {
      final colorScheme = ColorScheme.fromSeed(
        seedColor: Colors.black,
        dynamicSchemeVariant: DynamicSchemeVariant.content,
      );
      return ThemeData.from(
        colorScheme: colorScheme.copyWith(
          surface: Colors.white,
          onPrimaryContainer: colorScheme.onPrimary,
          onSecondaryContainer: colorScheme.onSurface,
          onTertiaryContainer: colorScheme.onTertiary,
        ),
      );
    }
  }

  ThemeData themeDark() {
    if (Preferences.instance.themeSystem && dynamicDark != null) {
      return ThemeData.from(colorScheme: dynamicDark!);
    } else {
      final colorScheme = ColorScheme.fromSeed(
        seedColor: Colors.white,
        dynamicSchemeVariant: DynamicSchemeVariant.content,
        brightness: Brightness.dark,
      );
      return ThemeData.from(
        colorScheme: colorScheme.copyWith(
          surface: Colors.black,
          onPrimaryContainer: colorScheme.onPrimary,
          onSecondaryContainer: colorScheme.onSurface,
          onTertiaryContainer: colorScheme.onTertiary,
        ),
      ).copyWith(dividerColor: Colors.white30);
    }
  }
}

class ThemeBuilder extends StatefulWidget {
  final ThemeBuilderData data;
  final ThemeBuilderBuilder builder;

  const ThemeBuilder({super.key, required this.data, required this.builder});

  @override
  State<ThemeBuilder> createState() => _ThemeBuilderState();
}

class _ThemeBuilderState extends State<ThemeBuilder> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Preferences.instance.addListener(onChange),
    );
  }

  @override
  void dispose() {
    Preferences.instance.removeListener(onChange);
    super.dispose();
  }

  void onChange() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder.call(
      Preferences.instance.themeMode,
      widget.data.themeModifier(context, widget.data.themeLight()),
      widget.data.themeModifier(context, widget.data.themeDark()),
    );
  }
}

class ThemeModeSwitch extends StatefulWidget {
  const ThemeModeSwitch({super.key});

  @override
  State<ThemeModeSwitch> createState() => _ThemeModeSwitchState();
}

class _ThemeModeSwitchState extends State<ThemeModeSwitch> {
  @override
  void initState() {
    super.initState();
    Preferences.instance.addListener(onChange);
  }

  @override
  void dispose() {
    Preferences.instance.removeListener(onChange);
    super.dispose();
  }

  void onChange() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      segments: [
        ButtonSegment(
          value: "dark",
          icon: const Icon(Icons.dark_mode),
          label: Text(AppLocalizations.of(context).settingsBrightnessDark),
        ),
        ButtonSegment(
          value: "system",
          icon: const Icon(Icons.brightness_auto),
          label: Text(AppLocalizations.of(context).settingsBrightnessSystem),
        ),
        ButtonSegment(
          value: "light",
          icon: const Icon(Icons.light_mode),
          label: Text(AppLocalizations.of(context).settingsBrightnessLight),
        ),
      ],
      selected: switch (Preferences.instance.themeMode) {
        ThemeMode.light => {"light"},
        ThemeMode.dark => {"dark"},
        _ => {"system"},
      },
      onSelectionChanged: (selection) => Preferences.instance.themeMode =
          ThemeMode.values.byName(selection.first),
    );
  }
}

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  @override
  void initState() {
    super.initState();
    Preferences.instance.addListener(onChange);
  }

  @override
  void dispose() {
    Preferences.instance.removeListener(onChange);
    super.dispose();
  }

  void onChange() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      segments: [
        ButtonSegment(
          value: "system",
          icon: const Icon(Icons.app_shortcut),
          label: Text(AppLocalizations.of(context).settingsThemeDevice),
        ),
        ButtonSegment(
          value: "ollama",
          icon: const ImageIcon(AssetImage("assets/logo512.png")),
          label: Text(AppLocalizations.of(context).settingsThemeOllama),
        ),
      ],
      selected: Preferences.instance.themeSystem ? {"system"} : {"ollama"},
      onSelectionChanged: (selection) =>
          Preferences.instance.themeSystem = selection.first == "system",
    );
  }
}
