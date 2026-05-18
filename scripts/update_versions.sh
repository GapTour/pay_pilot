#!/bin/bash

# Script to update both Android and iOS versions from version_config.json
# Usage: ./scripts/update_versions.sh

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required but not installed. Please install jq first."
    echo "You can install it with: brew install jq"
    exit 1
fi

# Check if version_config.json exists
if [ ! -f "../version_config.json" ]; then
    echo "Error: version_config.json not found in project root"
    exit 1
fi

# Read version info from JSON
VERSION_NAME=$(jq -r '.version.name' ../version_config.json)
ANDROID_CODE=$(jq -r '.version.android.code' ../version_config.json)
IOS_CODE=$(jq -r '.version.ios.code // .version.android.code' ../version_config.json)

# Check if values were read successfully
if [ "$VERSION_NAME" = "null" ] || [ "$ANDROID_CODE" = "null" ] || [ "$IOS_CODE" = "null" ]; then
    echo "Error: Could not read version information from JSON file"
    exit 1
fi

echo "Updating versions to: $VERSION_NAME"
echo "Android version code: $ANDROID_CODE"
echo "iOS version code: $IOS_CODE"
echo ""

# Update Android version
echo "Updating Android version..."
sed -i '' "s/versionCode = .*/versionCode = $ANDROID_CODE/" ../android/app/build.gradle.kts
sed -i '' "s/versionName = .*/versionName = \"$VERSION_NAME\"/" ../android/app/build.gradle.kts
echo "✓ Android version updated successfully!"
echo "  versionName: $VERSION_NAME"
echo "  versionCode: $ANDROID_CODE"
echo ""

# Update iOS version
echo "Updating iOS version..."
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $VERSION_NAME" ../ios/Runner/Info.plist
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $IOS_CODE" ../ios/Runner/Info.plist
echo "✓ iOS version updated successfully!"
echo "  CFBundleShortVersionString: $VERSION_NAME"
echo "  CFBundleVersion: $IOS_CODE"
echo ""

# Update pubspec.yaml
echo "Updating pubspec.yaml..."
sed -i '' "s/version: .*/version: $VERSION_NAME/" ../pubspec.yaml
echo "✓ pubspec.yaml updated successfully!"
echo "  version: $VERSION_NAME"
echo ""

# Update AppSettings.dart
echo "Updating AppSettings.dart..."
sed -i '' "s/static const String version = '[^']*';/static const String version = '$VERSION_NAME';/" ../lib/core/utils/constants/app_settings.dart
echo "✓ AppSettings.dart updated successfully!"
echo "  AppSettings.version: $VERSION_NAME"
echo ""

echo "🎉 All versions updated successfully!"
echo "Next steps:"
echo "  - For Android: Rebuild your project"
echo "  - For iOS: Rebuild your project in Xcode"
echo "  - Run 'flutter pub get' to update dependencies"
