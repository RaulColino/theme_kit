import '../config/theme_config.dart';

/// Template for generating the main theme class (InheritedWidget)
class MainThemeTemplate {
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
