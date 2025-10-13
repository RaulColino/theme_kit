import 'package:flutter_test/flutter_test.dart';
import 'package:theme_kit/src/config/theme_config.dart';
import 'package:theme_kit/src/templates/color_template.dart';

void main() {
  group('ColorTemplate', () {
    test('should generate color class with default colors', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
      });

      final generated = ColorTemplate.generate(config);

      expect(generated, contains('class TTColor'));
      expect(generated, contains('static Color? get primary'));
      expect(generated, contains('static Color? get secondary'));
      expect(generated, contains('static Color? get background'));
    });

    test('should generate color class with custom colors', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
        'colors': {
          'customColor': {'description': 'My custom color'},
          'anotherColor': {'description': 'Another color'},
        },
      });

      final generated = ColorTemplate.generate(config);

      expect(generated, contains('static Color? get customColor'));
      expect(generated, contains('static Color? get anotherColor'));
      expect(generated, contains('/// My custom color'));
      expect(generated, contains('/// Another color'));
    });

    test('should include Flutter imports', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
      });

      final generated = ColorTemplate.generate(config);

      expect(generated, contains("import 'package:flutter/material.dart';"));
      expect(generated, contains("import 'tt_theme.dart';"));
    });

    test('should generate setTheme method', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
      });

      final generated = ColorTemplate.generate(config);

      expect(generated, contains('static void setTheme(TTTheme theme)'));
      expect(generated, contains('_theme = theme;'));
    });

    test('should include color descriptions as comments', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
        'colors': {
          'primary': {'description': 'Primary brand color'},
        },
      });

      final generated = ColorTemplate.generate(config);

      expect(generated, contains('/// Primary brand color'));
    });

    test('should include private constructor to prevent instantiation', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
      });

      final generated = ColorTemplate.generate(config);

      expect(generated, contains('TTColor._();'));
      expect(generated, contains('// Private constructor to prevent instantiation'));
    });
  });
}
