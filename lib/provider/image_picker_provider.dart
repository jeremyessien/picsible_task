import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../model/image_model.dart';
import '../utils/permission_handler.dart';

class ImagePickerProvider extends ChangeNotifier {
  ImageModel _imageModel = ImageModel.empty();

  ImageModel get imageModel => _imageModel;

  final ImagePicker picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    try {
      if (Platform.isIOS) {
        await Permission.photos.request();
      } else {
        bool hasPermission = await PermissionUtils.isStoragePermissionGranted();

        if (!hasPermission) {
          hasPermission = await PermissionUtils.requestStoragePermission();

          if (!hasPermission) {
            updateImageModel(
              ImageModel.withError(
                'Gallery permission denied. Please enable it in app settings.',
              ),
            );
            return;
          }
        }
      }

      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile == null) {
        return;
      }

      updateImageModel(
        ImageModel(
          imageFile: File(pickedFile.path),
          source: ImageOrigin.gallery,
        ),
      );
    } catch (e) {
      updateImageModel(
        ImageModel.withError(
          'Error picking image from gallery: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      if (Platform.isIOS) {
        await Permission.camera.request();
      } else {
        bool hasPermission = await PermissionUtils.isCameraPermissionGranted();

        if (!hasPermission) {
          hasPermission = await PermissionUtils.requestCameraPermission();

          if (!hasPermission) {
            updateImageModel(
              ImageModel.withError(
                'Camera permission denied. Please enable it in app settings.',
              ),
            );
            return;
          }
        }
      }

      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile == null) {
        // User canceled the camera
        return;
      }

      updateImageModel(
        ImageModel(
          imageFile: File(pickedFile.path),
          source: ImageOrigin.camera,
        ),
      );
    } catch (e) {
      updateImageModel(
        ImageModel.withError(
          'Error picking image from camera: ${e.toString()}',
        ),
      );
    }
  }

  void clearImage() {
    updateImageModel(ImageModel.empty());
  }

  void updateImageModel(ImageModel newModel) {
    _imageModel = newModel;
    notifyListeners();
  }

  void clearError() {
    if (_imageModel.hasError) {
      updateImageModel(_imageModel.copyWith(errorMessage: ''));
    }
  }
}
