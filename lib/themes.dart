import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// * A class abstraction for customize the default theme
class Style {
  static TextTheme texts = TextTheme();
  static ColorTheme colors = ColorTheme();
  static Fonts fonts = Fonts();
  static RadiusTheme radius = RadiusTheme();
  static ButtonStyle buttons = const ButtonStyle();
  static List<dynamic> _theme = [];
  static PaddingTheme paddings = PaddingTheme();
  static ShadowTheme shadows = ShadowTheme();
  static Future<void> init([int index = 0]) async {
    _theme = jsonDecode(await rootBundle.loadString("assets/theme.json"));
    colors.init(_theme[index]['colors']);
    texts.init(_theme[index]['texts']);
    radius.init(_theme[index]['border']['radius']);
    paddings.init(_theme[index]['padding']);
    shadows.init(_theme[index]['shadows']);
  }

  /// * Get the index of the current device
  /// * 0: Mobile < 576
  /// * 1: Tablet >= 576
  /// * 2: Desktop >= 768
  /// * 3: TV >= 992
  static int index(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    if (size < 576) {
      // Mobile
      return 0;
    }
    if (size < 768) {
      // Tablet
      return 1;
    }
    if (size < 992) {
      // Desktop
      return 2;
    }
    return 3;
  }
}

/// * A class abstraction for a color theme
class Fonts {
  String cursive = "cursive";
  String light = "light";
  String bold = "bold";
  String ultra = "ultra";
}

/// * A class abstraction for a color theme
class TextTheme {
  List<double> _tiny = [];
  List<double> _small = [];
  List<double> _medium = [];
  List<double> _large = [];
  List<double> _huge = [];
  List<double> _title = [];
  List<double> _biggest = [];

  void init(Map<String, dynamic> texts) {
    final jsonData = texts['size'];

    _tiny = (jsonData['tiny'] as List<dynamic>)
        .map((e) => double.parse(e.toString()))
        .toList();
    _small = (jsonData['small'] as List<dynamic>)
        .map((e) => double.parse(e.toString()))
        .toList();
    _medium = (jsonData['medium'] as List<dynamic>)
        .map((e) => double.parse(e.toString()))
        .toList();
    _large = (jsonData['large'] as List<dynamic>)
        .map((e) => double.parse(e.toString()))
        .toList();
    _huge = (jsonData['huge'] as List<dynamic>)
        .map((e) => double.parse(e.toString()))
        .toList();
    _title = (jsonData['title'] as List<dynamic>)
        .map((e) => double.parse(e.toString()))
        .toList();
    _biggest = (jsonData['biggest'] as List<dynamic>)
        .map((e) => double.parse(e.toString()))
        .toList();
  }

  double tiny(BuildContext context) {
    return _tiny[Style.index(context)];
  }

  double small(BuildContext context) {
    return _small[Style.index(context)];
  }

  double medium(BuildContext context) {
    return _medium[Style.index(context)];
  }

  double large(BuildContext context) {
    return _large[Style.index(context)];
  }

  double huge(BuildContext context) {
    return _huge[Style.index(context)];
  }

  double title(BuildContext context) {
    return _title[Style.index(context)];
  }

  double biggest(BuildContext context) {
    return _biggest[Style.index(context)];
  }
}

/// * A class abstraction for a color theme
class ColorTheme {
  Color primary = Colors.white;
  Color secondary = Colors.black;
  Color background = Colors.white;
  Color foreground = Colors.black;
  void init(Map<String, dynamic> colors) {
    primary = (colors['primary'] as String).toColor();
    secondary = (colors['secondary'] as String).toColor();
    background = (colors['background'] as String).toColor();
    foreground = (colors['foreground'] as String).toColor();
  }
}

class RadiusTheme {
  RadiusTheme();

  List<double> _small = [];
  List<double> _medium = [];
  List<double> _large = [];
  void init(Map<String, dynamic> radius) async {
    _small = (radius['small'] as List)
        .map((e) => double.parse(e.toString()))
        .toList();
    _medium = (radius['medium'] as List)
        .map((e) => double.parse(e.toString()))
        .toList();
    _large = (radius['large'] as List)
        .map((e) => double.parse(e.toString()))
        .toList();
  }

  BorderRadius small(BuildContext context) =>
      BorderRadius.circular(_small[Style.index(context)]);
  BorderRadius medium(BuildContext context) =>
      BorderRadius.circular(_medium[Style.index(context)]);
  BorderRadius large(BuildContext context) =>
      BorderRadius.circular(_large[Style.index(context)]);
}

class PaddingTheme {
  static List<double> _small = [];
  static List<double> _medium = [];
  static List<double> _large = [];
  void init(Map<String, dynamic> padding) {
    _small = (padding['small'] as List)
        .map((e) => double.parse(e.toString()))
        .toList();
    _medium = (padding['medium'] as List)
        .map((e) => double.parse(e.toString()))
        .toList();
    _large = (padding['large'] as List)
        .map((e) => double.parse(e.toString()))
        .toList();
  }

  EdgeInsets small(BuildContext context) =>
      EdgeInsets.all(_small[Style.index(context)]);
  EdgeInsets medium(BuildContext context) =>
      EdgeInsets.all(_medium[Style.index(context)]);
  EdgeInsets large(BuildContext context) =>
      EdgeInsets.all(_large[Style.index(context)]);
}

class ShadowTheme {
  static List<BoxShadow> _small = [];
  static List<BoxShadow> _medium = [];
  static List<BoxShadow> _large = [];
  void init(Map<String, dynamic> shadow) {
    _small = (shadow['small'] as List).map((e) => fromJson(e)).toList();
    _medium = (shadow['medium'] as List).map((e) => fromJson(e)).toList();
    _large = (shadow['large'] as List).map((e) => fromJson(e)).toList();
  }

  List<BoxShadow> small(BuildContext context) => [_small[Style.index(context)]];
  List<BoxShadow> medium(BuildContext context) =>
      [_medium[Style.index(context)]];
  List<BoxShadow> large(BuildContext context) => [_large[Style.index(context)]];

  BoxShadow fromJson(Map<String, dynamic> shadow) {
    return BoxShadow(
      color: (shadow['color'] as String).toColor(),
      offset: Offset(shadow['offset'][0], shadow['offset'][1]),
      blurRadius: shadow['radius'],
      spreadRadius: shadow['spread'],
    );
  }
}

extension ButtonStyleExtension on ButtonStyle {
  ButtonStyle disabled() {
    return _join(
      ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Style.colors.secondary),
        foregroundColor: WidgetStatePropertyAll(Style.colors.background),
      ),
    );
  }

  ButtonStyle primary() {
    return _join(ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Style.colors.primary),
      foregroundColor: WidgetStatePropertyAll(Style.colors.secondary),
    ));
  }

  ButtonStyle secondary() {
    return _join(ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Style.colors.secondary),
      foregroundColor: WidgetStatePropertyAll(Style.colors.primary),
    ));
  }

  ButtonStyle outline(BuildContext context) {
    return _join(ButtonStyle(
      textStyle: WidgetStatePropertyAll(TextStyle(
        fontFamily: Style.fonts.bold,
        fontSize: Style.texts.medium(context),
        color: Style.colors.primary,
      )),
      backgroundColor: WidgetStatePropertyAll(Style.colors.background),
      foregroundColor: WidgetStatePropertyAll(Style.colors.primary),
      side: WidgetStatePropertyAll(BorderSide(
        color: Style.colors.primary,
        width: 2,
      )),
    ));
  }

  ButtonStyle small(BuildContext context) {
    return _join(ButtonStyle(
      padding: const WidgetStatePropertyAll(EdgeInsets.all(5)),
      textStyle: WidgetStatePropertyAll(TextStyle(
        fontSize: Style.texts.small(context),
        fontFamily: Style.fonts.bold,
      )),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: Style.radius.small(context),
        ),
      ),
    ));
  }

  ButtonStyle medium(BuildContext context) {
    return _join(ButtonStyle(
        textStyle: WidgetStatePropertyAll(TextStyle(
          fontSize: Style.texts.medium(context),
          fontFamily: Style.fonts.bold,
        )),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: Style.radius.medium(context)))));
  }

  ButtonStyle large(BuildContext context) {
    return _join(ButtonStyle(
        textStyle: WidgetStatePropertyAll(TextStyle(
          fontSize: Style.texts.title(context),
          fontFamily: Style.fonts.bold,
        )),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: Style.radius.large(context)))));
  }

  ButtonStyle _join(ButtonStyle buttonStyle) {
    return ButtonStyle(
      textStyle: buttonStyle.textStyle ?? textStyle,
      backgroundColor: buttonStyle.backgroundColor ?? backgroundColor,
      foregroundColor: buttonStyle.foregroundColor ?? foregroundColor,
      overlayColor: buttonStyle.overlayColor ?? overlayColor,
      shadowColor: buttonStyle.shadowColor ?? shadowColor,
      surfaceTintColor: buttonStyle.surfaceTintColor ?? surfaceTintColor,
      elevation: buttonStyle.elevation ?? elevation,
      padding: buttonStyle.padding ?? padding,
      minimumSize: buttonStyle.minimumSize ?? minimumSize,
      fixedSize: buttonStyle.fixedSize ?? fixedSize,
      maximumSize: buttonStyle.maximumSize ?? maximumSize,
      iconColor: buttonStyle.iconColor ?? iconColor,
      iconSize: buttonStyle.iconSize ?? iconSize,
      side: buttonStyle.side ?? side,
      shape: buttonStyle.shape ?? shape,
      mouseCursor: buttonStyle.mouseCursor ?? mouseCursor,
      visualDensity: buttonStyle.visualDensity ?? visualDensity,
      tapTargetSize: buttonStyle.tapTargetSize ?? tapTargetSize,
      animationDuration: buttonStyle.animationDuration ?? animationDuration,
      enableFeedback: buttonStyle.enableFeedback ?? enableFeedback,
      alignment: buttonStyle.alignment ?? alignment,
      splashFactory: buttonStyle.splashFactory ?? splashFactory,
      backgroundBuilder: buttonStyle.backgroundBuilder ?? backgroundBuilder,
      foregroundBuilder: buttonStyle.foregroundBuilder ?? foregroundBuilder,
    );
  }
}

extension ColorExtension on String {
  /// * Converts a HEX color string to a Color object.
  Color toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    throw Exception("Invalid HEX color: $hexColor");
  }
}
