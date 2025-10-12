import 'dart:io';
import 'package:path/path.dart' as path;
import '../config/theme_config.dart';
import '../templates/font_family_template.dart';
import '../templates/font_weight_template.dart';
import '../templates/color_template.dart';
import '../templates/theme_class_template.dart';
import '../templates/text_widget_template.dart';
import '../templates/main_theme_template.dart';

/// Main theme generator class
class ThemeGenerator {
  final String configPath;
  final String outputDir;

  ThemeGenerator({
    required this.configPath,
    required this.outputDir,
  });

  Future<void> generate() async {
    // Load configuration
    print('📖 Loading configuration...');
    late ThemeConfig config;
    
    try {
      config = ThemeConfig.fromFile(configPath);
    } catch (e) {
      print('');
      print('❌ Failed to load configuration:');
      print(e.toString());
      rethrow;
    }
    
    print('   Theme: ${config.name}');
    print('   Prefix: ${config.prefix}');

    // Create output directories
    print('📁 Creating output directories...');
    final outputPath = path.normalize(outputDir);
    final colorsDir = path.join(outputPath, 'src', 'colors');
    final typographyDir = path.join(outputPath, 'src', 'typography');
    final themeDir = path.join(outputPath, 'src', 'theme');

    try {
      await Directory(colorsDir).create(recursive: true);
      await Directory(typographyDir).create(recursive: true);
      await Directory(themeDir).create(recursive: true);
    } catch (e) {
      print('');
      print('❌ Failed to create output directories:');
      print('Error: $e');
      print('Make sure you have write permissions to: $outputDir');
      rethrow;
    }

    // Generate files
    print('✍️  Generating theme files...');

    // Typography files
    await _writeFile(
      path.join(typographyDir, '${config.prefix}_font_family.dart'),
      FontFamilyTemplate.generate(config),
    );
    print('   ✓ ${config.prefix}_font_family.dart');

    await _writeFile(
      path.join(typographyDir, '${config.prefix}_font_weight.dart'),
      FontWeightTemplate.generate(config),
    );
    print('   ✓ ${config.prefix}_font_weight.dart');

    await _writeFile(
      path.join(typographyDir, '${config.prefix}_text.dart'),
      TextWidgetTemplate.generate(config),
    );
    print('   ✓ ${config.prefix}_text.dart');

    // Color files
    await _writeFile(
      path.join(colorsDir, '${config.prefix}_theme.dart'),
      ThemeClassTemplate.generate(config),
    );
    print('   ✓ ${config.prefix}_theme.dart');

    await _writeFile(
      path.join(colorsDir, '${config.prefix}_color.dart'),
      ColorTemplate.generate(config),
    );
    print('   ✓ ${config.prefix}_color.dart');

    // Main theme file
    await _writeFile(
      path.join(themeDir, '${config.snakeCaseName}.dart'),
      MainThemeTemplate.generate(config),
    );
    print('   ✓ ${config.snakeCaseName}.dart');

    // Main export file
    await _writeFile(
      path.join(outputPath, '${config.snakeCaseName}.dart'),
      _generateMainExport(config),
    );
    print('   ✓ ${config.snakeCaseName}.dart (main export)');

    // Generate usage documentation
    await _writeFile(
      path.join(outputPath, 'USAGE.md'),
      _generateUsageDoc(config),
    );
    print('   ✓ USAGE.md');
  }

  Future<void> _writeFile(String filePath, String content) async {
    try {
      final file = File(filePath);
      await file.writeAsString(content);
    } catch (e) {
      print('');
      print('❌ Failed to write file: $filePath');
      print('Error: $e');
      rethrow;
    }
  }

  String _generateMainExport(ThemeConfig config) {
    return '''
library ${config.snakeCaseName};

// Colors
export 'src/colors/${config.prefix}_color.dart';
export 'src/colors/${config.prefix}_theme.dart';

// Typography
export 'src/typography/${config.prefix}_font_family.dart';
export 'src/typography/${config.prefix}_font_weight.dart';
export 'src/typography/${config.prefix}_text.dart';

// Theme
export 'src/theme/${config.snakeCaseName}.dart';
''';
  }

  String _generateUsageDoc(ThemeConfig config) {
    final className = config.pascalCaseName;
    final themeClass = '${config.prefix.toUpperCase()}Theme';
    final colorClass = '${config.prefix.toUpperCase()}Color';
    final textClass = '${config.prefix.toUpperCase()}Text';

    return '''
# ${config.name} - Usage Guide

## Installation

Add the generated theme to your `pubspec.yaml`:

\`\`\`yaml
dependencies:
  ${config.snakeCaseName}:
    path: $outputDir
\`\`\`

## Basic Usage

### 1. Define your theme colors

\`\`\`dart
import 'package:flutter/material.dart';
import 'package:${config.snakeCaseName}/${config.snakeCaseName}.dart';

final lightTheme = $themeClass(
  primary: Colors.blue,
  secondary: Colors.blueGrey[200],
  background: Colors.white,
  textPrimary: Colors.black,
  // ... other colors
);

final darkTheme = $themeClass(
  primary: Colors.blue,
  secondary: Colors.blueGrey[700],
  background: Colors.black,
  textPrimary: Colors.white,
  // ... other colors
);
\`\`\`

### 2. Wrap your app with the theme

\`\`\`dart
void main() {
  runApp(
    $className(
      lightTheme: lightTheme,
      darkTheme: darkTheme,
      child: MaterialApp(
        home: MyHomePage(),
      ),
    ),
  );
}
\`\`\`

### 3. Use theme colors and text styles

\`\`\`dart
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: $colorClass.background,
      body: Column(
        children: [
          $textClass.displayXL("Hello World").styles(
            color: $colorClass.primary,
          ),
          $textClass.bodyM("This is body text").styles(
            color: $colorClass.textPrimary,
          ),
        ],
      ),
    );
  }
}
\`\`\`

### 4. Switch between light and dark themes

\`\`\`dart
ElevatedButton(
  onPressed: () {
    $className.setLightTheme();
  },
  child: Text('Light Theme'),
),

ElevatedButton(
  onPressed: () {
    $className.setDarkTheme();
  },
  child: Text('Dark Theme'),
),
\`\`\`

## Available Text Styles

${config.textStyles.map((style) => '- `$textClass.${style.name}("text")`').join('\n')}

## Available Colors

${config.colors.map((color) => '- `$colorClass.${color.name}`').join('\n')}

## Customizing Text

You can customize any text style using the `.styles()` method:

\`\`\`dart
$textClass.bodyM("Custom text").styles(
  color: Colors.red,
  fontSize: 20,
  fontWeight: ${config.prefix.toUpperCase()}FontWeight.bold,
)
\`\`\`
''';
  }
}
