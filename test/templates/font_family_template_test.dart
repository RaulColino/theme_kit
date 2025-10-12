import 'package:flutter_test/flutter_test.dart';
import 'package:theme_kit/src/config/theme_config.dart';
import 'package:theme_kit/src/templates/font_family_template.dart';

void main() {
  group('FontFamilyTemplate', () {
    test('should generate font family class with single family', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
        'font_families': ['Inter'],
      });

      final generated = FontFamilyTemplate.generate(config);

      expect(generated, contains('class TTFontFamily'));
      expect(generated, contains('static const TTFontFamily inter'));
      expect(generated, contains('TTFontFamily._("Inter")'));
    });

    test('should generate font family class with multiple families', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
        'font_families': ['Inter', 'Roboto', 'Open Sans'],
      });

      final generated = FontFamilyTemplate.generate(config);

      expect(generated, contains('static const TTFontFamily inter'));
      expect(generated, contains('static const TTFontFamily roboto'));
      expect(generated, contains('static const TTFontFamily openSans'));
    });

    test('should handle font family names with spaces', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
        'font_families': ['Open Sans'],
      });

      final generated = FontFamilyTemplate.generate(config);

      expect(generated, contains('static const TTFontFamily openSans'));
      expect(generated, contains('TTFontFamily._("Open Sans")'));
    });

    test('should generate valid Dart code', () {
      final config = ThemeConfig.fromYaml({
        'name': 'test_theme',
        'prefix': 'tt',
        'font_families': ['Inter'],
      });

      final generated = FontFamilyTemplate.generate(config);

      // Check for basic Dart syntax
      expect(generated, contains('class TTFontFamily'));
      expect(generated, contains('const TTFontFamily._(this.name);'));
      expect(generated, contains('final String name;'));
    });
  });
}
