import 'package:flutter/material.dart';
import 'package:image_handler_service/presentation/utils/i_image_service.dart';
import 'package:image_handler_service/presentation/utils/image_loader.dart';
import 'package:image_handler_service/presentation/utils/image_service.dart';

class ImagesPage extends StatelessWidget {
  const ImagesPage({
    super.key,
    this.imageService,
  });

  final ImageService? imageService;

  @override
  Widget build(BuildContext context) {
    final imageLoader = ImageLoader(
      imageService ?? ImageServiceImpl(),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Images Page'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            imageLoader.loadImage(
              path: 'assets/images/acid.svg',
            ),
          ],
        ),
      ),
    );
  }
}
