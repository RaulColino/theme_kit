import 'package:yaml/yaml.dart';
import 'dart:io';

/// Custom exception for configuration errors
class ConfigurationException implements Exception {
  /// The error message describing what went wrong
  final String message;

  /// Creates a new configuration exception with the given [message]
  ConfigurationException(this.message);

  @override
  String toString() => 'ConfigurationException: $message';
}

/// Dart reserved keywords that cannot be used as identifiers
const _dartReservedKeywords = {
  'abstract', 'as', 'assert', 'async', 'await',
  'break', 'case', 'catch', 'class', 'const', 'continue',
  'default', 'deferred', 'do', 'dynamic',
  'else', 'enum', 'export', 'extends', 'extension', 'external',
  'factory', 'false', 'final', 'finally', 'for',
  'get', 'hide',
  'if', 'implements', 'import', 'in', 'interface', 'is',
  'late', 'library',
  'mixin',
  'new', 'null',
  'on', 'operator',
  'part',
  'required', 'rethrow', 'return',
  'set', 'show', 'static', 'super', 'switch', 'sync',
  'this', 'throw', 'true', 'try', 'typedef',
  'var', 'void',
  'while', 'with',
  'yield',
};

/// Configuration model for theme generation
class ThemeConfig {
  /// The name of the theme (e.g., "My Theme")
  final String name;
  
  /// The prefix used for generated class names (e.g., "mt" for MTTheme, MTColor, etc.)
  final String prefix;
  
  /// Optional description of the theme
  final String? description;
  
  /// List of font family names to include in the theme
  final List<String> fontFamilies;
  
  /// List of font weights with their names and numeric values
  final List<FontWeight> fontWeights;
  
  /// List of color tokens (semantic color names) in the theme
  final List<ColorToken> colors;
  
  /// List of text styles with their properties
  final List<TextStyle> textStyles;

  /// Creates a new theme configuration
  ThemeConfig({
    required this.name,
    required this.prefix,
    this.description,
    required this.fontFamilies,
    required this.fontWeights,
    required this.colors,
    required this.textStyles,
  });

  /// Load configuration from a YAML file
  static ThemeConfig fromFile(String filePath) {
    final file = File(filePath);
    if (!file.existsSync()) {
      throw ConfigurationException(
        'Configuration file not found: $filePath\n'
        'Please create a theme_kit.yaml file in your project root.\n'
        'See: https://github.com/RaulColino/theme_kit#configuration',
      );
    }

    try {
      final yamlString = file.readAsStringSync();
      if (yamlString.trim().isEmpty) {
        throw ConfigurationException(
          'Configuration file is empty: $filePath\n'
          'Please add theme configuration. See documentation for examples.',
        );
      }

      final yaml = loadYaml(yamlString);
      if (yaml == null) {
        throw ConfigurationException(
          'Failed to parse YAML file: $filePath\n'
          'The file appears to be empty or invalid.',
        );
      }

      if (yaml is! Map) {
        throw ConfigurationException(
          'Invalid configuration format in: $filePath\n'
          'Expected a YAML map with theme configuration.',
        );
      }

      return ThemeConfig.fromYaml(yaml);
    } on YamlException catch (e) {
      throw ConfigurationException(
        'Failed to parse YAML file: $filePath\n'
        'Error: ${e.message}\n'
        'Please check your YAML syntax.',
      );
    } on FileSystemException catch (e) {
      throw ConfigurationException(
        'Failed to read configuration file: $filePath\n'
        'Error: ${e.message}',
      );
    }
  }

  /// Parse configuration from YAML map
  static ThemeConfig fromYaml(Map yaml) {
    // Validate required fields
    final name = yaml['name'] as String? ?? 'my_theme';
    final prefix = yaml['prefix'] as String? ?? 'mt';

    // Validate name
    if (name.trim().isEmpty) {
      throw ConfigurationException(
        'Theme name cannot be empty.\n'
        'Please specify a valid name in your configuration.',
      );
    }

    // Validate prefix
    if (prefix.trim().isEmpty) {
      throw ConfigurationException(
        'Theme prefix cannot be empty.\n'
        'Please specify a valid prefix (2-3 characters recommended).',
      );
    }

    // Validate prefix format
    if (!RegExp(r'^[a-z][a-z0-9]*$').hasMatch(prefix)) {
      throw ConfigurationException(
        'Invalid prefix "$prefix".\n'
        'Prefix must start with a lowercase letter and contain only lowercase letters and numbers.',
      );
    }

    final description = yaml['description'] as String?;

    // Parse font families
    final fontFamiliesYaml = yaml['font_families'] as List? ?? [];
    final fontFamilies = <String>[];
    
    // Validate and convert font families
    for (final family in fontFamiliesYaml) {
      if (family is! String) {
        throw ConfigurationException(
          'Invalid font family value: $family\n'
          'Font family values must be strings.',
        );
      }
      if (family.trim().isEmpty) {
        throw ConfigurationException(
          'Font family name cannot be empty.\n'
          'Please provide valid font family names.',
        );
      }
      fontFamilies.add(family);
    }

    // If no font families specified, use default
    if (fontFamilies.isEmpty) {
      fontFamilies.add('Inter');
    }

    // Parse font weights
    final fontWeightsYaml = yaml['font_weights'] as List? ?? [];
    final fontWeights = <FontWeight>[];
    
    for (final w in fontWeightsYaml) {
      if (w is Map) {
        try {
          fontWeights.add(FontWeight.fromYaml(w));
        } catch (e) {
          throw ConfigurationException(
            'Invalid font weight configuration: $w\n'
            'Expected format: {name: "regular", weight: 400}',
          );
        }
      } else if (w is String) {
        fontWeights.add(
          FontWeight(name: w, weight: _defaultWeight(w)),
        );
      } else {
        throw ConfigurationException(
          'Invalid font weight format: $w\n'
          'Expected a string or map.',
        );
      }
    }

    // Validate font weights
    final seenWeightNames = <String>{};
    for (final weight in fontWeights) {
      if (weight.name.trim().isEmpty) {
        throw ConfigurationException(
          'Font weight name cannot be empty.',
        );
      }
      if (seenWeightNames.contains(weight.name)) {
        throw ConfigurationException(
          'Duplicate font weight name "${weight.name}".\n'
          'Font weight names must be unique.',
        );
      }
      seenWeightNames.add(weight.name);
      // Check if it's a reserved keyword
      if (_dartReservedKeywords.contains(weight.name)) {
        throw ConfigurationException(
          'Invalid font weight name "${weight.name}".\n'
          'Font weight names cannot be Dart reserved keywords.',
        );
      }
      if (weight.weight < 100 || weight.weight > 900 || weight.weight % 100 != 0) {
        throw ConfigurationException(
          'Invalid font weight "${weight.weight}" for "${weight.name}".\n'
          'Font weights must be between 100 and 900 in multiples of 100.',
        );
      }
    }

    // If no font weights specified, use defaults
    if (fontWeights.isEmpty) {
      fontWeights.addAll([
        FontWeight(name: 'regular', weight: 400),
        FontWeight(name: 'medium', weight: 500),
        FontWeight(name: 'semibold', weight: 600),
        FontWeight(name: 'bold', weight: 700),
      ]);
    }

    // Parse colors
    final colorsYaml = yaml['colors'] as Map? ?? {};
    final colors = <ColorToken>[];
    final seenColorNames = <String>{};
    
    for (final entry in colorsYaml.entries) {
      final colorName = entry.key as String;
      
      // Validate color name
      if (colorName.trim().isEmpty) {
        throw ConfigurationException(
          'Color name cannot be empty.',
        );
      }
      
      // Check for duplicates
      if (seenColorNames.contains(colorName)) {
        throw ConfigurationException(
          'Duplicate color name "$colorName".\n'
          'Color names must be unique.',
        );
      }
      seenColorNames.add(colorName);
      
      // Validate color name format (must be valid Dart identifier)
      if (!RegExp(r'^[a-zA-Z_][a-zA-Z0-9_]*$').hasMatch(colorName)) {
        throw ConfigurationException(
          'Invalid color name "$colorName".\n'
          'Color names must be valid Dart identifiers (letters, numbers, and underscores, cannot start with a number).',
        );
      }
      
      // Check if it's a reserved keyword
      if (_dartReservedKeywords.contains(colorName)) {
        throw ConfigurationException(
          'Invalid color name "$colorName".\n'
          'Color names cannot be Dart reserved keywords.',
        );
      }
      
      colors.add(ColorToken(
        name: colorName,
        description: entry.value is Map
            ? (entry.value as Map)['description'] as String?
            : null,
      ));
    }

    // If no colors specified, use defaults
    if (colors.isEmpty) {
      colors.addAll([
        ColorToken(name: 'primary'),
        ColorToken(name: 'secondary'),
        ColorToken(name: 'success'),
        ColorToken(name: 'warning'),
        ColorToken(name: 'error'),
        ColorToken(name: 'info'),
        ColorToken(name: 'background'),
        ColorToken(name: 'surface100'),
        ColorToken(name: 'surface200'),
        ColorToken(name: 'textPrimary'),
        ColorToken(name: 'textSecondary'),
        ColorToken(name: 'divider'),
        ColorToken(name: 'border'),
      ]);
    }

    // Parse text styles
    final textStylesYaml = yaml['text_styles'] as List? ?? [];
    final textStyles = <TextStyle>[];
    final seenStyleNames = <String>{};
    
    for (final ts in textStylesYaml) {
      if (ts is Map) {
        try {
          final style = TextStyle.fromYaml(ts);
          
          // Validate text style name
          if (style.name.trim().isEmpty) {
            throw ConfigurationException(
              'Text style name cannot be empty.',
            );
          }
          
          // Check for duplicates
          if (seenStyleNames.contains(style.name)) {
            throw ConfigurationException(
              'Duplicate text style name "${style.name}".\n'
              'Text style names must be unique.',
            );
          }
          seenStyleNames.add(style.name);
          
          // Validate text style name format
          if (!RegExp(r'^[a-zA-Z_][a-zA-Z0-9_]*$').hasMatch(style.name)) {
            throw ConfigurationException(
              'Invalid text style name "${style.name}".\n'
              'Text style names must be valid Dart identifiers.',
            );
          }
          
          // Check if it's a reserved keyword
          if (_dartReservedKeywords.contains(style.name)) {
            throw ConfigurationException(
              'Invalid text style name "${style.name}".\n'
              'Text style names cannot be Dart reserved keywords.',
            );
          }
          
          // Validate font size if specified
          if (style.fontSize != null && style.fontSize! <= 0) {
            throw ConfigurationException(
              'Invalid font size "${style.fontSize}" for text style "${style.name}".\n'
              'Font size must be greater than 0.',
            );
          }
          
          textStyles.add(style);
        } catch (e) {
          if (e is ConfigurationException) rethrow;
          throw ConfigurationException(
            'Invalid text style configuration: $ts\n'
            'Expected format: {name: "bodyM", font_size: 16.0}',
          );
        }
      } else if (ts is String) {
        // Check for duplicates
        if (seenStyleNames.contains(ts)) {
          throw ConfigurationException(
            'Duplicate text style name "$ts".\n'
            'Text style names must be unique.',
          );
        }
        seenStyleNames.add(ts);
        textStyles.add(TextStyle(name: ts));
      } else {
        throw ConfigurationException(
          'Invalid text style format: $ts\n'
          'Expected a string or map.',
        );
      }
    }

    // If no text styles specified, use defaults
    if (textStyles.isEmpty) {
      textStyles.addAll([
        TextStyle(name: 'displayXL', fontSize: 48.0),
        TextStyle(name: 'displayL', fontSize: 36.0),
        TextStyle(name: 'displayM', fontSize: 28.0),
        TextStyle(name: 'displayS', fontSize: 24.0),
        TextStyle(name: 'headingXL', fontSize: 32.0),
        TextStyle(name: 'headingL', fontSize: 28.0),
        TextStyle(name: 'headingM', fontSize: 24.0),
        TextStyle(name: 'headingS', fontSize: 20.0),
        TextStyle(name: 'bodyL', fontSize: 18.0),
        TextStyle(name: 'bodyM', fontSize: 16.0),
        TextStyle(name: 'bodyS', fontSize: 14.0),
        TextStyle(name: 'labelL', fontSize: 14.0),
        TextStyle(name: 'labelM', fontSize: 12.0),
        TextStyle(name: 'labelS', fontSize: 10.0),
      ]);
    }

    return ThemeConfig(
      name: name,
      prefix: prefix,
      description: description,
      fontFamilies: fontFamilies,
      fontWeights: fontWeights,
      colors: colors,
      textStyles: textStyles,
    );
  }

  /// Returns the default font weight value for common weight names
  /// 
  /// Supported names: regular (400), medium (500), semibold (600), bold (700)
  static int _defaultWeight(String name) {
    switch (name.toLowerCase()) {
      case 'regular':
        return 400;
      case 'medium':
        return 500;
      case 'semibold':
        return 600;
      case 'bold':
        return 700;
      default:
        return 400;
    }
  }

  /// Converts a theme name to snake_case format
  /// 
  /// Example: "My Theme" -> "my_theme"
  String get snakeCaseName => _toSnakeCase(name);
  
  /// Converts a theme name to PascalCase format
  /// 
  /// Example: "my_theme" -> "MyTheme"
  String get pascalCaseName => _toPascalCase(name);
  
  /// Converts a theme name to camelCase format
  /// 
  /// Example: "my_theme" -> "myTheme"
  String get camelCaseName => _toCamelCase(name);

  static String _toSnakeCase(String input) {
    input = input.trim();
    if (input.isEmpty) return 'theme';  // Fallback for empty input
    input = input.replaceAllMapped(
      RegExp(r'([a-z0-9])([A-Z])'),
      (match) => '${match.group(1)}_${match.group(2)}',
    );
    input = input.replaceAll(RegExp(r'\s+'), '_');
    input = input.replaceAll(RegExp(r'_+'), '_');  // Replace multiple underscores with single
    return input.toLowerCase();
  }

  static String _toPascalCase(String input) {
    input = input.trim();
    if (input.isEmpty) return '';
    final words = input.split(RegExp(r'[\s_-]+'));
    final result = words
        .where((word) => word.isNotEmpty)  // Filter out empty words
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join('');
    return result.isEmpty ? 'Theme' : result;  // Fallback to 'Theme' if empty
  }

  static String _toCamelCase(String input) {
    final pascal = _toPascalCase(input);
    return pascal.isEmpty ? '' : pascal[0].toLowerCase() + pascal.substring(1);
  }
}

/// Represents a font weight configuration
/// 
/// Contains the name (e.g., "regular", "bold") and the numeric weight value (100-900).
class FontWeight {
  /// The name of the font weight (e.g., "regular", "bold", "semibold")
  final String name;
  
  /// The numeric weight value (100-900, must be a multiple of 100)
  final int weight;

  /// Creates a new font weight configuration
  FontWeight({required this.name, required this.weight});

  /// Parses a font weight configuration from a YAML map
  static FontWeight fromYaml(Map yaml) {
    final name = yaml['name'];
    final weight = yaml['weight'];
    
    if (name == null || name is! String) {
      throw ConfigurationException(
        'Font weight must have a "name" field of type string.',
      );
    }
    
    if (weight == null || weight is! num) {
      throw ConfigurationException(
        'Font weight must have a "weight" field of type number.',
      );
    }
    
    return FontWeight(
      name: name,
      weight: weight.toInt(),
    );
  }
}

/// Represents a color token in the theme
/// 
/// A color token defines a semantic color name (e.g., "primary", "background")
/// that will be available in the generated theme class.
class ColorToken {
  /// The name of the color token (must be a valid Dart identifier)
  final String name;
  
  /// Optional description of what this color is used for
  final String? description;

  /// Creates a new color token
  ColorToken({required this.name, this.description});
}

/// Represents a text style configuration
/// 
/// Defines a named text style (e.g., "bodyM", "headingL") with optional
/// font size and weight specifications.
class TextStyle {
  /// The name of the text style (must be a valid Dart identifier)
  final String name;
  
  /// The font size in logical pixels (must be positive if specified)
  final double? fontSize;
  
  /// The font weight name (e.g., "regular", "bold")
  final String? fontWeight;

  /// Creates a new text style configuration
  TextStyle({required this.name, this.fontSize, this.fontWeight});

  /// Parses a text style configuration from a YAML map
  static TextStyle fromYaml(Map yaml) {
    final name = yaml['name'];
    
    if (name == null || name is! String) {
      throw ConfigurationException(
        'Text style must have a "name" field of type string.',
      );
    }
    
    final fontSize = yaml['font_size'];
    if (fontSize != null && fontSize is! num) {
      throw ConfigurationException(
        'Text style "$name" has invalid font_size. Must be a number.',
      );
    }
    
    final fontWeight = yaml['font_weight'];
    if (fontWeight != null && fontWeight is! String) {
      throw ConfigurationException(
        'Text style "$name" has invalid font_weight. Must be a string.',
      );
    }
    
    return TextStyle(
      name: name,
      fontSize: fontSize?.toDouble(),
      fontWeight: fontWeight,
    );
  }
}
