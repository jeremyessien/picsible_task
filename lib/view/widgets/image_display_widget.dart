import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/image_picker_provider.dart';


class ImageDisplayWidget extends StatelessWidget {
  const ImageDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ImagePickerProvider>(
      builder: (context, provider, child) {
        final hasImage = provider.imageModel.hasImage;

        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 8,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                  );
                },
                child: hasImage
                    ? ImagePreview(
                  key: ValueKey(provider.imageModel.imageFile!.path),
                  imageFile: provider.imageModel.imageFile!,
                )
                    : ImagePlaceholder(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ImagePreview extends StatelessWidget {
  final File imageFile;

  const ImagePreview({
    super.key,
    required this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'image_preview',
      child: Image.file(
        imageFile,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.image,
          size: 80,
          color: Colors.grey.shade400,
        ),
        const SizedBox(height: 20),
        Text(
          'No image selected',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Tap one of the buttons below',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}