import 'package:flutter_test/flutter_test.dart';
import 'package:theme_kit/src/config/theme_config.dart';
import 'dart:io';

void main() {
  group('ThemeConfig', () {
    group('fromFile', () {
      test('should throw ConfigurationException when file does not exist', () {
        expect(
          () => ThemeConfig.fromFile('nonexistent.yaml'),
          throwsA(isA<ConfigurationException>()),
        );
      });

      test('should load valid configuration file', () {
        final tempFile = File('test_config.yaml');
        tempFile.writeAsStringSync('''
name: test_theme
prefix: tt
font_families:
  - Inter
colors:
  primary:
    description: Primary color
''');

        try {
          final config = ThemeConfig.fromFile('test_config.yaml');
          expect(config.name, equals('test_theme'));
          expect(config.prefix, equals('tt'));
          expect(config.fontFamilies, contains('Inter'));
          expect(config.colors.length, greaterThan(0));
        } finally {
          tempFile.deleteSync();
        }
      });

      test('should throw ConfigurationException for empty file', () {
        final tempFile = File('empty_config.yaml');
        tempFile.writeAsStringSync('');

        try {
          expect(
            () => ThemeConfig.fromFile('empty_config.yaml'),
            throwsA(isA<ConfigurationException>()),
          );
        } finally {
          tempFile.deleteSync();
        }
      });

      test('should throw ConfigurationException for invalid YAML', () {
        final tempFile = File('invalid_config.yaml');
        tempFile.writeAsStringSync('invalid: [yaml: structure');

        try {
          expect(
            () => ThemeConfig.fromFile('invalid_config.yaml'),
            throwsA(isA<ConfigurationException>()),
          );
        } finally {
          tempFile.deleteSync();
        }
      });
    });

    group('fromYaml', () {
      test('should parse minimal valid configuration', () {
        final yaml = {
          'name': 'my_theme',
          'prefix': 'mt',
        };

        final config = ThemeConfig.fromYaml(yaml);

        expect(config.name, equals('my_theme'));
        expect(config.prefix, equals('mt'));
        expect(config.fontFamilies, isNotEmpty);
        expect(config.fontWeights, isNotEmpty);
        expect(config.colors, isNotEmpty);
        expect(config.textStyles, isNotEmpty);
      });

      test('should use defaults when optional fields are missing', () {
        final yaml = {
          'name': 'my_theme',
          'prefix': 'mt',
        };

        final config = ThemeConfig.fromYaml(yaml);

        expect(config.fontFamilies, contains('Inter'));
        expect(config.fontWeights.length, equals(4));
        expect(config.colors.length, greaterThan(0));
        expect(config.textStyles.length, greaterThan(0));
      });

      test('should throw ConfigurationException for empty name', () {
        final yaml = {
          'name': '',
          'prefix': 'mt',
        };

        expect(
          () => ThemeConfig.fromYaml(yaml),
          throwsA(isA<ConfigurationException>()),
        );
      });

      test('should throw ConfigurationException for empty prefix', () {
        final yaml = {
          'name': 'my_theme',
          'prefix': '',
        };

        expect(
          () => ThemeConfig.fromYaml(yaml),
          throwsA(isA<ConfigurationException>()),
        );
      });

      test('should throw ConfigurationException for invalid prefix format', () {
        final yaml = {
          'name': 'my_theme',
          'prefix': '1invalid',
        };

        expect(
          () => ThemeConfig.fromYaml(yaml),
          throwsA(isA<ConfigurationException>()),
        );
      });

      test('should throw ConfigurationException for invalid prefix with uppercase', () {
        final yaml = {
          'name': 'my_theme',
          'prefix': 'MT',
        };

        expect(
          () => ThemeConfig.fromYaml(yaml),
          throwsA(isA<ConfigurationException>()),
        );
      });

      test('should parse custom font families', () {
        final yaml = {
          'name': 'my_theme',
          'prefix': 'mt',
          'font_families': ['Roboto', 'Open Sans'],
        };

        final config = ThemeConfig.fromYaml(yaml);

        expect(config.fontFamilies, contains('Roboto'));
        expect(config.fontFamilies, contains('Open Sans'));
      });

      test('should throw ConfigurationException for empty font family', () {
        final yaml = {
          'name': 'my_theme',
          'prefix': 'mt',
          'font_families': ['Roboto', ''],
        };

        expect(
          () => ThemeConfig.fromYaml(yaml),
          throwsA(isA<ConfigurationException>()),
        );
      });

      test('should parse custom font weights', () {
        final yaml = {
          'name': 'my_theme',
          'prefix': 'mt',
          'font_weights': [
            {'name': 'light', 'weight': 300},
            {'name': 'regular', 'weight': 400},
          ],
        };

        final config = ThemeConfig.fromYaml(yaml);

        expect(config.fontWeights.length, equals(2));
        expect(config.fontWeights[0].name, equals('light'));
        expect(config.fontWeights[0].weight, equals(300));
      });

      test('should throw ConfigurationException for invalid font weight value', () {
        final yaml = {
          'name': 'my_theme',
          'prefix': 'mt',
          'font_weights': [
            {'name': 'custom', 'weight': 450},
          ],
        };

        expect(
          () => ThemeConfig.fromYaml(yaml),
          throwsA(isA<ConfigurationException>()),
        );
      });

      test('should throw ConfigurationException for font weight out of range', () {
        final yaml = {
          'name': 'my_theme',
          'prefix': 'mt',
          'font_weights': [
            {'name': 'invalid', 'weight': 1000},
          ],
        };

        expect(
          () => ThemeConfig.fromYaml(yaml),
          throwsA(isA<ConfigurationException>()),
        );
      });

      test('should parse custom colors', () {
        final yaml = {
          'name': 'my_theme',
          'prefix': 'mt',
          'colors': {
            'primary': {'description': 'Primary color'},
            'secondary': {'description': 'Secondary color'},
          },
        };

        final config = ThemeConfig.fromYaml(yaml);

        expect(config.colors.length, equals(2));
        expect(config.colors[0].name, equals('primary'));
        expect(config.colors[0].description, equals('Primary color'));
      });

      test('should throw ConfigurationException for invalid color name', () {
        final yaml = {
          'name': 'my_theme',
          'prefix': 'mt',
          'colors': {
            '1invalid': {'description': 'Invalid name'},
          },
        };

        expect(
          () => ThemeConfig.fromYaml(yaml),
          throwsA(isA<ConfigurationException>()),
        );
      });

      test('should parse custom text styles', () {
        final yaml = {
          'name': 'my_theme',
          'prefix': 'mt',
          'text_styles': [
            {'name': 'heading', 'font_size': 24.0},
            {'name': 'body', 'font_size': 16.0},
          ],
        };

        final config = ThemeConfig.fromYaml(yaml);

        expect(config.textStyles.length, equals(2));
        expect(config.textStyles[0].name, equals('heading'));
        expect(config.textStyles[0].fontSize, equals(24.0));
      });

      test('should throw ConfigurationException for invalid text style name', () {
        final yaml = {
          'name': 'my_theme',
          'prefix': 'mt',
          'text_styles': [
            {'name': 'invalid-name', 'font_size': 16.0},
          ],
        };

        expect(
          () => ThemeConfig.fromYaml(yaml),
          throwsA(isA<ConfigurationException>()),
        );
      });

      test('should throw ConfigurationException for negative font size', () {
        final yaml = {
          'name': 'my_theme',
          'prefix': 'mt',
          'text_styles': [
            {'name': 'invalid', 'font_size': -10.0},
          ],
        };

        expect(
          () => ThemeConfig.fromYaml(yaml),
          throwsA(isA<ConfigurationException>()),
        );
      });
    });

    group('name conversions', () {
      test('should convert to snake_case correctly', () {
        final config = ThemeConfig.fromYaml({
          'name': 'My Theme',
          'prefix': 'mt',
        });

        expect(config.snakeCaseName, equals('my_theme'));
      });

      test('should convert to PascalCase correctly', () {
        final config = ThemeConfig.fromYaml({
          'name': 'my_theme',
          'prefix': 'mt',
        });

        expect(config.pascalCaseName, equals('MyTheme'));
      });

      test('should convert to camelCase correctly', () {
        final config = ThemeConfig.fromYaml({
          'name': 'my_theme',
          'prefix': 'mt',
        });

        expect(config.camelCaseName, equals('myTheme'));
      });
    });
  });
}
