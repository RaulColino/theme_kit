# Theme Kit

Create themes you'll enjoy using 🎨.

**Version 3.0** - Complete rewrite with CLI-based code generation (no Mason bricks required!)

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

## Migration from 2.x

If you're upgrading from theme_kit 2.x (Mason bricks), here are the key changes:

1. **No Mason required**: Version 3.0 doesn't use Mason bricks anymore
2. **YAML configuration**: Define your theme in a `theme_kit.yaml` file
3. **CLI-based**: Run `dart run theme_kit:generate` instead of `mason make`
4. **Generated code location**: Customize output directory with `--output` flag
5. **Simpler workflow**: No need to create package structure first

### Migration Steps

1. Remove Mason dependencies from your project
2. Add theme_kit 3.0 as a dev dependency
3. Create a `theme_kit.yaml` configuration file
4. Run `dart run theme_kit:generate`
5. Update imports in your app to use the new generated location

## License

MIT License

Copyright (c) 2025 Raúl Colino

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
