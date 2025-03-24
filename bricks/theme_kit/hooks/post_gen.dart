import 'dart:io';
import 'package:mason/mason.dart';

// This post-generation hook moves the generated theme folder into the
// packages folder if the user wanted to create the theme as a package. E.g.:
// mason make theme_kit --theme_name my_theme --create_as_package true
void run(HookContext context) {
  final createAsPackage = context.vars['create_as_package'] as bool? ?? false;
  final themeName = toSnakeCase(context.vars['theme_name'] as String);
  final provisionalThemeName = 'provisionaltkmasonpkgname7842c79nd29n6dk5c31f5';
  final currentDir = Directory.current;
  final provisionalThemeDir = Directory('${currentDir.path}/$provisionalThemeName');

  if (createAsPackage) {
    final packagesDir = Directory('${currentDir.path}/packages');
    if (!packagesDir.existsSync()) {
      stdout.writeln('Creating "packages" directory...');
      packagesDir.createSync();
    }

    // Assuming the brick generates a folder with the theme
    final generatedThemeDir = Directory('${currentDir.path}/$themeName');
    if (generatedThemeDir.existsSync()) {
      try {
        // Move the generated theme folder to the packages directory
        final newThemePath = '${packagesDir.path}/$themeName';
        generatedThemeDir.renameSync(newThemePath);
        stdout.writeln('Moved theme package to: $newThemePath');

        // Reverse the provisional theme folder name back to the original name if it exists

        if (provisionalThemeDir.existsSync()) {
          provisionalThemeDir.renameSync('${currentDir.path}/$themeName');
          // stdout.writeln('Reverted existing theme folder name back to: $themeName');
        }

        // Now run "flutter create --template=package my_theme" inside the packages folder
        final process = Process.runSync('flutter', [
          'create',
          '--template=package',
          themeName,
        ], workingDirectory: packagesDir.path);

        // And delete the dummy file generated in the test folder (e.g.: theme_kit_test.dart)
        final testFile = File('$newThemePath/test/${themeName}_test.dart');
        if (testFile.existsSync()) {
          testFile.deleteSync();
        }
      } catch (e) {
        stdout.writeln(
          'Error creating the theme package: a package with the same name already exists in the packages folder.',
        );
        stdout.writeln(
          'To create a new theme package with the same name, please delete the existing package first.',
        );
        // Clean leftover provisional theme folder and its contents
        if (provisionalThemeDir.existsSync()) {
          provisionalThemeDir.deleteSync(recursive: true);
        }
      }
    } else {
      stdout.writeln('Warning: Generated theme folder "$themeName" not found.');
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
