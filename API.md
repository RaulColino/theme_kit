# Theme Kit API Documentation

This document describes the API of the generated theme classes and how to use them in your Flutter application.

## Table of Contents

- [Theme Configuration Class](#theme-configuration-class)
- [Color Class](#color-class)
- [Text Widget Class](#text-widget-class)
- [Font Family Class](#font-family-class)
- [Font Weight Class](#font-weight-class)
- [Main Theme Widget](#main-theme-widget)

## Theme Configuration Class

**Class:** `{Prefix}Theme` (e.g., `MTTheme`)

This class holds the color configuration for your theme. You create instances of this class to define light and dark themes.

### Constructor

```dart
MTTheme({
  Color? primary,
  Color? secondary,
  Color? success,
  Color? warning,
  Color? error,
  Color? background,
  Color? textPrimary,
  // ... other colors from your configuration
})
```

### Example

```dart
final lightTheme = MTTheme(
  primary: Colors.blue,
  secondary: Colors.blueGrey[200],
  success: Colors.green,
  warning: Colors.orange,
  error: Colors.red,
  background: Colors.white,
  textPrimary: Colors.black,
  textSecondary: Colors.grey[600],
);

final darkTheme = MTTheme(
  primary: Colors.blue[300],
  secondary: Colors.blueGrey[700],
  success: Colors.green[300],
  warning: Colors.orange[300],
  error: Colors.red[300],
  background: Colors.black,
  textPrimary: Colors.white,
  textSecondary: Colors.grey[400],
);
```

## Color Class

**Class:** `{Prefix}Color` (e.g., `MTColor`)

This class provides static getters for accessing theme colors throughout your app.

### Properties

Each color token defined in your configuration becomes a static getter:

```dart
static Color? get primary;
static Color? get secondary;
static Color? get success;
// ... etc
```

### Methods

#### `setTheme(theme)`

Sets the current theme. This is called automatically by the main theme widget.

```dart
static void setTheme(MTTheme theme)
```

### Example

```dart
Container(
  color: MTColor.background,
  child: Text(
    'Hello',
    style: TextStyle(color: MTColor.textPrimary),
  ),
)
```

### Note

Colors return `null` if no theme is set. Make sure to wrap your app with the main theme widget before accessing colors.

## Text Widget Class

**Class:** `{Prefix}Text` (e.g., `MTText`)

This class extends Flutter's `Text` widget with theme-aware styling and convenient factory constructors.

### Constructor

The main constructor accepts all standard `Text` parameters plus custom font family and font weight:

```dart
MTText(
  String data, {
  Key? key,
  // Standard Text parameters
  TextAlign? textAlign,
  TextOverflow? overflow,
  int? maxLines,
  // ... all Flutter Text parameters
  // Custom parameters
  MTFontWeight? fontWeight,
  MTFontFamily? fontFamily,
})
```

### Factory Constructors

Each text style defined in your configuration becomes a factory constructor:

```dart
MTText.displayXL(String data)  // fontSize: 48.0
MTText.displayL(String data)   // fontSize: 36.0
MTText.headingL(String data)   // fontSize: 28.0
MTText.bodyM(String data)      // fontSize: 16.0
// ... etc
```

### Methods

#### `styles()`

Applies additional styling to the text. Returns a new instance with the merged styles:

```dart
MTText styles({
  Color? color,
  double? fontSize,
  MTFontWeight? fontWeight,
  MTFontFamily? fontFamily,
  double? letterSpacing,
  double? height,
  // ... other TextStyle properties
})
```

#### `copyWith()`

Creates a copy with modified properties:

```dart
MTText copyWith({
  String? data,
  Color? color,
  double? fontSize,
  // ... all Text properties
})
```

### Example

```dart
// Using factory constructor
MTText.displayXL('Hello World')

// With custom styling
MTText.bodyM('Welcome').styles(
  color: MTColor.primary,
  fontWeight: MTFontWeight.bold,
)

// Chaining styles
MTText.headingL('Title')
  .styles(color: Colors.blue)
  .styles(letterSpacing: 1.2)

// Using copyWith
final text = MTText.bodyM('Original');
final modified = text.copyWith(color: Colors.red);
```

## Font Family Class

**Class:** `{Prefix}FontFamily` (e.g., `MTFontFamily`)

This class provides const instances for each font family defined in your configuration.

### Properties

Each font family becomes a const static field:

```dart
static const MTFontFamily inter = MTFontFamily._('Inter');
static const MTFontFamily roboto = MTFontFamily._('Roboto');
// ... etc
```

### Example

```dart
MTText.bodyM('Custom font').styles(
  fontFamily: MTFontFamily.roboto,
)
```

## Font Weight Class

**Class:** `{Prefix}FontWeight` (e.g., `MTFontWeight`)

This class wraps Flutter's `FontWeight` with const instances for each weight defined in your configuration.

### Properties

Each font weight becomes a const static field:

```dart
static const regular = MTFontWeight._(FontWeight.w400);
static const medium = MTFontWeight._(FontWeight.w500);
static const semibold = MTFontWeight._(FontWeight.w600);
static const bold = MTFontWeight._(FontWeight.w700);
// ... etc
```

### Example

```dart
MTText.bodyM('Bold text').styles(
  fontWeight: MTFontWeight.bold,
)
```

## Main Theme Widget

**Class:** `{ThemeName}` (e.g., `MyTheme`)

This is a `StatefulWidget` that manages theme state and provides it to the widget tree.

### Constructor

```dart
MyTheme({
  Key? key,
  required Widget child,
  required MTTheme lightTheme,
  MTTheme? darkTheme,
})
```

### Parameters

- `child`: The widget tree to wrap (typically your `MaterialApp`)
- `lightTheme`: The light theme configuration
- `darkTheme`: Optional dark theme configuration

### Static Methods

#### `of(context)`

Gets the theme state from the widget tree:

```dart
static _MyThemeState? of(BuildContext context)
```

#### `setLightTheme()`

Switches to light theme globally:

```dart
static void setLightTheme()
```

#### `setDarkTheme()`

Switches to dark theme globally:

```dart
static void setDarkTheme()
```

### Example

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

// Switching themes
ElevatedButton(
  onPressed: () => MyTheme.setDarkTheme(),
  child: Text('Dark Mode'),
)

ElevatedButton(
  onPressed: () => MyTheme.setLightTheme(),
  child: Text('Light Mode'),
)
```

## Complete Example

Here's a complete example showing how all the components work together:

```dart
import 'package:flutter/material.dart';
import 'package:my_theme/my_theme.dart';

// Define themes
final lightTheme = MTTheme(
  primary: Colors.blue,
  background: Colors.white,
  textPrimary: Colors.black,
);

final darkTheme = MTTheme(
  primary: Colors.blue[300],
  background: Colors.black,
  textPrimary: Colors.white,
);

void main() {
  runApp(
    MyTheme(
      lightTheme: lightTheme,
      darkTheme: darkTheme,
      child: MaterialApp(
        title: 'Theme Kit Example',
        home: HomePage(),
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MTColor.background,
      appBar: AppBar(
        title: MTText.headingL('Theme Kit').styles(
          color: MTColor.primary,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MTText.displayXL('Hello World!').styles(
              color: MTColor.primary,
              fontWeight: MTFontWeight.bold,
            ),
            SizedBox(height: 20),
            MTText.bodyM('This is using the generated theme.').styles(
              color: MTColor.textPrimary,
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => MyTheme.setLightTheme(),
                  child: Text('Light'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => MyTheme.setDarkTheme(),
                  child: Text('Dark'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

## Best Practices

1. **Initialize once:** Wrap your `MaterialApp` with the theme widget only once at the root
2. **Define themes early:** Create your theme instances before building the widget tree
3. **Use semantic names:** Choose meaningful names for colors (e.g., `textPrimary` instead of `gray800`)
4. **Consistent styling:** Use the text style factories (`MTText.bodyM()`) for consistency
5. **Hot restart:** When switching themes, you may need to hot restart instead of hot reload
6. **Null safety:** Check for null colors in edge cases or ensure theme is always set

## TypeScript-like Type Safety

The generated code provides excellent type safety:

```dart
// ✅ Compile-time safety
MTText.bodyM('text').styles(
  fontWeight: MTFontWeight.bold,  // Type-safe
  fontFamily: MTFontFamily.inter, // Type-safe
)

// ❌ Won't compile
MTText.bodyM('text').styles(
  fontWeight: FontWeight.w700,    // Wrong type
)
```

## Additional Resources

- [README.md](README.md) - General documentation
- [QUICKSTART.md](QUICKSTART.md) - Quick start guide
- [TROUBLESHOOTING.md](TROUBLESHOOTING.md) - Common issues
- [WHATS_NEW.md](WHATS_NEW.md) - Version 3.0 changes
