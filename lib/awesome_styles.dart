import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// * A class abstraction for customize the default theme
class Style {
  static _TextTheme texts = _TextTheme();
  static _ColorTheme colors = _ColorTheme();
  static _Fonts fonts = _Fonts();
  static _RadiusTheme radius = _RadiusTheme();
  static ButtonStyle buttons = const ButtonStyle();
  static Map<String, dynamic> _theme = {};
  static _PaddingTheme paddings = _PaddingTheme();
  static _ShadowTheme shadows = _ShadowTheme();

  /// * Initializes the theme with the given index.
  ///
  /// * The default index is 0.
  ///
  /// * The theme is loaded from the assets/theme.json file.
  ///
  /// * The theme is applied to the global [MaterialApp] widget.
  ///
  /// * The theme is stored in the [theme] attribute of the [Style] class.
  static Future<void> init(String path, [int index = 0]) async {
    _theme = jsonDecode(await rootBundle.loadString("assets/theme.json"));
    colors.init(_theme['themes'][index]['colors']);
    texts.init(_theme['themes'][index]['texts']);
    radius.init(_theme['themes'][index]['border']['radius']);
    paddings.init(_theme['themes'][index]['padding']);
    shadows.init(_theme['themes'][index]['shadows']);
  }

  /// * Get the index of the current device
  /// * 0: Mobile < 576
  /// * 1: Tablet >= 576
  /// * 2: Desktop >= 768
  /// * 3: TV >= 992
  static int index(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    final breakpoints = (_theme['breakpoints'] as List)
        .map<double>((e) => double.parse(e.toString()))
        .toList();
    for (int i = 0; i < breakpoints.length; i++) {
      if (size < breakpoints[i]) {
        return i;
      }
    }

    return breakpoints.length;
  }

  /// * Parse a list of strings to a list of type T
  /// * [e] is the list of strings
  /// * [parse] is a function that takes a string and return a type T
  static List<T> parse<T>(List e, T Function(String) parse) =>
      e.map<T>((e) => parse(e.toString())).toList();

  /// * Get the value of [values] at the index of the current device
  /// * The index is determined by calling [index] with the given [context]
  static T getValue<T>(List<T> values, BuildContext context) =>
      values[index(context)];
}

/// * A class abstraction for a color theme
class _Fonts {
  String cursive = "cursive";
  String light = "light";
  String bold = "bold";
  String ultra = "ultra";
}

/// * A class abstraction for a color theme
class _TextTheme {
  List<double> _tiny = [];
  List<double> _small = [];
  List<double> _medium = [];
  List<double> _large = [];
  List<double> _huge = [];
  List<double> _title = [];
  List<double> _biggest = [];

  void init(Map<String, dynamic> texts) {
    final jsonData = texts['size'];

    _tiny = Style.parse(jsonData['tiny'] as List<dynamic>, double.parse);
    _small = Style.parse(jsonData['small'] as List<dynamic>, double.parse);
    _medium = Style.parse(jsonData['medium'] as List<dynamic>, double.parse);
    _large = Style.parse(jsonData['large'] as List<dynamic>, double.parse);
    _huge = Style.parse(jsonData['huge'] as List<dynamic>, double.parse);
    _title = Style.parse(jsonData['title'] as List<dynamic>, double.parse);
    _biggest = Style.parse(jsonData['biggest'] as List<dynamic>, double.parse);
  }

  double tiny(BuildContext context) => Style.getValue(_tiny, context);
  double small(BuildContext context) => Style.getValue(_small, context);
  double medium(BuildContext context) => Style.getValue(_medium, context);
  double large(BuildContext context) => Style.getValue(_large, context);
  double huge(BuildContext context) => Style.getValue(_huge, context);
  double title(BuildContext context) => Style.getValue(_title, context);
  double biggest(BuildContext context) => Style.getValue(_biggest, context);
}

/// * A class abstraction for a color theme
class _ColorTheme {
  Color primary = Colors.white;
  Color secondary = Colors.black;
  Color background = Colors.white;
  Color foreground = Colors.black;
  Color info = Colors.blue;
  Color success = Colors.green;
  Color warning = Colors.orange;
  Color danger = Colors.red;
  void init(Map<String, dynamic> colors) {
    primary = (colors['primary'] as String).toColor();
    secondary = (colors['secondary'] as String).toColor();
    background = (colors['background'] as String).toColor();
    foreground = (colors['foreground'] as String).toColor();
    info = (colors['info'] as String).toColor();
    success = (colors['success'] as String).toColor();
    warning = (colors['warning'] as String).toColor();
    danger = (colors['danger'] as String).toColor();
  }
}

class _RadiusTheme {
  _RadiusTheme();

  List<double> _small = [];
  List<double> _medium = [];
  List<double> _large = [];
  void init(Map<String, dynamic> radius) async {
    _small = Style.parse(radius['small'] as List, double.parse);
    _medium = Style.parse(radius['medium'] as List, double.parse);
    _large = Style.parse(radius['large'] as List, double.parse);
  }

  BorderRadius small(BuildContext context) =>
      BorderRadius.circular(_small[Style.index(context)]);
  BorderRadius medium(BuildContext context) =>
      BorderRadius.circular(_medium[Style.index(context)]);
  BorderRadius large(BuildContext context) =>
      BorderRadius.circular(_large[Style.index(context)]);
}

class _PaddingTheme {
  static List<double> _small = [];
  static List<double> _medium = [];
  static List<double> _large = [];

  /// Inits the theme with given [padding].
  ///
  /// The [padding] must be a map with the following structure:
  ///
  ///
  void init(Map<String, dynamic> padding) {
    _small = Style.parse(padding['small'] as List, double.parse);
    _medium = Style.parse(padding['medium'] as List, double.parse);
    _large = Style.parse(padding['large'] as List, double.parse);
  }

  /// A small padding, used for the default padding of a widget.
  ///
  /// The actual value of the padding is determined by the [Style.index] of the given
  /// [BuildContext].
  EdgeInsets small(BuildContext context) =>
      EdgeInsets.all(_small[Style.index(context)]);

  /// A medium padding, used for the default padding of a widget.
  ///
  /// The actual value of the padding is determined by the [Style.index] of the given
  /// [BuildContext].
  EdgeInsets medium(BuildContext context) =>
      EdgeInsets.all(_medium[Style.index(context)]);

  /// A large padding, used for the default padding of a widget.
  ///
  /// The actual value of the padding is determined by the [Style.index] of the given
  /// [BuildContext].
  EdgeInsets large(BuildContext context) =>
      EdgeInsets.all(_large[Style.index(context)]);
}

class _ShadowTheme {
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
      spreadRadius: double.parse(shadow['spread'].toString()),
    );
  }
}

extension EdgeInsetsExtension on EdgeInsets {
  EdgeInsets symmetric({bool horizontal = false, bool vertical = false}) {
    copyWith(
        top: vertical ? top : 0,
        bottom: vertical ? bottom : 0,
        left: horizontal ? left : 0,
        right: horizontal ? right : 0);
    return this;
  }

  EdgeInsets only({double? left, double? top, double? right, double? bottom}) {
    copyWith(
        top: top ?? this.top,
        bottom: bottom ?? this.bottom,
        left: left ?? this.left,
        right: right ?? this.right);
    return this;
  }
}

extension ButtonStyleExtension on ButtonStyle {
  /// A style for a disabled button.
  ///
  /// This style sets the background color of the button to [Style.colors.secondary]
  /// and the foreground color to [Style.colors.background].
  ///
  /// The actual value of the colors is determined by the [Style.index] of the given
  /// [BuildContext].
  ///
  /// The style is applied to all states of the button, i.e. [WidgetState.disabled].
  ButtonStyle disabled() {
    return _join(
      ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Style.colors.secondary),
        foregroundColor: WidgetStatePropertyAll(Style.colors.background),
      ),
    );
  }

  /// A style for a primary button.
  ///
  /// This style sets the background color of the button to [Style.colors.primary]
  /// and the foreground color to [Style.colors.secondary].
  ///
  /// The actual value of the colors is determined by the [Style.index] of the given
  /// [BuildContext].
  ButtonStyle primary() {
    return _join(ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Style.colors.primary),
      foregroundColor: WidgetStatePropertyAll(Style.colors.secondary),
    ));
  }

  ButtonStyle info() {
    return _join(ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Style.colors.info),
      foregroundColor: WidgetStatePropertyAll(Style.colors.secondary),
    ));
  }

  ButtonStyle success() {
    return _join(ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Style.colors.success),
      foregroundColor: WidgetStatePropertyAll(Style.colors.secondary),
    ));
  }

  ButtonStyle warning() {
    return _join(ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Style.colors.warning),
      foregroundColor: WidgetStatePropertyAll(Style.colors.secondary),
    ));
  }

  ButtonStyle danger() {
    return _join(ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Style.colors.danger),
      foregroundColor: WidgetStatePropertyAll(Style.colors.secondary),
    ));
  }

  /// A style for a secondary button.
  ///
  /// This style sets the background color of the button to [Style.colors.secondary]
  /// and the foreground color to [Style.colors.primary].
  ///
  /// The actual value of the colors is determined by the [Style.index] of the given
  /// [BuildContext].
  ButtonStyle secondary() {
    return _join(ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Style.colors.secondary),
      foregroundColor: WidgetStatePropertyAll(Style.colors.primary),
    ));
  }

  /// A style for an outline button.
  ///
  /// This style sets the background color of the button to [Style.colors.background],
  /// the foreground color to [Style.colors.primary], and the outline color to
  /// [Style.colors.primary].
  ///
  /// The actual value of the colors is determined by the [Style.index] of the given
  /// [BuildContext].
  ButtonStyle outline() {
    return _join(ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
      foregroundColor: WidgetStatePropertyAll(Style.colors.primary),
    ));
  }

  /// A style for a small button.
  ///
  /// This style sets the background color of the button to [Style.colors.primary],
  /// the foreground color to [Style.colors.secondary], the padding to 5, and
  /// the shape to a rounded rectangle with [Style.radius.small] as the border
  /// radius.
  ///
  /// The actual value of the colors and the border radius is determined by the
  /// [Style.index] of the given [BuildContext].
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

  /// A style for a medium button.
  ///
  /// This style sets the background color of the button to [Style.colors.primary],
  /// the foreground color to [Style.colors.secondary], the padding to 8, and
  /// the shape to a rounded rectangle with [Style.radius.medium] as the border
  /// radius.
  ///
  /// The actual value of the colors and the border radius is determined by the
  /// [Style.index] of the given [BuildContext].
  ButtonStyle medium(BuildContext context) {
    return _join(ButtonStyle(
        textStyle: WidgetStatePropertyAll(TextStyle(
          fontSize: Style.texts.medium(context),
          fontFamily: Style.fonts.bold,
        )),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: Style.radius.medium(context)))));
  }

  /// A style for a large button.
  ///
  /// This style sets the background color of the button to [Style.colors.primary],
  /// the foreground color to [Style.colors.secondary], the padding to 16, and
  /// the shape to a rounded rectangle with [Style.radius.large] as the border
  /// radius.
  ///
  /// The actual value of the colors and the border radius is determined by the
  /// [Style.index] of the given [BuildContext].
  ButtonStyle large(BuildContext context) {
    return _join(ButtonStyle(
        textStyle: WidgetStatePropertyAll(TextStyle(
          fontSize: Style.texts.title(context),
          fontFamily: Style.fonts.bold,
        )),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: Style.radius.large(context)))));
  }

  /// Returns a new [ButtonStyle] that combines the style of the given
  /// [ButtonStyle] with the default style.
  ///
  /// The properties of the returned [ButtonStyle] are determined as follows:
  ///
  /// * If the given [ButtonStyle] has a value for a property, that value is used.
  /// * If the given [ButtonStyle] does not have a value for a property, the
  ///   default value of the property is used.
  ///
  /// This can be used to create a style that is based on the default style, but
  /// overrides one or more properties. For example, to create a style that is
  /// the same as the default style, but has a different background color, you
  /// can use:
  ///
  ///
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

extension StringExtension on String {
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

  Text get txt => Text(this);
  Text get bold => Text(
        this,
        style: TextStyle(fontFamily: Style.fonts.bold),
      );
  Text get light => Text(
        this,
        style: TextStyle(fontFamily: Style.fonts.light),
      );
  Text get ultra => Text(
        this,
        style: TextStyle(fontFamily: Style.fonts.ultra),
      );
  Text get cursive => Text(
        this,
        style: TextStyle(fontFamily: Style.fonts.cursive),
      );
  Text get primary => Text(this, style: TextStyle(color: Style.colors.primary));
  Text get info => Text(this, style: TextStyle(color: Style.colors.info));
  Text get success => Text(this, style: TextStyle(color: Style.colors.success));
  Text get danger => Text(this, style: TextStyle(color: Style.colors.danger));
  Text get warning => Text(this, style: TextStyle(color: Style.colors.warning));
  Text get secondary =>
      Text(this, style: TextStyle(color: Style.colors.secondary));
  Text get background =>
      Text(this, style: TextStyle(color: Style.colors.background));
  Text get foreground =>
      Text(this, style: TextStyle(color: Style.colors.foreground));
  Text small(BuildContext context) {
    return Text(this, style: TextStyle(fontSize: Style.texts.small(context)));
  }

  Text tiny(BuildContext context) {
    return Text(this, style: TextStyle(fontSize: Style.texts.tiny(context)));
  }

  Text medium(BuildContext context) {
    return Text(this, style: TextStyle(fontSize: Style.texts.medium(context)));
  }

  Text large(BuildContext context) {
    return Text(this, style: TextStyle(fontSize: Style.texts.large(context)));
  }

  Text huge(BuildContext context) {
    return Text(this, style: TextStyle(fontSize: Style.texts.huge(context)));
  }

  Text title(BuildContext context) {
    return Text(this, style: TextStyle(fontSize: Style.texts.title(context)));
  }

  Text biggest(BuildContext context) {
    return Text(this, style: TextStyle(fontSize: Style.texts.biggest(context)));
  }
}

extension TextExtension on Text {
  Text join(TextStyle style) {
    return Text(
      data ?? data ?? "pr",
      style: this.style?.join(style),
    );
  }

  Text get bold => Text(
        data ?? "pr",
        style:
            (style ?? const TextStyle()).copyWith(fontFamily: Style.fonts.bold),
      );
  Text get light => Text(
        data ?? "pr",
        style: (style ?? const TextStyle())
            .copyWith(fontFamily: Style.fonts.light),
      );
  Text get ultra => Text(
        data ?? "pr",
        style: (style ?? const TextStyle())
            .copyWith(fontFamily: Style.fonts.ultra),
      );
  Text get cursive => Text(
        data ?? "pr",
        style: (style ?? const TextStyle())
            .copyWith(fontFamily: Style.fonts.cursive),
      );
  Text get primary => Text(data ?? "pr",
      style:
          (style ?? const TextStyle()).copyWith(color: Style.colors.primary));

  Text get info => Text(data ?? "pr",
      style: (style ?? const TextStyle()).copyWith(color: Style.colors.info));

  Text get success => Text(data ?? "pr",
      style:
          (style ?? const TextStyle()).copyWith(color: Style.colors.success));

  Text get warning => Text(data ?? "pr",
      style:
          (style ?? const TextStyle()).copyWith(color: Style.colors.warning));

  Text get danger => Text(data ?? "pr",
      style: (style ?? const TextStyle()).copyWith(color: Style.colors.danger));
  Text get secondary => Text(data ?? "pr",
      style:
          (style ?? const TextStyle()).copyWith(color: Style.colors.secondary));
  Text get background => Text(data ?? "pr",
      style: (style ?? const TextStyle())
          .copyWith(color: Style.colors.background));
  Text get foreground => Text(data ?? "pr",
      style: (style ?? const TextStyle())
          .copyWith(color: Style.colors.foreground));
  Text small(BuildContext context) {
    return Text(data ?? "pr",
        style: (style ?? const TextStyle())
            .copyWith(fontSize: Style.texts.small(context)));
  }

  Text tiny(BuildContext context) {
    return Text(data ?? "pr",
        style: (style ?? const TextStyle())
            .copyWith(fontSize: Style.texts.tiny(context)));
  }

  Text medium(BuildContext context) {
    return Text(data ?? "pr",
        style: (style ?? const TextStyle())
            .copyWith(fontSize: Style.texts.medium(context)));
  }

  Text large(BuildContext context) {
    return Text(data ?? "pr",
        style: (style ?? const TextStyle())
            .copyWith(fontSize: Style.texts.large(context)));
  }

  Text huge(BuildContext context) {
    return Text(data ?? "pr",
        style: (style ?? const TextStyle())
            .copyWith(fontSize: Style.texts.huge(context)));
  }

  Text title(BuildContext context) {
    return Text(data ?? "pr",
        style: (style ?? const TextStyle())
            .copyWith(fontSize: Style.texts.title(context)));
  }

  Text title15(BuildContext context) {
    return Text(data ?? "pr",
        style: (style ?? const TextStyle())
            .copyWith(fontSize: Style.texts.title(context) + 15));
  }

  Text biggest(BuildContext context) {
    return Text(data ?? "pr",
        style: (style ?? const TextStyle())
            .copyWith(fontSize: Style.texts.biggest(context)));
  }
}

extension TextStyleExtension on TextStyle {
  TextStyle join(TextStyle style) {
    return TextStyle(
      color: style.color ?? color,
      backgroundColor: style.backgroundColor ?? backgroundColor,
      fontSize: style.fontSize ?? fontSize,
      fontWeight: style.fontWeight ?? fontWeight,
      fontStyle: style.fontStyle ?? fontStyle,
      letterSpacing: style.letterSpacing ?? letterSpacing,
      wordSpacing: style.wordSpacing ?? wordSpacing,
      textBaseline: style.textBaseline ?? textBaseline,
      height: style.height ?? height,
      leadingDistribution: style.leadingDistribution ?? leadingDistribution,
      locale: style.locale ?? locale,
      foreground: style.foreground ?? foreground,
      background: style.background ?? background,
      shadows: style.shadows ?? shadows,
      fontFeatures: style.fontFeatures ?? fontFeatures,
      fontVariations: style.fontVariations ?? fontVariations,
      decoration: style.decoration ?? decoration,
      decorationColor: style.decorationColor ?? decorationColor,
      decorationStyle: style.decorationStyle ?? decorationStyle,
      decorationThickness: style.decorationThickness ?? decorationThickness,
      debugLabel: style.debugLabel ?? debugLabel,
      fontFamily: style.fontFamily ?? fontFamily,
      fontFamilyFallback: style.fontFamilyFallback ?? fontFamilyFallback,
      overflow: style.overflow ?? overflow,
    );
  }
}

extension ColorExtension on Color {
  /// * Darkens the color by the given [amount]. The [amount] must be between 0 and 1.
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    return Color.fromARGB(
      alpha,
      (red * (1 - amount)).round(),
      (green * (1 - amount)).round(),
      (blue * (1 - amount)).round(),
    );
  }

  /// * Lightens the color by the given [amount]. The [amount] must be between 0 and 1.
  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    return Color.fromARGB(
      alpha,
      red + ((255 - red) * amount).round(),
      green + ((255 - green) * amount).round(),
      blue + ((255 - blue) * amount).round(),
    );
  }
}
