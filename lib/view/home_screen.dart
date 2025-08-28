import 'package:flutter/material.dart';
import 'package:piscible_task/view/widgets/clear_button_widget.dart';
import 'package:piscible_task/view/widgets/image_display_widget.dart';
import 'package:piscible_task/view/widgets/upload_button_widget.dart';
import 'package:provider/provider.dart';

import '../provider/image_picker_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Image Uploader',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Consumer<ImagePickerProvider>(
        builder: (context, provider, child) {
          if (provider.imageModel.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(provider.imageModel.errorMessage!),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  action: SnackBarAction(
                    label: 'Dismiss',
                    textColor: Colors.white,
                    onPressed: () {
                      provider.clearError();
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  ),
                ),
              );

              provider.clearError();
            });
          }

          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 800),
                      builder: (context, double value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 20 * (1 - value)),
                            child: child,
                          ),
                        );
                      },
                      child: const Text(
                        'Select an image to upload',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 30),

                    Expanded(flex: 3, child: ImageDisplayWidget()),

                    const SizedBox(height: 30),

                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 1000),
                      builder: (context, double value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 30 * (1 - value)),
                            child: child,
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          UploadButtonWidget(
                            icon: Icons.photo_library,
                            label: 'Gallery',
                            onPressed: () => provider.pickImageFromGallery(),
                          ),
                          const SizedBox(width: 20),
                          UploadButtonWidget(
                            icon: Icons.camera_alt,
                            label: 'Camera',
                            onPressed: () => provider.pickImageFromCamera(),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    AnimatedOpacity(
                      opacity: provider.imageModel.hasImage ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child:
                          provider.imageModel.hasImage
                              ? ClearButtonWidget(
                                onPressed: () => provider.clearImage(),
                              )
                              : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
