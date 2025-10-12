# Contributing to Theme Kit

Thank you for your interest in contributing to Theme Kit! This document provides guidelines and instructions for contributing.

## Development Setup

1. Clone the repository:
```bash
git clone https://github.com/RaulColino/theme_kit.git
cd theme_kit
```

2. Install dependencies:
```bash
dart pub get
```

3. Run the example:
```bash
cd example
dart run theme_kit:generate
flutter run
```

## Project Structure

```
theme_kit/
├── bin/
│   └── generate.dart          # CLI entry point
├── lib/
│   ├── src/
│   │   ├── config/            # Configuration models
│   │   ├── generator/         # Code generation logic
│   │   └── templates/         # Code templates
│   └── theme_kit.dart         # Main library export
├── example/                   # Example Flutter app
└── theme_kit.yaml            # Example configuration
```

## How Theme Generation Works

1. **Configuration**: User creates a `theme_kit.yaml` file defining theme properties
2. **Parsing**: `ThemeConfig` class reads and validates the YAML
3. **Generation**: `ThemeGenerator` uses templates to generate Dart code
4. **Output**: Generated files are written to the specified output directory

## Adding New Features

### Adding a New Template

1. Create a new file in `lib/src/templates/`
2. Implement a static `generate(ThemeConfig config)` method
3. Return the generated Dart code as a string
4. Update `ThemeGenerator` to use the new template

Example:
```dart
class MyNewTemplate {
  static String generate(ThemeConfig config) {
    return '''
// Generated code here
class ${config.prefix.toUpperCase()}MyFeature {
  // Implementation
}
''';
  }
}
```

### Adding Configuration Options

1. Add new fields to `ThemeConfig` in `lib/src/config/theme_config.dart`
2. Parse the new fields in `fromYaml` method
3. Update templates to use the new configuration
4. Document the new options in README

## Testing

Currently, testing is manual:

1. Generate theme with various configurations
2. Check generated code compiles
3. Verify generated code works in a Flutter app

We welcome contributions to add automated tests!

## Code Style

- Follow [Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions focused and small

## Submitting Changes

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Test your changes thoroughly
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## Pull Request Guidelines

- Describe what your PR does and why
- Reference any related issues
- Ensure code follows style guidelines
- Update documentation if needed
- Add examples if applicable

## Reporting Issues

When reporting issues, please include:

- Theme Kit version
- Flutter/Dart version
- Operating system
- Configuration file (if applicable)
- Steps to reproduce
- Expected vs actual behavior
- Error messages or logs

## Questions?

Feel free to open an issue for questions or join discussions in the repository.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
