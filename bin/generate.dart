#!/usr/bin/env dart

import 'dart:io';
import 'package:args/args.dart';
import 'package:theme_kit/src/generator/theme_generator.dart';

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption('config',
        abbr: 'c',
        defaultsTo: 'theme_kit.yaml',
        help: 'Path to the theme configuration file')
    ..addOption('output',
        abbr: 'o',
        defaultsTo: 'lib/theme',
        help: 'Output directory for generated theme files')
    ..addFlag('help',
        abbr: 'h',
        negatable: false,
        help: 'Display this help message');

  try {
    final results = parser.parse(arguments);

    if (results['help'] as bool) {
      _printUsage(parser);
      return;
    }

    final configPath = results['config'] as String;
    final outputDir = results['output'] as String;

    // Validate arguments
    if (configPath.isEmpty) {
      print('❌ Error: Config path cannot be empty');
      print('');
      _printUsage(parser);
      exit(1);
    }

    if (outputDir.isEmpty) {
      print('❌ Error: Output directory cannot be empty');
      print('');
      _printUsage(parser);
      exit(1);
    }

    print('🎨 Theme Kit v3.0.0');
    print('Generating theme from: $configPath');
    print('Output directory: $outputDir');
    print('');

    final generator = ThemeGenerator(
      configPath: configPath,
      outputDir: outputDir,
    );

    await generator.generate();

    print('');
    print('✅ Theme generated successfully!');
    print('');
    print('Next steps:');
    print('1. Import your theme in your app');
    print('2. Use the generated theme classes');
    print('3. Check the USAGE.md file in the output directory for examples');
    print('');
  } on FormatException catch (e) {
    print('❌ Error: Invalid command line arguments');
    print(e.message);
    print('');
    _printUsage(parser);
    exit(1);
  } catch (e) {
    print('');
    print('❌ Error: $e');
    print('');
    if (e.toString().contains('ConfigurationException')) {
      print('💡 Tip: Check your theme_kit.yaml file for errors.');
      print('See: https://github.com/RaulColino/theme_kit#configuration');
    }
    exit(1);
  }
}

void _printUsage(ArgParser parser) {
  print('Usage: dart run theme_kit:generate [options]');
  print('');
  print('Options:');
  print(parser.usage);
  print('');
  print('Example:');
  print('  dart run theme_kit:generate');
  print('  dart run theme_kit:generate --config my_theme.yaml --output lib/gen');
}
