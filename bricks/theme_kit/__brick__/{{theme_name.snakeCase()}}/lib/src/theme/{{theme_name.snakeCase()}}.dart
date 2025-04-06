import 'package:flutter/material.dart';
import '../colors/{{prefix.snakeCase()}}_color.dart';
import '../colors/{{prefix.snakeCase()}}_theme.dart';


// Global variables to store the light and dark themes
{{prefix.pascalCase()}}Theme? _lightTheme;
{{prefix.pascalCase()}}Theme? _darkTheme;

enum ThemeType { light, dark }

class {{theme_name.pascalCase()}} extends StatefulWidget {
  // Properties
  // The child widget that will be wrapped by {{theme_name.pascalCase()}}. When the theme changes, the child widget will be rebuilt.
  final Widget child;
  // Establishes a theme selection and persists it in memory across hot reloads
  static ThemeType? _currentThemeType;
  // This is a global key that let us access the _{{theme_name.pascalCase()}}State from the {{theme_name.pascalCase()}} class
  // See: https://stackoverflow.com/a/60513911
  static final GlobalKey<_{{theme_name.pascalCase()}}State> _themeKitStateGlobalKey = GlobalKey();

  // Constructor
  {{theme_name.pascalCase()}}({
    Key? key,
    required {{prefix.pascalCase()}}Theme lightTheme,
    required {{prefix.pascalCase()}}Theme darkTheme,
    required this.child,
  }) : super(key: _themeKitStateGlobalKey) {
    _lightTheme = lightTheme;
    _darkTheme = darkTheme;
    // If theme not set, set the light theme
    if (_currentThemeType == null) {
      //Set light theme as default
      _currentThemeType = ThemeType.light;
      {{prefix.pascalCase()}}Color.setTheme(lightTheme);
    }
  }

  // Methods
  static void _setThemeAndUpdateState({{prefix.pascalCase()}}Theme? theme) {
    if (theme == null) throw Exception("Theme Kit ERROR: {{theme_name.pascalCase()}} widget not created. Please wrap your app with the {{theme_name.pascalCase()}} widget. Check Theme Kit docs for more info.");
    {{prefix.pascalCase()}}Color.setTheme(theme);
    try {
      // To use this, {{theme_name.pascalCase()}} must be a StatefulWidget
      _themeKitStateGlobalKey.currentState!
          .setState(() {}); // ignore: invalid_use_of_protected_member
    } catch (e) {
      // The current state (_themeKitStateGlobalKey.currentState) is null if there is no widget in the tree that
      // matches the global key: _themeKitStateGlobalKey, which means that the {{theme_name.pascalCase()}} widget is not in the widget tree.
      throw Exception("Theme Kit ERROR: {{theme_name.pascalCase()}} widget not found in the widget tree.");
    }
  }

  static void setLightTheme() {
    if (_currentThemeType != ThemeType.light) {
      // print("setLightTheme");
      _currentThemeType = ThemeType.light;
      _setThemeAndUpdateState(_lightTheme);
    }
  }

  static void setDarkTheme() {
    if (_currentThemeType != ThemeType.dark) {
      // print("setDarkTheme");
      _currentThemeType = ThemeType.dark;
      _setThemeAndUpdateState(_darkTheme);
    }
  }

  @override
  State<{{theme_name.pascalCase()}}> createState() => _{{theme_name.pascalCase()}}State();
}


class _{{theme_name.pascalCase()}}State extends State<{{theme_name.pascalCase()}}> {
  Key refreshKey = UniqueKey();

  // State refresh based on: https://stackoverflow.com/a/50116077 and https://stackoverflow.com/a/73129922/463029
  void _refreshState() {
    setState(() {
      refreshKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("{{theme_name.pascalCase()}} build");
    // Rebuild all the child widgets of {{theme_name.pascalCase()}}
    _refreshState();
    // Return the child widget wrapped in a KeyedSubtree widget to rebuild its children after the refreshKey changes. See: https://stackoverflow.com/a/50116077
    return KeyedSubtree(
      key: refreshKey,
      child: widget.child,
    );
  }
}