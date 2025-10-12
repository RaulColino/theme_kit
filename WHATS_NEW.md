# Theme Kit 3.0 - What's New

## Overview

Theme Kit 3.0 is a **complete rewrite** of the package from the ground up. The new version removes the dependency on Mason bricks and introduces a CLI-based code generation approach similar to `flutter_flavorizr`.

## Major Changes

### 1. No More Mason Bricks ❌🧱

**Before (2.x):**
```bash
# Install Mason
dart pub global activate mason_cli

# Initialize Mason
mason init

# Add brick
mason add theme_kit

# Generate theme
mason make theme_kit
```

**Now (3.0):**
```bash
# Add as dev dependency
flutter pub add --dev theme_kit

# Generate theme
dart run theme_kit:generate
```

### 2. YAML Configuration 📝

**Before (2.x):**
- Interactive prompts during generation
- Settings not version controlled
- Hard to reproduce builds

**Now (3.0):**
```yaml
# theme_kit.yaml - version controlled!
name: my_theme
prefix: mt
colors:
  primary:
    description: Primary brand color
  # ... more configuration
```

### 3. Flexible Output 📁

**Before (2.x):**
- Fixed directory structure
- Required specific project setup

**Now (3.0):**
```bash
# Generate anywhere you want
dart run theme_kit:generate --output lib/theme
dart run theme_kit:generate --output packages/my_theme/lib
```

### 4. Simpler Dependencies 🎯

**Before (2.x):**
```yaml
dev_dependencies:
  mason_cli: any  # External tool required
```

**Now (3.0):**
```yaml
dev_dependencies:
  theme_kit: ^3.0.0  # That's it!
```

## Architecture Comparison

### Version 2.x (Mason-based)

```
Mason CLI Tool
    ↓
Mason Brick Templates
    ↓
Interactive Prompts
    ↓
File Generation
    ↓
Fixed Package Structure
```

### Version 3.0 (CLI-based)

```
theme_kit.yaml Configuration
    ↓
Configuration Parser
    ↓
Template System
    ↓
Code Generator
    ↓
Flexible Output Directory
```

## Feature Comparison

| Feature | 2.x | 3.0 |
|---------|-----|-----|
| Mason dependency | ✅ Required | ❌ None |
| Configuration | Interactive | YAML file |
| Version control | ❌ | ✅ |
| CI/CD friendly | ❌ | ✅ |
| Custom output | ❌ | ✅ |
| Team collaboration | Difficult | Easy |
| Installation complexity | High | Low |
| Build reproducibility | Low | High |

## Generated Code Quality

The generated code quality remains the same:
- ✅ No runtime dependencies
- ✅ Fully customizable
- ✅ Type-safe
- ✅ Well-documented
- ✅ Flutter-optimized

## Migration Benefits

### For Individual Developers

1. **Faster setup**: No external tools to install
2. **Easier workflow**: Single command to generate
3. **Better control**: YAML configuration is more explicit

### For Teams

1. **Version control**: Configuration in git
2. **Reproducible builds**: Same config = same output
3. **CI/CD integration**: Easy to automate
4. **Documentation**: Configuration file is self-documenting

### For Package Maintainers

1. **Simpler distribution**: No brick hosting needed
2. **Standard tooling**: Uses pub.dev
3. **Version management**: Standard semantic versioning
4. **Updates**: Normal dependency updates

## What Stayed the Same

- ✅ Generated file structure
- ✅ API and usage patterns
- ✅ Theme capabilities
- ✅ Customization options
- ✅ Zero runtime dependencies
- ✅ Flutter compatibility

## Breaking Changes

1. **Installation method**: Now a dev dependency, not a Mason brick
2. **Generation command**: `dart run theme_kit:generate` instead of `mason make`
3. **Configuration**: YAML file instead of interactive prompts
4. **Package structure**: No automatic package creation

## Should You Upgrade?

### Yes, if you:
- ✅ Want simpler tooling
- ✅ Need version-controlled configuration
- ✅ Want better CI/CD integration
- ✅ Value reproducible builds
- ✅ Prefer declarative configuration

### Stay on 2.x if you:
- ❌ Have existing 2.x projects working fine
- ❌ Prefer interactive prompts
- ❌ Don't want to change your workflow
- ❌ Need features only in 2.x

Note: 2.x will continue to work, but new features will only be added to 3.0.

## Getting Started with 3.0

1. **Read the Quick Start**: [QUICKSTART.md](QUICKSTART.md)
2. **Review examples**: Check the `/example` directory
3. **Read documentation**: [README.md](README.md)
4. **Migrate gradually**: Test in a new project first

## Support

- 📖 [Full Documentation](README.md)
- 🚀 [Quick Start Guide](QUICKSTART.md)
- 🤝 [Contributing Guide](CONTRIBUTING.md)
- 🐛 [Report Issues](https://github.com/RaulColino/theme_kit/issues)
- 💬 [Discussions](https://github.com/RaulColino/theme_kit/discussions)

## Acknowledgments

Version 3.0 was inspired by the simplicity and effectiveness of `flutter_flavorizr` and other CLI-based code generation tools in the Flutter ecosystem.

---

**Ready to get started?** Head over to [QUICKSTART.md](QUICKSTART.md)!
