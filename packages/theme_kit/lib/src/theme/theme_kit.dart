import 'package:flutter/material.dart';
import '../colors/tk_color.dart';
import '../colors/tk_theme.dart';


//Global variables to store the light and dark themes
TkTheme? _lightTheme;
TkTheme? _darkTheme;

enum ThemeType { light, dark }

class ThemeKit extends StatefulWidget {
  //Properties
  //The child widget that will be wrapped by ThemeKit. When the theme changes, the child widget will be rebuilt.
  final Widget child;
  //Establishes a theme selection and persists it in memory across hot reloads
  static ThemeType? _currentThemeType;
  //This is a global key that let us access the _ThemeKitState from the ThemeKit class
  //See: https://stackoverflow.com/a/60513911
  static final GlobalKey<_ThemeKitState> _themeKitStateGlobalKey = GlobalKey();

  //Constructor
  ThemeKit({
    Key? key,
    required TkTheme lightTheme,
    required TkTheme darkTheme,
    required this.child,
  }) : super(key: _themeKitStateGlobalKey) {
    //If theme not set, set the light theme
    if (_currentThemeType == null) {
      _lightTheme = lightTheme;
      _darkTheme = darkTheme;
      //Set light theme as default
      _currentThemeType = ThemeType.light;
      TkColor.setTheme(lightTheme);
    }
  }

  //Methods
  static void _setThemeAndUpdateState(TkTheme? theme) {
    if (theme == null) throw Exception("Theme Kit ERROR: ThemeKit widget not created. Please wrap your app with the ThemeKit widget. Check Theme Kit docs for more info.");
    TkColor.setTheme(theme);
    try {
      //To use this, ThemeKit must be a StatefulWidget
      _themeKitStateGlobalKey.currentState!
          .setState(() {}); // ignore: invalid_use_of_protected_member
    } catch (e) {
      //The current state (_auraUIKey.currentState) is null if there is no widget in the tree that
      // matches the global key: _themeKitStateGlobalKey, which means that the ThemeKit widget is not in the widget tree.
      throw Exception("Theme Kit ERROR: ThemeKit widget not found in the widget tree.");
    }
  }

  static void setLightTheme() {
    if (_currentThemeType != ThemeType.light) {
      //print("setLightTheme");
      _currentThemeType = ThemeType.light;
      _setThemeAndUpdateState(_lightTheme);
    }
  }

  static void setDarkTheme() {
    if (_currentThemeType != ThemeType.dark) {
      //print("setDarkTheme");
      _currentThemeType = ThemeType.dark;
      _setThemeAndUpdateState(_darkTheme);
    }
  }

  @override
  State<ThemeKit> createState() => _ThemeKitState();
}


class _ThemeKitState extends State<ThemeKit> {
  Key refreshKey = UniqueKey();

  //State refresh based on: https://stackoverflow.com/a/50116077 and https://stackoverflow.com/a/73129922/463029
  void _refreshState() {
    setState(() {
      refreshKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    //print("ThemeKit build");
    //Rebuild all the child widgets of ThemeKit
    _refreshState();
    //Return the child widget wrapped in a KeyedSubtree widget to rebuild its children after the refreshKey changes. See: https://stackoverflow.com/a/50116077
    return KeyedSubtree(
      key: refreshKey,
      child: widget.child,
    );
  }
}