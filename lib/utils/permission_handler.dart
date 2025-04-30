import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static Future<bool> requestCameraPermission() async {
    if (Platform.isIOS) {
      final status = await Permission.camera.request();
      return status.isGranted;
    } else {
      final status = await Permission.camera.request();
      return status.isGranted;
    }
  }

  static Future<bool> requestStoragePermission() async {
    if (Platform.isIOS) {
      final status = await Permission.photos.request();

      return status.isGranted;
    } else {
      final status = await Permission.storage.request();
      return status.isGranted;
    }
  }

  static Future<bool> isCameraPermissionGranted() async {
    return await Permission.camera.isGranted;
  }

  static Future<bool> isStoragePermissionGranted() async {
    return await Permission.photos.isGranted;
  }

  static Future<bool> openAppSettings() async {
    return await openAppSettings();
  }
}
