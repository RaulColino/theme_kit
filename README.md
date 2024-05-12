<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# Theme Kit

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

Create themes you'll enjoy using 🎨.

## Features

- ✅ Easy to set dark and light themes.
- ✅ Use your own custom theme tokens on top of Material Design.
- ✅ Easy to use, just import the theme and use it in your Material components + autocompletion available for every theme token + custom documentation file automatically generated for your theme.
- ✅ Fully customizable, the generated code is editable and yours!
- ✅ Includes definition of colors, text styles, font families and font weights.
- ✅ Reusable. The theme is generated in a separate package that can be shared across multiple projects.
- ✅ No dependencies required.
- ✅ No build runner needed 😉.


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
    
4. Then, inside the package folder (e.g. `/packages`),
run `mason make theme_kit` to replace and generate the necessary files for 
the theme.

```bash
mason make theme_kit
```

5. Follow the instructions to complete the installation. Make sure the name of the theme is the same as the package name. For example, in this case we use `my theme` as the theme name and `mt` as the prefix.
```bash
What is the name of the theme? (theme kit) my theme
What is the prefix you want to use in your theme classes? use lowercase, no spaces. Recommended to be 2-3 characters long. (tk) mt
```
After creating the theme package, go to the pubspec.yaml of the app (root project) and import it in the `dependencies` section. For example if the theme package name is `my_theme` 
it should look like this:

```yaml
dependencies:
  my_theme:
    path: packages/my_theme
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

# License

MIT License

Copyright (c) 2023 Raúl Colino

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.