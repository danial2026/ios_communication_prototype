# iOS-Flutter Communication Prototype

This Flutter application demonstrates bi-directional communication between Flutter and native iOS code.

## Features

- Sends commands from Flutter to native iOS code
- Receives real-time data (random integers) generated on the iOS side
- Demonstrates the use of method channels for communication
- Multilingual support (English and Japanese)
- Clean architecture with BLoC pattern

## Demo

### Video Demonstration (YouTube Shorts)

<a href="https://www.youtube.com/shorts/4Lap_HX_JbE" target="_blank">
  <img src="https://img.youtube.com/vi/4Lap_HX_JbE/0.jpg" alt="[Watch Demo on YouTube](https://www.youtube.com/shorts/4Lap_HX_JbE)" width="270" height="480" />
</a>

👆 **Click the image above** to watch the short demo video showing the iOS-Flutter communication in action.

## Getting Started

### Prerequisites

- Flutter 3.0.0 or higher
- Xcode 13.0 or higher (for iOS builds)
- iOS 12.0+ device or simulator

### Installation

1. Clone this repository
2. Navigate to the project directory
3. Run `flutter pub get` to install dependencies
4. Run `flutter run -d iphone` to start the app on your connected device or simulator

## Project Structure

The project follows a clean architecture approach:

- `lib/src/bloc` - Business logic components using the BLoC patternv
- `lib/src/core` - Core utilities and constants
- `lib/src/localization` - Internationalization files
- `lib/src/navigator` - Navigation management
- `lib/src/view` - UI components and screens

## Communication Flow

1. Flutter initiates communication with iOS using method channels
2. iOS generates random integers and sends them back to Flutter
3. Flutter displays the received data in real-time

## Localization

The app supports both English and Japanese languages. The localization files are located in:
- `lib/src/localization/app_en.arb` (English)
- `lib/src/localization/app_ja.arb` (Japanese)

**Note:** After modifying any ARB files, run `flutter gen-l10n` to regenerate the localization files and make the changes available in the application.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
