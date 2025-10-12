import 'package:flutter_test/flutter_test.dart';
import 'package:theme_kit/src/config/theme_config.dart';
import 'package:theme_kit/src/templates/font_weight_template.dart';

void main() {
  group('FontWeightTemplate', () {
    test('should generate font weight class with default weights', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
      });

      final generated = FontWeightTemplate.generate(config);

      expect(generated, contains('class TTFontWeight'));
      expect(generated, contains('static const regular'));
      expect(generated, contains('static const medium'));
      expect(generated, contains('static const semibold'));
      expect(generated, contains('static const bold'));
    });

    test('should generate font weight class with custom weights', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
        'font_weights': [
          {'name': 'light', 'weight': 300},
          {'name': 'heavy', 'weight': 900},
        ],
      });

      final generated = FontWeightTemplate.generate(config);

      expect(generated, contains('static const light'));
      expect(generated, contains('FontWeight.w300'));
      expect(generated, contains('static const heavy'));
      expect(generated, contains('FontWeight.w900'));
    });

    test('should include dart:ui import', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
      });

      final generated = FontWeightTemplate.generate(config);

      expect(generated, contains("import 'dart:ui';"));
    });

    test('should generate valid Dart code', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
      });

      final generated = FontWeightTemplate.generate(config);

      expect(generated, contains('class TTFontWeight'));
      expect(generated, contains('const TTFontWeight._(this.value);'));
      expect(generated, contains('final FontWeight value;'));
    });
  });
}
