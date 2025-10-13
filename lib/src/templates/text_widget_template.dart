import '../config/theme_config.dart';

/// Template for generating the text widget class
/// 
/// Creates a custom Text widget that extends Flutter's Text widget
/// with theme-aware styling and convenient factory constructors for
/// each defined text style.
class TextWidgetTemplate {
  /// Generates the text widget class code
  /// 
  /// Returns a String containing valid Dart code for the custom Text widget.
  static String generate(ThemeConfig config) {
    final className = '${config.prefix.toUpperCase()}Text';
    final fontWeightClass = '${config.prefix.toUpperCase()}FontWeight';
    final fontFamilyClass = '${config.prefix.toUpperCase()}FontFamily';

    // Generate factory constructors for each text style
    final factories = config.textStyles.map((style) {
      final fontSize = style.fontSize ?? 14.0;
      return '''
  /// Returns a ${style.name} text
  static $className ${style.name}(String data) => $className(data).styles(
        fontSize: $fontSize,
        fontWeight: $fontWeightClass.regular,
        fontFamily: $fontFamilyClass.${_getDefaultFontFamily(config)},
      );''';
    }).join('\n\n');

    return '''
import 'dart:ui';

import 'package:flutter/widgets.dart';

import '${config.prefix}_font_family.dart';
import '${config.prefix}_font_weight.dart';

/// Text widget for ${config.name} theme
class $className extends Text {
  //Exclusive attributes of the class
  final $fontWeightClass? fontWeight;
  final $fontFamilyClass? fontFamily;
  final String? package; //Added because TextStyle package is private and doesn't have a getter

  //Constructor
  $className(
    String data, {
    Key? key,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
    //'TextStyle style' attributes from standard Text widget
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize = 14,
    this.fontWeight = $fontWeightClass.regular,
    FontStyle? fontStyle,
    double? letterSpacing = 0.0,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height = 1.0,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    this.fontFamily = $fontFamilyClass.${_getDefaultFontFamily(config)},
    List<String>? fontFamilyFallback,
    this.package,
  }) : super(
          data,
          key: key,
          style: TextStyle(
            inherit: inherit ?? true,
            color: color,
            backgroundColor: backgroundColor,
            fontSize: fontSize,
            fontWeight: fontWeight?.value,
            fontStyle: fontStyle,
            letterSpacing: letterSpacing,
            wordSpacing: wordSpacing,
            textBaseline: textBaseline,
            height: height,
            locale: locale,
            foreground: foreground,
            background: background,
            shadows: shadows,
            fontFeatures: fontFeatures,
            decoration: decoration,
            decorationColor: decorationColor,
            decorationStyle: decorationStyle,
            decorationThickness: decorationThickness,
            debugLabel: debugLabel,
            fontFamily: fontFamily?.name,
            fontFamilyFallback: fontFamilyFallback,
            package: package,
          ),
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis,
          textHeightBehavior: textHeightBehavior,
          selectionColor: selectionColor,
        );

  //CopyWith
  $className copyWith({
    String? data,
    Key? key,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
    //'TextStyle style' attributes from standard Text widget
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    $fontWeightClass? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    $fontFamilyClass? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
  }) {
    return $className(
      data ?? this.data ?? "",
      key: key ?? this.key,
      strutStyle: strutStyle ?? this.strutStyle,
      textAlign: textAlign ?? this.textAlign,
      textDirection: textDirection ?? this.textDirection,
      locale: locale ?? this.locale,
      softWrap: softWrap ?? this.softWrap,
      overflow: overflow ?? this.overflow,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      maxLines: maxLines ?? this.maxLines,
      semanticsLabel: semanticsLabel ?? this.semanticsLabel,
      textWidthBasis: textWidthBasis ?? this.textWidthBasis,
      textHeightBehavior: textHeightBehavior ?? this.textHeightBehavior,
      selectionColor: selectionColor ?? this.selectionColor,
      //'TextStyle style' attributes from standard Text widget
      inherit: inherit ?? style?.inherit,
      color: color ?? style?.color,
      backgroundColor: backgroundColor ?? style?.backgroundColor,
      fontSize: fontSize ?? style?.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? style?.fontStyle,
      letterSpacing: letterSpacing ?? style?.letterSpacing,
      wordSpacing: wordSpacing ?? style?.wordSpacing,
      textBaseline: textBaseline ?? style?.textBaseline,
      height: height ?? style?.height,
      foreground: foreground ?? style?.foreground,
      background: background ?? style?.background,
      shadows: shadows ?? style?.shadows,
      fontFeatures: fontFeatures ?? style?.fontFeatures,
      decoration: decoration ?? style?.decoration,
      decorationColor: decorationColor ?? style?.decorationColor,
      decorationStyle: decorationStyle ?? style?.decorationStyle,
      decorationThickness: decorationThickness ?? style?.decorationThickness,
      debugLabel: debugLabel ?? style?.debugLabel,
      fontFamily: fontFamily ?? this.fontFamily,
      fontFamilyFallback: fontFamilyFallback ?? style?.fontFamilyFallback,
      package: package ?? this.package,
    );
  }

  $className styles({
    Key? key,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
    //'TextStyle style' attributes from standard Text widget
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    $fontWeightClass? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    $fontFamilyClass? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
  }) =>
      copyWith(
        key: key,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaleFactor: textScaleFactor,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
        inherit: inherit,
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
      );

$factories
}
''';
  }

  static String _getDefaultFontFamily(ThemeConfig config) {
    if (config.fontFamilies.isEmpty) return 'inter';
    final family = config.fontFamilies.first;
    return _toFieldName(family);
  }

  static String _toFieldName(String input) {
    // Convert to camelCase
    input = input.trim();
    final words = input.split(RegExp(r'[\s_-]+'));
    return words[0].toLowerCase() +
        words
            .skip(1)
            .map((word) => word.isEmpty
                ? ''
                : word[0].toUpperCase() + word.substring(1).toLowerCase())
            .join('');
  }
}
