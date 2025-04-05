import 'package:flutter/widgets.dart';

import '{{prefix.snakeCase()}}_font_family.dart';
import '{{prefix.snakeCase()}}_font_weight.dart';
import '../colors/{{prefix.snakeCase()}}_color.dart';

/// Theme Kit Text widget
/// A custom wrapper for the standard Flutter `Text` widget.
/// It provides a more efficient way to define text styles and text attributes. E.g.:
/// ```dart
/// {{prefix.pascalCase()}}Text.bodyM("Hello World").styles(
///   color: {{prefix.pascalCase()}}Color.primary,
///   fontWeight: {{prefix.pascalCase()}}FontWeight.bold,
///   overflow: TextOverflow.ellipsis,
///   maxLines: 2,
/// );
/// ```
class {{prefix.pascalCase()}}Text extends Text {
  // Exclusive attributes of the class
  final {{prefix.pascalCase()}}FontWeight? fontWeight;
  final {{prefix.pascalCase()}}FontFamily? fontFamily;
  // Added because TextStyle package is private and doesn't have a getter.
  // We don't need to define a package because we provide font files without declaring a font 
  // in its pubspec.yaml, saving them in the lib/ folder of the package. The font files will 
  // not automatically be bundled in the app, instead the app can use these selectively when declaring a font. 
  final String? package;

  // {{theme_name.pascalCase()}} text types
  // Display XL
  static {{prefix.pascalCase()}}Text displayXL(String data) => {{prefix.pascalCase()}}Text._(data).styles(
        fontSize: 96,
        fontWeight: {{prefix.pascalCase()}}FontWeight.bold,
        letterSpacing: -1.5,
      );

  // Display L
  static {{prefix.pascalCase()}}Text displayL(String data) => {{prefix.pascalCase()}}Text._(data).styles(
        fontSize: 60,
        fontWeight: {{prefix.pascalCase()}}FontWeight.bold,
        letterSpacing: -0.5,
      );

  // Body M
  static {{prefix.pascalCase()}}Text bodyM(String data) => {{prefix.pascalCase()}}Text._(data).styles(
        fontSize: 16,
        fontWeight: {{prefix.pascalCase()}}FontWeight.regular,
        letterSpacing: 0.5,
      );

  // Constructor
  {{prefix.pascalCase()}}Text._(
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
    this.fontWeight = {{prefix.pascalCase()}}FontWeight.regular,
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
    this.fontFamily = {{prefix.pascalCase()}}FontFamily.poppins,
    List<String>? fontFamilyFallback,
    this.package,
  }) : super(
          data,
          key: key,
          style: TextStyle(
            inherit: inherit ?? true,
            color: color ?? {{prefix.pascalCase()}}Color.textPrimary,
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

  // CopyWith
  {{prefix.pascalCase()}}Text _copyWith({
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
    {{prefix.pascalCase()}}FontWeight? fontWeight,
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
    {{prefix.pascalCase()}}FontFamily? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
  }) {
    return {{prefix.pascalCase()}}Text._(
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

  {{prefix.pascalCase()}}Text styles({
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
    {{prefix.pascalCase()}}FontWeight? fontWeight,
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
    {{prefix.pascalCase()}}FontFamily? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
  }) =>
      _copyWith(
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
}
