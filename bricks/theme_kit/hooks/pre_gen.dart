import 'dart:io';
import 'package:mason/mason.dart';

// This pre-generation hook checks if the user wants to create the theme as a package
// and verifies that the brick is being run from the project root directory. Then it
void run(HookContext context) {
  final createAsPackage = context.vars['create_as_package'] as bool? ?? false;
  final themeName = toSnakeCase(context.vars['theme_name'] as String);
  final prefix = context.vars['prefix'] as String;

  if (createAsPackage) {
    // Check if we have a folder with the theme name already
    final currentDir = Directory.current;
    final themeDir = Directory('${currentDir.path}/$themeName');
    if (themeDir.existsSync()) {
      // rename the existing theme folder to a provisional name
      final provisionalThemeName = 'provisionaltkmasonpkgname7842c79nd29n6dk5c31f5';
      themeDir.renameSync('${currentDir.path}/$provisionalThemeName');
      // stdout.writeln('Renamed existing theme folder to: $provisionalThemeName');
    }
    // Check if we have a pubspec.yaml to ensure we're at the project root.
    final pubspecFile = File('pubspec.yaml');
    if (!pubspecFile.existsSync()) {
      stdout.writeln('Warning: It looks like you are not in the project root directory.');
      stdout.write('Do you still want to continue? (y/N): ');
      final answer = stdin.readLineSync()?.toLowerCase();
      if (answer != 'y' && answer != 'yes') {
        stdout.writeln('Aborting theme generation...');
        exit(1);
      }
    }
  }
}

String toSnakeCase(String input) {
  // Trim any whitespace
  input = input.trim();
  // Insert underscores between lowercase-to-uppercase boundaries
  input = input.replaceAllMapped(RegExp(r'([a-z0-9])([A-Z])'), (match) {
    return '${match.group(1)}_${match.group(2)}';
  });
  // Replace all spaces with underscores
  input = input.replaceAll(RegExp(r'\s+'), '_');
  // Convert everything to lowercase
  return input.toLowerCase();
}

