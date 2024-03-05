// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:ui';

// import 'a_theme.dart';
import 'a_theme.dart';

//You can't exclude this file from the dart formatter because the Flutter team has not implemented this feature yet -_-
class AColor {
  //Exceptions
  static final Exception _themekitWidgetException = Exception("Theme Kit ERROR: AuraUi widget not created. Please wrap your app with the AuraUi widget. Check Theme Kit docs for more info.");
  static final Exception _colorNullException = Exception("Theme Kit ERROR: Color cannot be null.");

  //AuraUi semantic colors
  static Color? _primary;
  static Color? _secondary;
  static Color? _success;
  static Color? _warning;
  static Color? _error;
  static Color? _info;
  static Color? _background;
  static Color? _surface100;
  static Color? _surface200;
  static Color? _textPrimary;
  static Color? _textSecondary;
  static Color? _divider;
  static Color? _border;

  //Getters
  static Color get primary { if (_primary == null) throw _themekitWidgetException; else return _primary!; }
  static Color get secondary { if (_secondary == null) throw _themekitWidgetException; else return _secondary!; }
  static Color get success { if (_success == null) throw _themekitWidgetException; else return _success!; }
  static Color get warning { if (_warning == null) throw _themekitWidgetException; else return _warning!; }
  static Color get error { if (_error == null) throw _themekitWidgetException; else return _error!; }
  static Color get info { if (_info == null) throw _themekitWidgetException; else return _info!; }
  static Color get background { if (_background == null) throw _themekitWidgetException; else return _background!; }
  static Color get surface100 { if (_surface100 == null) throw _themekitWidgetException; else return _surface100!; }
  static Color get surface200 { if (_surface200 == null) throw _themekitWidgetException; else return _surface200!; }
  static Color get textPrimary { if (_textPrimary == null) throw _themekitWidgetException; else return _textPrimary!; }
  static Color get textSecondary { if (_textSecondary == null) throw _themekitWidgetException; else return _textSecondary!; }
  static Color get divider { if (_divider == null) throw _themekitWidgetException; else return _divider!; }
  static Color get border { if (_border == null) throw _themekitWidgetException; else return _border!; }

  //Setters
  static set primary(Color? color) { if (color == null) throw _colorNullException; else _primary = color; }
  static set secondary(Color? color) { if (color == null) throw _colorNullException; else _secondary = color; }
  static set success(Color? color) { if (color == null) throw _colorNullException; else _success = color; }
  static set warning(Color? color) { if (color == null) throw _colorNullException; else _warning = color; }
  static set error(Color? color) { if (color == null) throw _colorNullException; else _error = color; }
  static set info(Color? color) { if (color == null) throw _colorNullException; else _info = color; }
  static set background(Color? color) { if (color == null) throw _colorNullException; else _background = color; }
  static set surface100(Color? color) { if (color == null) throw _colorNullException; else _surface100 = color; }
  static set surface200(Color? color) { if (color == null) throw _colorNullException; else _surface200 = color; }
  static set textPrimary(Color? color) { if (color == null) throw _colorNullException; else _textPrimary = color; }
  static set textSecondary(Color? color) { if (color == null) throw _colorNullException; else _textSecondary = color; }
  static set divider(Color? color) { if (color == null) throw _colorNullException; else _divider = color; }
  static set border(Color? color) { if (color == null) throw _colorNullException; else _border = color; }

  //Constructor
  AColor._();

  static void setTheme(ATheme theme) {
    primary = theme.primary!;
    secondary = theme.secondary!;
    success = theme.success!;
    warning = theme.warning!;
    error = theme.error!;
    info = theme.info!;
    background = theme.background!;
    surface100 = theme.surface100!;
    surface200 = theme.surface200!;
    textPrimary = theme.textPrimary!;
    textSecondary = theme.textSecondary!;
    divider = theme.divider!;
    border = theme.border!;
  }
}
