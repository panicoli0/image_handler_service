import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_handler_service/presentation/utils/i_image_service.dart';

class ImageServiceImpl implements ImageService {
  @override
  Future<FutureBuilder<Widget>> getImageUrl(
    String url,
  ) {
    // Logic to load images
    if (url.startsWith('http') || url.startsWith('https')) {
      //is network image
      if (url.endsWith('.svg')) {
        return _loadSvgNetworkImage(url);
      } else {
        // load local svg image
        //return _loadRasterNetworkImage(url);
      }
    }
    return Future.value(
      FutureBuilder<Widget>(
          future: Future.value(
            getDefaultImage(),
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!;
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}

Future<FutureBuilder<Widget>> _loadSvgNetworkImage(String url) async {
  // Logic to load SVG network image
  return Future.value(
    FutureBuilder<Widget>(
        future: Future.value(SvgPicture.network(
          url,
          placeholderBuilder: (context) => const CircularProgressIndicator(),
        )),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!;
          } else {
            return getDefaultImage();
          }
        }),
  );
}

Widget getDefaultImage() {
  return SvgPicture.asset(
    'assets/images/placeholder.svg',
    placeholderBuilder: (context) => const CircularProgressIndicator(),
  );
}
