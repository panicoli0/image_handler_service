import 'package:flutter/material.dart';
import 'package:image_handler_service/presentation/utils/i_image_service.dart';

class ImageLoader {
  ImageLoader(this.imageService);

  final ImageService imageService;

  Widget loadImage({required String path}) {
    return FutureBuilder<Widget>(
      future: imageService.getImageUrl(path),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!;
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
