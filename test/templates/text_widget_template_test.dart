import 'package:flutter_test/flutter_test.dart';
import 'package:theme_kit/src/config/theme_config.dart';
import 'package:theme_kit/src/templates/text_widget_template.dart';

void main() {
  group('TextWidgetTemplate', () {
    test('should generate text widget class', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
      });

      final generated = TextWidgetTemplate.generate(config);

      expect(generated, contains('class TTText extends Text'));
    });

    test('should include necessary imports', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
      });

      final generated = TextWidgetTemplate.generate(config);

      expect(generated, contains("import 'dart:ui';"));
      expect(generated, contains("import 'package:flutter/widgets.dart';"));
      expect(generated, contains("import 'tt_font_family.dart';"));
      expect(generated, contains("import 'tt_font_weight.dart';"));
    });

    test('should generate factory constructors for text styles', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
        'text_styles': [
          {'name': 'headingL', 'font_size': 28.0},
          {'name': 'bodyM', 'font_size': 16.0},
        ],
      });

      final generated = TextWidgetTemplate.generate(config);

      expect(generated, contains('static TTText headingL(String data)'));
      expect(generated, contains('fontSize: 28.0'));
      expect(generated, contains('static TTText bodyM(String data)'));
      expect(generated, contains('fontSize: 16.0'));
    });

    test('should include copyWith method', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
      });

      final generated = TextWidgetTemplate.generate(config);

      expect(generated, contains('TTText copyWith({'));
      expect(generated, contains('return TTText('));
    });

    test('should include styles method', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
      });

      final generated = TextWidgetTemplate.generate(config);

      expect(generated, contains('TTText styles({'));
      expect(generated, contains('copyWith('));
    });

    test('should use first font family as default', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
        'font_families': ['Roboto', 'Inter'],
      });

      final generated = TextWidgetTemplate.generate(config);

      expect(generated, contains('TTFontFamily.roboto'));
    });

    test('should handle font families with spaces', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
        'font_families': ['Open Sans'],
      });

      final generated = TextWidgetTemplate.generate(config);

      expect(generated, contains('TTFontFamily.openSans'));
    });
  });
}
