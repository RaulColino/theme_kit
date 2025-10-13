import 'package:flutter_test/flutter_test.dart';
import 'package:theme_kit/src/config/theme_config.dart';
import 'package:theme_kit/src/templates/main_theme_template.dart';

void main() {
  group('MainThemeTemplate', () {
    test('should generate main theme StatefulWidget', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
      });

      final generated = MainThemeTemplate.generate(config);

      expect(generated, contains('class TestTheme extends StatefulWidget'));
      expect(generated, contains('class _TestThemeState extends State<TestTheme>'));
    });

    test('should include necessary imports', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
      });

      final generated = MainThemeTemplate.generate(config);

      expect(generated, contains("import 'package:flutter/material.dart';"));
      expect(generated, contains("import 'src/colors/tt_theme.dart';"));
      expect(generated, contains("import 'src/colors/tt_color.dart';"));
    });

    test('should generate with required properties', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
      });

      final generated = MainThemeTemplate.generate(config);

      expect(generated, contains('final Widget child;'));
      expect(generated, contains('final TTTheme lightTheme;'));
      expect(generated, contains('final TTTheme? darkTheme;'));
    });

    test('should generate setLightTheme static method', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
      });

      final generated = MainThemeTemplate.generate(config);

      expect(generated, contains('static void setLightTheme()'));
      expect(generated, contains('_currentTheme = _lightTheme'));
      expect(generated, contains('TTColor.setTheme(_lightTheme!)'));
    });

    test('should generate setDarkTheme static method', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
      });

      final generated = MainThemeTemplate.generate(config);

      expect(generated, contains('static void setDarkTheme()'));
      expect(generated, contains('_currentTheme = _darkTheme'));
      expect(generated, contains('TTColor.setTheme(_darkTheme!)'));
    });

    test('should generate of method for context access', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
      });

      final generated = MainThemeTemplate.generate(config);

      expect(generated, contains('static _TestThemeState? of(BuildContext context)'));
      expect(generated, contains('findAncestorStateOfType<_TestThemeState>()'));
    });

    test('should include usage documentation in comments', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
      });

      final generated = MainThemeTemplate.generate(config);

      expect(generated, contains('/// Main theme widget for test_theme'));
      expect(generated, contains('/// Wrap your MaterialApp with this widget'));
    });

    test('should handle theme name with underscores', () {
      final config = ThemeConfig.fromYaml({
        'name': 'my_custom_theme',
        'prefix': 'mct',
      });

      final generated = MainThemeTemplate.generate(config);

      expect(generated, contains('class MyCustomTheme extends StatefulWidget'));
      expect(generated, contains('class _MyCustomThemeState extends State<MyCustomTheme>'));
    });

    test('should initialize theme in initState', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
      });

      final generated = MainThemeTemplate.generate(config);

      expect(generated, contains('@override'));
      expect(generated, contains('void initState()'));
      expect(generated, contains('_lightTheme = widget.lightTheme'));
      expect(generated, contains('_currentTheme = _lightTheme'));
    });

    test('should handle widget updates in didUpdateWidget', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
      });

      final generated = MainThemeTemplate.generate(config);

      expect(generated, contains('void didUpdateWidget(TestTheme oldWidget)'));
      expect(generated, contains('oldWidget.lightTheme != widget.lightTheme'));
      expect(generated, contains('setState(() {})'));
    });
  });
}
