# Usage of {{theme_name.snakeCase()}}

🎉 Congratulations! You've successfully built your custom theme with Theme Kit!

Now, before using it in your app, it is recomended to use it as a package so 
you can manage your themes separately from your app. Just run the following command 
and go to `packages/{{theme_name.snakeCase()}}/lib/USAGE.md` to see how to 
use the theme in your app.
```bash
flutter create --org com.{{theme_name.paramCase()}} --template=package packages/{{theme_name.snakeCase()}} && cp -r {{theme_name.snakeCase()}} packages/ && rm -r {{theme_name.snakeCase()}}
```

Thats it! Now you're ready to use the theme 🚀! Use the theme in your app like a normal local package. Go to 
the `pubspec.yaml` of the app (root project) and add the following 
line to the `dependencies` section:

```yaml
dependencies:
  {{theme_name.snakeCase()}}:
    path: packages/{{theme_name.snakeCase()}}
```

To use the fonts from {{theme_name.snakeCase()}}, you can define the fonts you want to 
use in the `pubspec.yaml` file of the app (root project). Here's an example of how you can define the fonts:

```yaml
fonts:
  - family: Poppins
    fonts:
      - asset: packages/{{theme_name.snakeCase()}}/fonts/Poppins-Regular.ttf
        weight: 400
      - asset: packages/{{theme_name.snakeCase()}}/fonts/Poppins-Medium.ttf
        weight: 500
      - asset: packages/{{theme_name.snakeCase()}}/fonts/Poppins-SemiBold.ttf
        weight: 600
      - asset: packages/{{theme_name.snakeCase()}}/fonts/Poppins-Bold.ttf
        weight: 700
```

Now, you are ready to use the theme in your app. You can use the theme in the `MaterialApp` widget like this:

```dart
import 'package:flutter/material.dart';
import 'package:{{theme_name.snakeCase()}}/{{theme_name.snakeCase()}}.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _lightTheme = {{prefix.pascalCase()}}Theme(
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

  static final _darkTheme = {{prefix.pascalCase()}}Theme(
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
    return {{theme_name.pascalCase()}}(
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
      backgroundColor: {{prefix.pascalCase()}}Color.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ThemeSettings(),
          {{prefix.pascalCase()}}Text.displayXL("Display XL").styles(
            color: {{prefix.pascalCase()}}Color.secondary,
            fontWeight: {{prefix.pascalCase()}}FontWeight.bold,
          ),
          {{prefix.pascalCase()}}Text.displayL("Display L").styles(
            color: {{prefix.pascalCase()}}Color.error,
            fontFamily: {{prefix.pascalCase()}}FontFamily.inter,
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
        {{prefix.pascalCase()}}Text.displayXL("Theme Settings").styles(
          color: {{prefix.pascalCase()}}Color.textPrimary,
        ),
        Row(
          children: [
            ElevatedButton(
              child: {{prefix.pascalCase()}}Text.bodyM("Light Theme"),
              onPressed: () {
                {{theme_name.pascalCase()}}.setLightTheme();
              },
            ),
            ElevatedButton(
              child: {{prefix.pascalCase()}}Text.bodyM("Dark Theme"),
              onPressed: () {
                {{theme_name.pascalCase()}}.setDarkTheme();
              },
            ),
          ],
        ),
      ],
    );
  }
}
```

If you want to customize the theme tokens and fonts, you can edit the following files:

- Color tokens: `/packages/{{theme_name.snakeCase()}}/lib/src/colors/{{prefix.snakeCase()}}_color.dart`
- Text tokens: `/packages/{{theme_name.snakeCase()}}/lib/src/typography/{{prefix.snakeCase()}}_text.dart`
- Font families*: `/packages/{{theme_name.snakeCase()}}/lib/src/typography/{{prefix.snakeCase()}}_font_family.dart`
- Font weights: `/packages/{{theme_name.snakeCase()}}/lib/src/typography/{{prefix.snakeCase()}}_font_weight.dart`

*If you want to use custom fonts, you can add the font files to 
the `/packages/{{theme_name.snakeCase()}}/lib/fonts` folder. Then, you can define the font families in 
`/packages/{{theme_name.snakeCase()}}/lib/src/typography/{{prefix.snakeCase()}}_font_family.dart`.