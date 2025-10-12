import 'package:flutter/material.dart';
// After running 'dart run theme_kit:generate', uncomment the line below:
// import 'theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Uncomment after generating theme:
  // static final _lightTheme = ATTheme(
  //   primary: Colors.blue,
  //   secondary: Colors.blueGrey[200],
  //   success: Colors.green,
  //   error: Colors.red,
  //   background: Colors.white,
  //   surface: Colors.grey[100],
  //   textPrimary: Colors.black,
  //   textSecondary: Colors.grey[600],
  // );
  //
  // static final _darkTheme = ATTheme(
  //   primary: Colors.blue,
  //   secondary: Colors.blueGrey[700],
  //   success: Colors.green,
  //   error: Colors.red,
  //   background: Colors.black,
  //   surface: Colors.grey[900],
  //   textPrimary: Colors.white,
  //   textSecondary: Colors.grey[400],
  // );

  @override
  Widget build(BuildContext context) {
    // After generating theme, wrap MaterialApp with AppTheme:
    // return AppTheme(
    //   lightTheme: _lightTheme,
    //   darkTheme: _darkTheme,
    //   child: MaterialApp(
    //     title: 'Theme Kit 3.0 Example',
    //     home: const HomePage(),
    //   ),
    // );

    // Before generating theme, show instruction page:
    return MaterialApp(
      title: 'Theme Kit 3.0 Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const InstructionsPage(),
    );
  }
}

class InstructionsPage extends StatelessWidget {
  const InstructionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Kit 3.0 Example'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.palette,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 24),
              const Text(
                'Welcome to Theme Kit 3.0!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'To see this example in action:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1. Run the theme generator:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    SelectableText(
                      'dart run theme_kit:generate',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '2. Uncomment the code in lib/main.dart',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '3. Run the app again',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'The theme files will be generated in lib/theme/',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Uncomment this after generating the theme:
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ATColor.background,
//       appBar: AppBar(
//         title: ATText.headingL('Theme Kit 3.0').styles(
//           color: ATColor.textPrimary,
//         ),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ATText.displayXL('Hello World!').styles(
//                 color: ATColor.primary,
//               ),
//               const SizedBox(height: 16),
//               ATText.bodyM('This is using the generated theme.').styles(
//                 color: ATColor.textPrimary,
//               ),
//               const SizedBox(height: 32),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       AppTheme.setLightTheme();
//                     },
//                     child: ATText.bodyS('Light Theme'),
//                   ),
//                   const SizedBox(width: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       AppTheme.setDarkTheme();
//                     },
//                     child: ATText.bodyS('Dark Theme'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
