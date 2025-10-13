# Theme Kit

Create themes you'll enjoy using 🎨.

**Version 3.0** - Complete rewrite with CLI-based code generation (no Mason bricks required!)

> 🎉 **New to Theme Kit 3.0?** Check out [What's New](WHATS_NEW.md) for a complete overview of changes.
> 
> 🚀 **Want to get started quickly?** See the [Quick Start Guide](QUICKSTART.md).
>
> 📚 **Need detailed API documentation?** Check the [API Reference](API.md).
>
> 🔄 **Migrating from 2.x?** Read the [Migration Guide](MIGRATION.md).

## Features ✨

- ✅ Easy to set dark and light themes.
- ✅ Use your own custom theme tokens on top of Material Design.
- ✅ Import your theme and seamlessly apply it to Material components.
- ✅ Enjoy autocompletion for every theme token.
- ✅ Fully customizable, the generated code is editable and yours!
- ✅ Includes definition of colors, text styles, font families and font weights.
- ✅ No dependencies required in your generated theme.
- ✅ No build runner needed 😉.
- ✅ Simple YAML configuration.
- ✅ CLI-based code generation (like flutter_flavorizr).

## Getting Started 🚀

### Installation

Add `theme_kit` as a dev dependency in your Flutter project:

```bash
flutter pub add --dev theme_kit
```

Or add it manually to your `pubspec.yaml`:

```yaml
dev_dependencies:
  theme_kit: ^3.0.0
```

### Configuration

Create a `theme_kit.yaml` file in the root of your project:

```yaml
# Theme name (will be converted to snake_case for file names)
name: my_theme

# Prefix for generated classes (recommended 2-3 characters)
prefix: mt

# Optional description
description: My custom theme for Flutter app

# Font families to include in the theme
font_families:
  - Inter
  - Poppins

# Font weights to include
font_weights:
  - name: regular
    weight: 400
  - name: medium
    weight: 500
  - name: semibold
    weight: 600
  - name: bold
    weight: 700

# Color tokens for the theme
colors:
  primary:
    description: Primary brand color
  secondary:
    description: Secondary brand color
  success:
    description: Success state color
  warning:
    description: Warning state color
  error:
    description: Error state color
  background:
    description: Background color
  textPrimary:
    description: Primary text color
  textSecondary:
    description: Secondary text color

# Text styles with default font sizes
text_styles:
  - name: displayXL
    font_size: 48.0
  - name: displayL
    font_size: 36.0
  - name: bodyM
    font_size: 16.0
  - name: bodyS
    font_size: 14.0
```

### Generate Your Theme

Run the generator:

```bash
dart run theme_kit:generate
```

Or with custom options:

```bash
dart run theme_kit:generate --config my_config.yaml --output lib/theme
```

### Use Your Theme

1. **Define your theme colors:**

```dart
import 'package:flutter/material.dart';
import 'package:my_app/theme/my_theme.dart';

final lightTheme = MTTheme(
  primary: Colors.blue,
  secondary: Colors.blueGrey[200],
  success: Colors.green,
  warning: Colors.yellow,
  error: Colors.red,
  background: Colors.white,
  textPrimary: Colors.black,
  textSecondary: Colors.grey,
);

final darkTheme = MTTheme(
  primary: Colors.blue,
  secondary: Colors.blueGrey[700],
  success: Colors.green,
  warning: Colors.yellow,
  error: Colors.red,
  background: Colors.black,
  textPrimary: Colors.white,
  textSecondary: Colors.grey[400],
);
```

2. **Wrap your app with the theme:**

```dart
void main() {
  runApp(
    MyTheme(
      lightTheme: lightTheme,
      darkTheme: darkTheme,
      child: MaterialApp(
        title: 'My App',
        home: HomePage(),
      ),
    ),
  );
}
```

3. **Use theme colors and text styles:**

```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MTColor.background,
      body: Column(
        children: [
          MTText.displayXL("Hello World").styles(
            color: MTColor.primary,
          ),
          MTText.bodyM("This is body text").styles(
            color: MTColor.textPrimary,
          ),
          ElevatedButton(
            child: MTText.bodyM("Switch to Dark Theme"),
            onPressed: () {
              MyTheme.setDarkTheme();
            },
          ),
        ],
      ),
    );
  }
}
```

## Generated Files 📁

The generator creates the following file structure (using `my_theme` and `mt` prefix as example):

```plaintext
lib/theme/
├── my_theme.dart              # Main export file
├── USAGE.md                   # Usage documentation
└── src/
    ├── colors/
    │   ├── mt_color.dart      # Color token accessors
    │   └── mt_theme.dart      # Theme configuration class
    ├── typography/
    │   ├── mt_font_family.dart # Font family constants
    │   ├── mt_font_weight.dart # Font weight constants
    │   └── mt_text.dart        # Text widget with styles
    └── theme/
        └── my_theme.dart       # Main theme InheritedWidget
```

## CLI Options

```
Usage: dart run theme_kit:generate [options]

Options:
  -c, --config    Path to the theme configuration file
                  (defaults to "theme_kit.yaml")
  -o, --output    Output directory for generated theme files
                  (defaults to "lib/theme")
  -h, --help      Display this help message

Example:
  dart run theme_kit:generate
  dart run theme_kit:generate --config my_theme.yaml --output lib/gen
```

## Configuration Reference

### Basic Configuration

```yaml
# Required: Name of your theme
name: my_theme

# Required: Prefix for generated classes (2-3 characters recommended)
prefix: mt

# Optional: Description of your theme
description: My custom app theme
```

### Font Configuration

```yaml
# Define available font families
font_families:
  - Inter
  - Poppins
  - Roboto

# Define font weights with their numeric values
font_weights:
  - name: regular
    weight: 400
  - name: medium
    weight: 500
  - name: semibold
    weight: 600
  - name: bold
    weight: 700
```

### Color Configuration

```yaml
colors:
  primary:
    description: Primary brand color
  secondary:
    description: Secondary brand color
  # Add as many colors as needed
  customColor:
    description: My custom color token
```

### Text Style Configuration

```yaml
text_styles:
  - name: displayXL
    font_size: 48.0
  - name: bodyM
    font_size: 16.0
  # Add as many text styles as needed
```

## Advanced Usage

### Custom Output Directory

Generate theme files in a custom location:

```bash
dart run theme_kit:generate --output packages/my_theme/lib
```

### Multiple Configurations

You can maintain different theme configurations for different projects or variants:

```bash
dart run theme_kit:generate --config themes/light_theme.yaml --output lib/themes/light
dart run theme_kit:generate --config themes/dark_theme.yaml --output lib/themes/dark
```

### Using in Package Projects

Theme Kit works great for creating reusable theme packages:

1. Create a new package:
```bash
flutter create --template=package my_company_theme
```

2. Add theme_kit as dev dependency
3. Create `theme_kit.yaml` in package root
4. Generate theme with `--output lib`
5. Publish your theme package

## Migration from 2.x

If you're upgrading from theme_kit 2.x (Mason bricks), here are the key changes:

### What Changed

| 2.x (Mason) | 3.0 (CLI) |
|-------------|-----------|
| `mason make theme_kit` | `dart run theme_kit:generate` |
| Mason brick dependency | Dev dependency only |
| Interactive prompts | YAML configuration |
| Creates package structure | Generates files only |
| Requires Mason installed | Works with dart/flutter only |

### Migration Steps

1. **Remove Mason dependencies**:
   ```bash
   # Remove from pubspec.yaml
   # No need for mason_cli anymore
   ```

2. **Add theme_kit 3.0**:
   ```yaml
   dev_dependencies:
     theme_kit: ^3.0.0
   ```

3. **Create configuration file** (`theme_kit.yaml`):
   ```yaml
   name: my_theme  # Same as before
   prefix: mt      # Same as before
   
   # Copy your previous configuration here
   font_families: [Inter, Poppins]
   # ... other settings
   ```

4. **Generate theme**:
   ```bash
   dart run theme_kit:generate --output lib
   ```

5. **Update imports**:
   - If you generated in a different location, update your import paths
   - The generated file structure is the same, just the location may differ

### Benefits of 3.0

- ✅ No external tools required (no Mason installation)
- ✅ Version-controlled configuration (YAML file)
- ✅ Easier CI/CD integration
- ✅ More flexible output location
- ✅ Simpler workflow
- ✅ Better for team collaboration

## Troubleshooting

For detailed troubleshooting steps, see [TROUBLESHOOTING.md](TROUBLESHOOTING.md).

### "Configuration file not found"

Make sure `theme_kit.yaml` exists in your project root, or specify the path:
```bash
dart run theme_kit:generate --config path/to/config.yaml
```

### "The method 'generate' isn't defined for the class"

Make sure you've run the theme generator before trying to use the theme:
```bash
dart run theme_kit:generate
```

### Generated files not found in IDE

After generating, restart your IDE or run:
```bash
flutter pub get
```

### Import errors

Ensure your imports match the generated file location:
```dart
// If generated in lib/theme/ (default)
import 'theme/my_theme.dart';

// If generated in custom location
import 'custom/path/my_theme.dart';
```

For more issues and solutions, see the [complete troubleshooting guide](TROUBLESHOOTING.md).

## FAQ

**Q: Do I need Mason installed?**  
A: No! Version 3.0 doesn't require Mason at all. Just add theme_kit as a dev dependency.

**Q: Can I customize the generated code?**  
A: Yes! The generated code is yours to modify. However, regenerating will overwrite your changes.

**Q: How do I add new colors after generation?**  
A: Update your `theme_kit.yaml` and regenerate. You'll need to update your theme definitions in your app too.

**Q: Can I use this in production?**  
A: Yes! Theme Kit generates production-ready code with no runtime dependencies.

**Q: Does this work with Flutter Web/Desktop?**  
A: Yes! Theme Kit generates pure Dart/Flutter code that works on all platforms.

**Q: Can I have multiple themes in one app?**  
A: Yes! Generate multiple configurations with different `--output` directories.

**Q: How do I update to a new version of Theme Kit?**  
A: Update the dependency, then regenerate your theme. Review the CHANGELOG for any breaking changes.

## Examples

Check out the `/example` directory for a complete working example.

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## Support

- 🐛 [Report bugs](https://github.com/RaulColino/theme_kit/issues)
- 💡 [Request features](https://github.com/RaulColino/theme_kit/issues)
- 💬 [Discussions](https://github.com/RaulColino/theme_kit/discussions)

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history and updates.

MIT License

Copyright (c) 2025 Raúl Colino

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
