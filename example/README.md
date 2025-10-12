# Theme Kit 3.0 Example

This example demonstrates how to use Theme Kit 3.0 to generate a custom theme for your Flutter app.

## Setup

1. This example has a `theme_kit.yaml` configuration file that defines the theme.

2. To generate the theme, run from the example directory:

```bash
dart run theme_kit:generate
```

This will generate the theme files in `lib/theme/` directory.

3. The example app in `lib/main.dart` shows how to use the generated theme.

## What's Generated

After running the generator, you'll get:

- `lib/theme/app_theme.dart` - Main export file
- `lib/theme/src/colors/` - Color tokens and theme configuration
- `lib/theme/src/typography/` - Text widgets, font families, and weights
- `lib/theme/src/theme/` - Main theme InheritedWidget
- `lib/theme/USAGE.md` - Usage documentation

## Running the Example

```bash
flutter run
```

Note: The generated theme files are not committed to git (see .gitignore), so you'll need to generate them first before running the example.
