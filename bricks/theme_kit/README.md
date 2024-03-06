# theme_kit

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

Create themes you'll enjoy using 🎨.

## Features

- ✅ Easy to use dark and light themes.
- ✅ Based on Material Design. Don't need 
to learn anything new. Combine it with Material Components seamlessly.
- ✅ Customizable colors.
- ✅ Customizable text styles, font families and font weights.
- ✅ No dependencies required.


## Getting Started 🚀

To use theme kit follow these steps:

1. Install mason: [https://docs.brickhub.dev/installing](https://docs.brickhub.dev/installing)

2. Install the theme_kit brick

```bash
mason add theme_kit
```

3. Generate your theme in the desired directory (p.e. `/packages`) 
It is recomended to create a `packages` folder in the root of your Flutter project, create a 
package with the name of the theme (e.g. `packages/my_theme`) by running 
inside the `packages` folder the following command with the name of the theme (e.g. `my_theme`):

```bash
flutter create --template=package my_theme
```
    
4. Then, inside the package folder (e.g. `packages/my_theme`),
run mason make theme_kit to replace and generate the necessary files for 
the theme.

```bash
mason make theme_kit
```

5. Follow the instructions to complete the installation.
```bash
What is the name of the theme? (theme kit) my theme
What is the prefix you want to use in your theme classes? use lowercase, no spaces. Recommended to be 2-3 characters long. (tk) mt
```

6. To use the fonts defined in the theme, you can define the fonts you want to 
use in the `pubspec.yaml` file of your app (root project). Here's an example of how you can define the fonts:

```yaml
fonts:
  - family: Poppins
    fonts:
      - asset: packages/my_theme/fonts/Poppins-Regular.ttf
        weight: 400
      - asset: packages/my_theme/fonts/Poppins-Medium.ttf
        weight: 500
      - asset: packages/my_theme/fonts/Poppins-SemiBold.ttf
        weight: 600
      - asset: packages/my_theme/fonts/Poppins-Bold.ttf
        weight: 700
```

7. Now, you can use the theme like this (this example uses `my theme` as the theme name 
and `mt` as the prefix):

```dart
import 'package:flutter/material.dart';
import 'package:my_theme/my_theme.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _lightTheme = MtTheme(
    primary: Colors.blue,
    secondary: Colors.blueGrey[200],
    success: Colors.green,
    warning: Colors.yellow,
    error: Colors.red,
    info: Colors.blue,
    background: Colors.white,
    surface100: Colors.white,
    surface200: Colors.grey[100],
    textPrimary: Colors.black,
    textSecondary: Colors.grey,
    divider: Colors.grey[300],
    border: Colors.grey[300],
  );

  static final _darkTheme = MtTheme(
    primary: Colors.blue,
    secondary: Colors.blueGrey[700],
    success: Colors.green,
    warning: Colors.yellow,
    error: Colors.red,
    info: Colors.blue,
    background: Colors.black,
    surface100: Colors.grey[900],
    surface200: Colors.grey[800],
    textPrimary: Colors.white,
    textSecondary: Colors.grey,
    divider: Colors.grey[700],
    border: Colors.grey[700],
  );

  @override
  Widget build(BuildContext context) {
    return MyTheme(
      lightTheme: _lightTheme,
      darkTheme: _darkTheme,
      child: MaterialApp(
        title: 'Example',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MtColor.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ThemeSettings(),
          MtText.displayXL("Display XL").styles(
            color: MtColor.secondary,
            fontWeight: MtFontWeight.bold,
          ),
          MtText.displayL("Display L").styles(
            color: MtColor.error,
            fontFamily: MtFontFamily.inter,
          ),
        ],
      ),
    );
  }
}

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MtText.displayXL("Theme Settings").styles(
          color: MtColor.textPrimary,
        ),
        Row(
          children: [
            ElevatedButton(
              child: MtText.bodyM("Light Theme"),
              onPressed: () {
                MyTheme.setLightTheme();
              },
            ),
            ElevatedButton(
              child: MtText.bodyM("Dark Theme"),
              onPressed: () {
                MyTheme.setDarkTheme();
              },
            ),
          ],
        ),
      ],
    );
  }
}
```