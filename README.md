# Simple Image Upload App

A Flutter application that allows users to upload an image from their device (gallery or camera) and display a preview. This app demonstrates core mobile functionality including permission handling, image selection, and state management.

## Features

- Select images from device gallery
- Capture images using the camera
- Display image preview with smooth animations
- Clear selected images
- Proper permission handling for iOS and Android
- Error handling with user-friendly messages
- Clean, modern user interface with subtle animations

## Implementation Details

This application is built using:

- **Flutter** for cross-platform development
- **Provider Pattern** for state management
- **Permission Handler** for managing device permissions
- **Image Picker** for accessing gallery and camera

The project follows a clean architecture with separate components for:
- Data models
- State management providers
- UI components
- Platform-specific permission handling

## Dependencies

The following packages are used in this project:

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.5        # For state management
  image_picker: ^1.0.4    # For picking images from gallery/camera
  permission_handler: ^11.0.0  # For handling permissions
```

## Setup Instructions

### Prerequisites

- Flutter SDK (latest stable version)
- Android Studio / Xcode for platform-specific development
- A physical device or emulator for testing

### Getting Started

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/simple_image_upload.git
   cd simple_image_upload
   ```

2. Install dependencies:
   ```
   flutter pub get
   ```

3. Run the app:
   ```
   flutter run
   ```

### Platform-Specific Configuration

#### Android

Make sure your AndroidManifest.xml contains the necessary permissions:

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
```

#### iOS

In your Info.plist, include the following permission descriptions:

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs access to your photo library to upload images.</string>
<key>NSCameraUsageDescription</key>
<string>This app needs access to your camera to take photos for upload.</string>
```

## Usage

1. Launch the app
2. Tap on "Gallery" to select an image from your device
3. Tap on "Camera" to capture a new image
4. The selected/captured image will be displayed in the preview area
5. Use the "Clear Image" button to remove the current image

## Error Handling

The app handles various error scenarios:
- Permission denials
- Image selection cancellations
- File access issues

Error messages are displayed as snackbars with clear instructions on how to resolve them.

## Project Structure

```
lib/
  ├── main.dart              # App entry point
  ├── models/
  │   └── image_model.dart   # Data model for images
  ├── providers/
  │   └── image_provider.dart # State management
  ├── screens/
  │   └── home_screen.dart   # Main screen
  ├── utils/
  │   └── permission_utils.dart # Permission handling utilities
  └── widgets/
      ├── image_display_widget.dart # Image preview
      ├── upload_button_widget.dart # Buttons for upload
      └── clear_button_widget.dart  # Button to clear image
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.
