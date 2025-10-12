import 'package:flutter_test/flutter_test.dart';
import 'package:theme_kit/src/config/theme_config.dart';
import 'package:theme_kit/src/templates/theme_class_template.dart';

void main() {
  group('ThemeClassTemplate', () {
    test('should generate theme class with default colors', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
      });

      final generated = ThemeClassTemplate.generate(config);

      expect(generated, contains('class TTTheme'));
      expect(generated, contains('TTTheme({'));
      expect(generated, contains('this.primary,'));
      expect(generated, contains('final Color? primary;'));
    });

    test('should generate theme class with custom colors', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
        'colors': {
          'customColor': {'description': 'Custom'},
          'anotherColor': {'description': 'Another'},
        },
      });

      final generated = ThemeClassTemplate.generate(config);

      expect(generated, contains('this.customColor,'));
      expect(generated, contains('this.anotherColor,'));
      expect(generated, contains('final Color? customColor;'));
      expect(generated, contains('final Color? anotherColor;'));
    });

    test('should include Flutter imports', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
      });

      final generated = ThemeClassTemplate.generate(config);

      expect(generated, contains("import 'package:flutter/material.dart';"));
    });

    test('should include theme description comment', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
      });

      final generated = ThemeClassTemplate.generate(config);

      expect(generated, contains('/// Theme configuration for test_theme'));
    });
  });
}
