import '../config/theme_config.dart';

/// Template for generating the main theme class (InheritedWidget)
/// 
/// Creates a StatefulWidget that manages theme state and provides it
/// to the widget tree. Supports light/dark theme switching.
class MainThemeTemplate {
  // Private constructor to prevent instantiation
  MainThemeTemplate._();

  /// Generates the main theme widget code
  /// 
  /// Returns a String containing valid Dart code for the theme widget.
  static String generate(ThemeConfig config) {
    final className = config.pascalCaseName;
    final themeClassName = '${config.prefix.toUpperCase()}Theme';
    final colorClassName = '${config.prefix.toUpperCase()}Color';

    return '''
import 'package:flutter/material.dart';
import 'src/colors/${config.prefix}_theme.dart';
import 'src/colors/${config.prefix}_color.dart';

/// Main theme widget for ${config.name}
/// 
/// Wrap your MaterialApp with this widget to provide theme to your app.
/// 
/// Example:
/// ```dart
/// $className(
///   lightTheme: $themeClassName(...),
///   darkTheme: $themeClassName(...),
///   child: MaterialApp(...),
/// )
/// ```
class $className extends StatefulWidget {
  final Widget child;
  final $themeClassName lightTheme;
  final $themeClassName? darkTheme;

  const $className({
    Key? key,
    required this.child,
    required this.lightTheme,
    this.darkTheme,
  }) : super(key: key);

  @override
  State<$className> createState() => _${className}State();

  static _${className}State? of(BuildContext context) {
    return context.findAncestorStateOfType<_${className}State>();
  }

  static void setLightTheme() {
    _${className}State._currentTheme = _${className}State._lightTheme;
    $colorClassName.setTheme(_${className}State._lightTheme!);
  }

  static void setDarkTheme() {
    if (_${className}State._darkTheme == null) {
      throw StateError('Dark theme is not available. Please provide a darkTheme to $className widget.');
    }
    _${className}State._currentTheme = _${className}State._darkTheme;
    $colorClassName.setTheme(_${className}State._darkTheme!);
  }
}

class _${className}State extends State<$className> {
  static $themeClassName? _lightTheme;
  static $themeClassName? _darkTheme;
  static $themeClassName? _currentTheme;

  @override
  void initState() {
    super.initState();
    _lightTheme = widget.lightTheme;
    _darkTheme = widget.darkTheme;
    _currentTheme = _lightTheme;
    $colorClassName.setTheme(_currentTheme!);
  }

  @override
  void didUpdateWidget($className oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.lightTheme != widget.lightTheme ||
        oldWidget.darkTheme != widget.darkTheme) {
      _lightTheme = widget.lightTheme;
      _darkTheme = widget.darkTheme;
      _currentTheme = _lightTheme;
      $colorClassName.setTheme(_currentTheme!);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
''';
  }
}
