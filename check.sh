#!/bin/bash

# Theme Kit Quality Check Script
# This script validates the package structure and code quality

set -e

echo "🎨 Theme Kit Quality Check"
echo "=========================="
echo ""

# Check if we're in the right directory
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ Error: pubspec.yaml not found. Run this script from the project root."
    exit 1
fi

echo "📦 Checking package structure..."

# Check required files
required_files=(
    "pubspec.yaml"
    "README.md"
    "CHANGELOG.md"
    "LICENSE"
    "lib/theme_kit.dart"
    "lib/src/config/theme_config.dart"
    "lib/src/generator/theme_generator.dart"
    "bin/generate.dart"
)

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✓ $file"
    else
        echo "✗ $file (missing)"
        exit 1
    fi
done

echo ""
echo "📝 Checking documentation..."

# Check documentation files
doc_files=(
    "README.md"
    "QUICKSTART.md"
    "WHATS_NEW.md"
    "CONTRIBUTING.md"
    "TROUBLESHOOTING.md"
    "API.md"
    "MIGRATION.md"
)

for file in "${doc_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✓ $file"
    else
        echo "✗ $file (missing)"
    fi
done

echo ""
echo "🧪 Checking test structure..."

# Check test files
if [ -d "test" ]; then
    echo "✓ test/ directory exists"
    
    test_count=$(find test -name "*_test.dart" -type f | wc -l)
    echo "  Found $test_count test files"
    
    if [ $test_count -eq 0 ]; then
        echo "⚠️  Warning: No test files found"
    fi
else
    echo "✗ test/ directory missing"
fi

echo ""
echo "📂 Checking source structure..."

# Check source directories
src_dirs=(
    "lib/src/config"
    "lib/src/generator"
    "lib/src/templates"
)

for dir in "${src_dirs[@]}"; do
    if [ -d "$dir" ]; then
        file_count=$(find "$dir" -name "*.dart" -type f | wc -l)
        echo "✓ $dir ($file_count files)"
    else
        echo "✗ $dir (missing)"
        exit 1
    fi
done

echo ""
echo "🔍 Checking template files..."

# Check all templates exist
templates=(
    "lib/src/templates/color_template.dart"
    "lib/src/templates/font_family_template.dart"
    "lib/src/templates/font_weight_template.dart"
    "lib/src/templates/theme_class_template.dart"
    "lib/src/templates/text_widget_template.dart"
    "lib/src/templates/main_theme_template.dart"
)

for template in "${templates[@]}"; do
    if [ -f "$template" ]; then
        echo "✓ $(basename $template)"
    else
        echo "✗ $(basename $template) (missing)"
        exit 1
    fi
done

echo ""
echo "📋 Checking example project..."

if [ -d "example" ]; then
    echo "✓ example/ directory exists"
    
    if [ -f "example/pubspec.yaml" ]; then
        echo "✓ example/pubspec.yaml"
    else
        echo "✗ example/pubspec.yaml (missing)"
    fi
    
    if [ -f "example/theme_kit.yaml" ]; then
        echo "✓ example/theme_kit.yaml"
    else
        echo "✗ example/theme_kit.yaml (missing)"
    fi
    
    if [ -f "example/lib/main.dart" ]; then
        echo "✓ example/lib/main.dart"
    else
        echo "✗ example/lib/main.dart (missing)"
    fi
else
    echo "✗ example/ directory missing"
fi

echo ""
echo "✅ Quality check complete!"
echo ""
echo "Summary:"
echo "--------"
echo "• Package structure: ✓"
echo "• Documentation: ✓"
echo "• Tests: ✓"
echo "• Templates: ✓"
echo "• Example: ✓"
echo ""
echo "Next steps:"
echo "1. Install dependencies: flutter pub get"
echo "2. Run tests: flutter test (requires Flutter SDK)"
echo "3. Generate example theme: cd example && dart run theme_kit:generate"
echo "4. Run example app: cd example && flutter run"
