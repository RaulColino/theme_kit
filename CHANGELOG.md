## 3.0.0

**BREAKING CHANGES - Complete Rewrite**

### Core Changes
* 🎉 Complete rewrite from scratch
* 🚀 New CLI-based code generation (no Mason bricks required)
* 📝 YAML configuration file (`theme_kit.yaml`)
* 🛠️ Similar architecture to flutter_flavorizr
* ✨ Simpler workflow - no need to create package structure first
* 📦 Customize output directory with `--output` flag
* 🎨 Same great theme generation capabilities
* 🔄 Run with `dart run theme_kit:generate`

### Code Quality Improvements
* ✅ Comprehensive error handling with custom `ConfigurationException`
* ✅ Input validation for all configuration fields
* ✅ Detailed error messages with helpful suggestions
* ✅ Type-safe APIs throughout
* ✅ Proper null safety
* ✅ File system error handling

### Testing
* ✅ 99+ unit tests covering all scenarios
* ✅ Integration tests for end-to-end generation
* ✅ Edge case testing
* ✅ Validation rule testing
* ✅ Template generation testing

### Documentation
* 📖 Comprehensive README with examples
* 🚀 Quick start guide (QUICKSTART.md)
* 📚 Detailed API reference (API.md)
* 🔄 Migration guide from 2.x (MIGRATION.md)
* 🔧 Troubleshooting guide (TROUBLESHOOTING.md)
* 🎉 What's new document (WHATS_NEW.md)
* 👥 Contributing guidelines (CONTRIBUTING.md)
* ✅ Code quality review (CODE_QUALITY_REVIEW.md)

### Developer Experience
* 🎯 Clear CLI output with progress indicators
* ❌ Helpful error messages with next steps
* ✅ Success confirmations and guidance
* 📋 Example project included
* 🔍 Quality check script (check.sh)

### Validation Features
* Validates theme name and prefix format
* Validates font family names
* Validates font weights (100-900, multiples of 100)
* Validates color token names (valid Dart identifiers)
* Validates text style names (valid Dart identifiers)
* Validates font sizes (must be positive)
* Handles malformed YAML gracefully

### Generated Code
* 🎨 Clean, well-formatted Dart code
* 📦 Zero runtime dependencies
* 🔒 Type-safe APIs
* 📝 Inline documentation
* ✨ Flutter-optimized
* 🛠️ Fully customizable

### Breaking Changes from 2.x
1. **Installation:** Now a dev dependency, not a Mason brick
2. **Generation command:** `dart run theme_kit:generate` instead of `mason make`
3. **Configuration:** YAML file instead of interactive prompts
4. **Package structure:** No automatic package creation

See [MIGRATION.md](MIGRATION.md) for detailed migration instructions.


## 1.0.2

* Added homepage to readme

## 1.0.1

* Documentation fixes

## 1.0.0

* First stable release

## 0.0.2

* small fixes

## 0.0.1

* Initial release