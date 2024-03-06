# Usage of devest_ui

It is recomended to create a `packages` folder in the root of your project, create a 
package with the name of the theme (e.g. `packages/devest_ui`) by running
inside the `packages` folder the following command:

```bash
flutter create --template=package devest_ui
```

Then, run mason make theme_kit inside `/packages/devest_ui` to 
generate the necessary files. This way, you can use the theme in multiple projects.

To use the fonts from devest_ui, you can define the fonts you want to 
use in the `pubspec.yaml` file of the app (root project). Here's an example of how you can define the fonts:

```yaml
fonts:
  - family: Poppins
    fonts:
      - asset: packages/devest_ui/fonts/Poppins-Regular.ttf
        weight: 400
      - asset: packages/devest_ui/fonts/Poppins-Medium.ttf
        weight: 500
      - asset: packages/devest_ui/fonts/Poppins-SemiBold.ttf
        weight: 600
      - asset: packages/devest_ui/fonts/Poppins-Bold.ttf
        weight: 700
```

Now, you are ready to use the theme in your app. You can use the theme in the `MaterialApp` widget like this:

```dart
import 'package:flutter/material.dart';
import 'package:devest_ui/devest_ui.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _lightTheme = DvTheme(
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

  static final _darkTheme = DvTheme(
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
    return DevestUiTheme(
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
      backgroundColor: DvColor.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ThemeSettings(),
         DvText.displayXL("Display XL").styles(
            color: DvColor.secondary,
            fontWeight: DvFontWeight.bold,
          ),
          DvText.displayL("Display L").styles(
            color: DvColor.error,
            fontFamily: DvFontFamily.inter,
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
        DvText.displayXL("Theme Settings").styles(
          color: DvColor.textPrimary,
        ),
        Row(
          children: [
            ElevatedButton(
              child: DvText.bodyM("Light Theme"),
              onPressed: () {
                DevestUi.setLightTheme();
              },
            ),
            ElevatedButton(
              child: DvText.bodyM("Dark Theme"),
              onPressed: () {
                DevestUi.setDarkTheme();
              },
            ),
          ],
        ),
      ],
    );
  }
}
```