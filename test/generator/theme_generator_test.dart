import 'package:flutter_test/flutter_test.dart';
import 'package:theme_kit/src/generator/theme_generator.dart';
import 'dart:io';

void main() {
  group('ThemeGenerator', () {
    late Directory tempDir;
    late String configPath;
    late String outputDir;

    setUp(() {
      // Create temporary directory for tests
      tempDir = Directory.systemTemp.createTempSync('theme_kit_test_');
      configPath = '${tempDir.path}/theme_kit.yaml';
      outputDir = '${tempDir.path}/output';
    });

    tearDown(() {
      // Clean up
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('should generate all required files', () async {
      // Create config file
      File(configPath).writeAsStringSync('''
name: test_theme
prefix: tt
font_families:
  - Inter
colors:
  primary:
    description: Primary color
text_styles:
  - name: bodyM
    font_size: 16.0
''');

      final generator = ThemeGenerator(
        configPath: configPath,
        outputDir: outputDir,
      );

      await generator.generate();

      // Check that all files were generated
      expect(File('$outputDir/src/typography/tt_font_family.dart').existsSync(), isTrue);
      expect(File('$outputDir/src/typography/tt_font_weight.dart').existsSync(), isTrue);
      expect(File('$outputDir/src/typography/tt_text.dart').existsSync(), isTrue);
      expect(File('$outputDir/src/colors/tt_theme.dart').existsSync(), isTrue);
      expect(File('$outputDir/src/colors/tt_color.dart').existsSync(), isTrue);
      expect(File('$outputDir/src/theme/test_theme.dart').existsSync(), isTrue);
      expect(File('$outputDir/test_theme.dart').existsSync(), isTrue);
      expect(File('$outputDir/USAGE.md').existsSync(), isTrue);
    });

    test('should create output directories if they do not exist', () async {
      File(configPath).writeAsStringSync('''
name: test_theme
prefix: tt
''');

      expect(Directory(outputDir).existsSync(), isFalse);

      final generator = ThemeGenerator(
        configPath: configPath,
        outputDir: outputDir,
      );

      await generator.generate();

      expect(Directory(outputDir).existsSync(), isTrue);
      expect(Directory('$outputDir/src/colors').existsSync(), isTrue);
      expect(Directory('$outputDir/src/typography').existsSync(), isTrue);
      expect(Directory('$outputDir/src/theme').existsSync(), isTrue);
    });

    test('should generate valid Dart files', () async {
      File(configPath).writeAsStringSync('''
name: test_theme
prefix: tt
font_families:
  - Inter
colors:
  primary:
    description: Primary color
text_styles:
  - name: bodyM
    font_size: 16.0
''');

      final generator = ThemeGenerator(
        configPath: configPath,
        outputDir: outputDir,
      );

      await generator.generate();

      // Check that generated files contain expected content
      final fontFamilyFile = File('$outputDir/src/typography/tt_font_family.dart');
      final fontFamilyContent = fontFamilyFile.readAsStringSync();
      expect(fontFamilyContent, contains('class TTFontFamily'));

      final colorFile = File('$outputDir/src/colors/tt_color.dart');
      final colorContent = colorFile.readAsStringSync();
      expect(colorContent, contains('class TTColor'));
      expect(colorContent, contains('static Color? get primary'));

      final textFile = File('$outputDir/src/typography/tt_text.dart');
      final textContent = textFile.readAsStringSync();
      expect(textContent, contains('class TTText extends Text'));
      expect(textContent, contains('static TTText bodyM(String data)'));
    });

    test('should generate main export file with all exports', () async {
      File(configPath).writeAsStringSync('''
name: test_theme
prefix: tt
''');

      final generator = ThemeGenerator(
        configPath: configPath,
        outputDir: outputDir,
      );

      await generator.generate();

      final mainExportFile = File('$outputDir/test_theme.dart');
      final content = mainExportFile.readAsStringSync();

      expect(content, contains('library test_theme;'));
      expect(content, contains("export 'src/colors/tt_color.dart';"));
      expect(content, contains("export 'src/colors/tt_theme.dart';"));
      expect(content, contains("export 'src/typography/tt_font_family.dart';"));
      expect(content, contains("export 'src/typography/tt_font_weight.dart';"));
      expect(content, contains("export 'src/typography/tt_text.dart';"));
      expect(content, contains("export 'src/theme/test_theme.dart';"));
    });

    test('should generate USAGE.md with documentation', () async {
      File(configPath).writeAsStringSync('''
name: test_theme
prefix: tt
''');

      final generator = ThemeGenerator(
        configPath: configPath,
        outputDir: outputDir,
      );

      await generator.generate();

      final usageFile = File('$outputDir/USAGE.md');
      final content = usageFile.readAsStringSync();

      expect(content, contains('# test_theme - Usage Guide'));
      expect(content, contains('## Installation'));
      expect(content, contains('## Basic Usage'));
      expect(content, contains('TTTheme'));
      expect(content, contains('TTColor'));
      expect(content, contains('TTText'));
    });

    test('should throw error for missing config file', () async {
      final generator = ThemeGenerator(
        configPath: 'nonexistent.yaml',
        outputDir: outputDir,
      );

      expect(
        () => generator.generate(),
        throwsA(isA<Exception>()),
      );
    });

    test('should handle custom output directory path', () async {
      final customOutput = '${tempDir.path}/custom/nested/path';
      File(configPath).writeAsStringSync('''
name: test_theme
prefix: tt
''');

      final generator = ThemeGenerator(
        configPath: configPath,
        outputDir: customOutput,
      );

      await generator.generate();

      expect(Directory(customOutput).existsSync(), isTrue);
      expect(File('$customOutput/test_theme.dart').existsSync(), isTrue);
    });

    test('should handle theme names with spaces', () async {
      File(configPath).writeAsStringSync('''
name: My Theme
prefix: mt
''');

      final generator = ThemeGenerator(
        configPath: configPath,
        outputDir: outputDir,
      );

      await generator.generate();

      // Should convert to snake_case for files
      expect(File('$outputDir/my_theme.dart').existsSync(), isTrue);
      expect(File('$outputDir/src/theme/my_theme.dart').existsSync(), isTrue);
    });

    test('should preserve custom color names', () async {
      File(configPath).writeAsStringSync('''
name: test_theme
prefix: tt
colors:
  customPrimary:
    description: Custom primary color
  myBrandColor:
    description: Brand color
''');

      final generator = ThemeGenerator(
        configPath: configPath,
        outputDir: outputDir,
      );

      await generator.generate();

      final colorFile = File('$outputDir/src/colors/tt_color.dart');
      final content = colorFile.readAsStringSync();

      expect(content, contains('static Color? get customPrimary'));
      expect(content, contains('static Color? get myBrandColor'));
      expect(content, contains('/// Custom primary color'));
      expect(content, contains('/// Brand color'));
    });
  });
}
