# Theme Kit 3.0 - Quick Start Guide

Get up and running with Theme Kit in 5 minutes!

## Step 1: Install Theme Kit

Add theme_kit to your `pubspec.yaml`:

```yaml
dev_dependencies:
  theme_kit: ^3.0.0
```

Then run:
```bash
flutter pub get
```

## Step 2: Create Configuration

Create a `theme_kit.yaml` file in your project root:

```yaml
name: my_theme
prefix: mt

font_families:
  - Inter

font_weights:
  - name: regular
    weight: 400
  - name: bold
    weight: 700

colors:
  primary:
    description: Primary brand color
  background:
    description: Background color
  textPrimary:
    description: Primary text color

text_styles:
  - name: headingL
    font_size: 28.0
  - name: bodyM
    font_size: 16.0
```

## Step 3: Generate Your Theme

Run the generator:

```bash
dart run theme_kit:generate
```

You'll see output like:
```
🎨 Theme Kit v3.0.0
Generating theme from: theme_kit.yaml
Output directory: lib/theme

📖 Loading configuration...
   Theme: my_theme
   Prefix: mt
📁 Creating output directories...
✍️  Generating theme files...
   ✓ mt_font_family.dart
   ✓ mt_font_weight.dart
   ✓ mt_text.dart
   ✓ mt_theme.dart
   ✓ mt_color.dart
   ✓ my_theme.dart
   ✓ my_theme.dart (main export)
   ✓ USAGE.md

✅ Theme generated successfully!
```

## Step 4: Define Your Colors

In your app, define your theme colors:

```dart
import 'package:flutter/material.dart';
import 'theme/my_theme.dart';

final lightTheme = MTTheme(
  primary: Colors.blue,
  background: Colors.white,
  textPrimary: Colors.black,
);

final darkTheme = MTTheme(
  primary: Colors.blue,
  background: Colors.black,
  textPrimary: Colors.white,
);
```

## Step 5: Use Your Theme

Wrap your app with the theme:

```dart
void main() {
  runApp(
    MyTheme(
      lightTheme: lightTheme,
      darkTheme: darkTheme,
      child: MaterialApp(
        home: HomePage(),
      ),
    ),
  );
}
```

Use it in your widgets:

```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MTColor.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MTText.headingL('Welcome!').styles(
              color: MTColor.primary,
            ),
            MTText.bodyM('Theme Kit 3.0').styles(
              color: MTColor.textPrimary,
            ),
            ElevatedButton(
              onPressed: () => MyTheme.setDarkTheme(),
              child: Text('Toggle Dark Mode'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## That's It! 🎉

You now have a fully functional theme system in your Flutter app!

## Next Steps

- 📖 Read the [full documentation](README.md)
- 🎨 Customize your theme in `theme_kit.yaml`
- 🔄 Regenerate after making changes
- 🚀 Build something amazing!

## Need Help?

- Check the [FAQ](README.md#faq)
- Read [Troubleshooting](README.md#troubleshooting)
- [Open an issue](https://github.com/RaulColino/theme_kit/issues)
