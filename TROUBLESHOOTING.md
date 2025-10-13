# Theme Kit Troubleshooting Guide

This guide helps you resolve common issues when using Theme Kit 3.0.

## Table of Contents

- [Installation Issues](#installation-issues)
- [Configuration Errors](#configuration-errors)
- [Generation Errors](#generation-errors)
- [Runtime Errors](#runtime-errors)
- [IDE Issues](#ide-issues)

## Installation Issues

### Package not found

**Problem:** `dart run theme_kit:generate` fails with "Could not find package"

**Solution:**
1. Make sure you've added theme_kit to your `pubspec.yaml`:
   ```yaml
   dev_dependencies:
     theme_kit: ^3.0.0
   ```
2. Run `flutter pub get` or `dart pub get`
3. Verify the package is in your `.dart_tool/package_config.json`

### Wrong version installed

**Problem:** Using features not available in your version

**Solution:**
1. Check your installed version: `flutter pub deps | grep theme_kit`
2. Update to the latest version in `pubspec.yaml`
3. Run `flutter pub upgrade theme_kit`

## Configuration Errors

### Configuration file not found

**Error:** `Configuration file not found: theme_kit.yaml`

**Solution:**
1. Create a `theme_kit.yaml` file in your project root
2. Or specify a custom path: `dart run theme_kit:generate --config path/to/config.yaml`

### Invalid YAML syntax

**Error:** `Failed to parse YAML file`

**Solution:**
1. Check your YAML indentation (use spaces, not tabs)
2. Validate your YAML using an online validator
3. Make sure keys and values are properly formatted:
   ```yaml
   name: my_theme  # Correct
   prefix: mt      # Correct
   ```

### Empty configuration file

**Error:** `Configuration file is empty`

**Solution:**
Add at least the required fields:
```yaml
name: my_theme
prefix: mt
```

### Invalid prefix format

**Error:** `Invalid prefix "MT". Prefix must start with a lowercase letter`

**Solution:**
Use lowercase letters for the prefix:
```yaml
prefix: mt  # Correct
# prefix: MT  # Wrong - no uppercase
# prefix: 1mt # Wrong - cannot start with number
```

### Invalid color/style names

**Error:** `Invalid color name "1color". Color names must be valid Dart identifiers`

**Solution:**
Use valid Dart identifier names:
```yaml
colors:
  primary:        # Correct
    description: Primary color
  color1:         # Correct
    description: Color 1
  # 1color:       # Wrong - starts with number
  # my-color:     # Wrong - contains hyphen
```

### Invalid font weight

**Error:** `Invalid font weight "450". Font weights must be between 100 and 900 in multiples of 100`

**Solution:**
Use valid font weights (100, 200, 300, 400, 500, 600, 700, 800, 900):
```yaml
font_weights:
  - name: regular
    weight: 400  # Correct
  # - name: custom
  #   weight: 450  # Wrong - not a multiple of 100
```

### Negative font size

**Error:** `Invalid font size "-10" for text style`

**Solution:**
Use positive font sizes:
```yaml
text_styles:
  - name: bodyM
    font_size: 16.0  # Correct
  # - name: invalid
  #   font_size: -10.0  # Wrong - negative value
```

### Duplicate names

**Error:** `Duplicate color name "primary"` or `Duplicate text style name "heading"` or `Duplicate font weight name "regular"`

**Solution:**
Ensure all names are unique within their category:
```yaml
colors:
  primary:    # Correct
    description: Primary color
  secondary:  # Correct
    description: Secondary color
  # primary:  # Wrong - duplicate name

font_weights:
  - name: regular
    weight: 400
  - name: bold
    weight: 700
  # - name: regular  # Wrong - duplicate name
  #   weight: 500

text_styles:
  - name: heading
    font_size: 24.0
  - name: body
    font_size: 16.0
  # - name: heading  # Wrong - duplicate name
  #   font_size: 20.0
```

### Invalid font family type

**Error:** `Invalid font family value: 123. Font family values must be strings`

**Solution:**
Ensure all font family values are strings:
```yaml
font_families:
  - Inter     # Correct
  - Roboto    # Correct
  # - 123     # Wrong - not a string
```

## Generation Errors

### Permission denied

**Error:** `Failed to create output directories: Permission denied`

**Solution:**
1. Check file permissions on the output directory
2. Make sure you have write access to the target location
3. Try a different output directory: `dart run theme_kit:generate --output lib/gen`

### Directory already exists

**Problem:** Generated files already exist and you want to regenerate

**Solution:**
1. Delete the existing output directory
2. Run the generator again
3. Or use a different output directory

### Failed to write file

**Error:** `Failed to write file: Access denied`

**Solution:**
1. Close any files open in your IDE
2. Check if the file is read-only
3. Make sure you have write permissions

## Runtime Errors

### Import errors

**Error:** `The method 'generate' isn't defined for the class`

**Solution:**
1. Make sure you've run the generator: `dart run theme_kit:generate`
2. Check that files were generated in the correct location
3. Verify your import paths match the generated location:
   ```dart
   import 'theme/my_theme.dart';  // Adjust path as needed
   ```

### Null pointer exception

**Error:** `Null check operator used on a null value`

**Solution:**
1. Make sure you've initialized the theme:
   ```dart
   MyTheme(
     lightTheme: myLightTheme,
     darkTheme: myDarkTheme,
     child: MaterialApp(...),
   )
   ```
2. Verify all required colors are provided in your theme instance

### Color is null

**Problem:** `MTColor.primary` returns null

**Solution:**
1. Make sure you've wrapped your app with the theme widget
2. Initialize the theme before using colors:
   ```dart
   final theme = MTTheme(primary: Colors.blue, ...);
   MyTheme(lightTheme: theme, child: ...);
   ```

## IDE Issues

### Generated files not showing in IDE

**Problem:** Files generated but not visible in IDE

**Solution:**
1. Refresh your IDE's file tree
2. Run `flutter pub get` to update package cache
3. Restart your IDE
4. Check the actual file system to verify files exist

### Import suggestions not working

**Problem:** IDE doesn't suggest imports for generated classes

**Solution:**
1. Run `flutter pub get`
2. Restart Dart Analysis Server (Command Palette → "Dart: Restart Analysis Server")
3. Restart your IDE

### Syntax errors in generated code

**Problem:** IDE shows errors in generated files

**Solution:**
1. This should not happen - generated code should be valid
2. Check your configuration for invalid names or values
3. Regenerate the theme
4. If issue persists, please report it as a bug

## Still Having Issues?

If your problem isn't covered here:

1. Check the [GitHub Issues](https://github.com/RaulColino/theme_kit/issues) for similar problems
2. Review the [README.md](README.md) for complete documentation
3. Check the [FAQ](README.md#faq) section
4. Open a new issue with:
   - Your `theme_kit.yaml` configuration
   - The full error message
   - Your Flutter/Dart version
   - Steps to reproduce the problem

## Tips for Success

1. **Start simple:** Begin with a minimal configuration and add complexity gradually
2. **Validate YAML:** Use an online YAML validator to check syntax
3. **Use valid names:** Stick to camelCase for colors and text styles
4. **Check permissions:** Ensure you can write to the output directory
5. **Keep it updated:** Use the latest version of theme_kit
6. **Read error messages:** They usually point directly to the problem
7. **Check examples:** Look at the example project for reference

## Common Patterns

### Regenerating theme after changes

```bash
# 1. Update your theme_kit.yaml
# 2. Regenerate
dart run theme_kit:generate
# 3. Restart your app (hot restart may not be enough)
```

### Using in multiple packages

```bash
# Generate in a shared package
cd packages/my_theme
dart run theme_kit:generate --output lib

# Then use in your app
# pubspec.yaml
dependencies:
  my_theme:
    path: packages/my_theme
```

### CI/CD Integration

```yaml
# .github/workflows/build.yml
- name: Generate theme
  run: dart run theme_kit:generate
  
- name: Verify generated files
  run: |
    if [ ! -f "lib/theme/my_theme.dart" ]; then
      echo "Theme generation failed"
      exit 1
    fi
```
