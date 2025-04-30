import 'dart:io';


class ImageModel {

  final File? imageFile;


  final String? errorMessage;


  final ImageOrigin source;


  const ImageModel({
    this.imageFile,
    this.errorMessage,
    this.source = ImageOrigin.none,
  });


  ImageModel copyWith({
    File? imageFile,
    String? errorMessage,
    ImageOrigin? source,
  }) {
    return ImageModel(
      imageFile: imageFile ?? this.imageFile,
      errorMessage: errorMessage ?? this.errorMessage,
      source: source ?? this.source,
    );
  }


  factory ImageModel.empty() {
    return const ImageModel();
  }


  factory ImageModel.withError(String message) {
    return ImageModel(errorMessage: message);
  }


  bool get hasImage => imageFile != null;


  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;
}


enum ImageOrigin {
  camera,
  gallery,
  none,
}