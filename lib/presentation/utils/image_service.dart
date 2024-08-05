import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_handler_service/presentation/utils/i_image_service.dart';
import 'package:image_handler_service/utils/console_logger.dart';

class ImageServiceImpl implements ImageService {
  @override
  Future<FutureBuilder<Widget>> getImageUrl(
    String url,
  ) {
    // Logic to load images
    if (url.startsWith('http') || url.startsWith('https')) {
      //is svg network image
      if (url.endsWith('.svg')) {
        return _loadSvgNetworkImage(url);
      } else {
        // is raster network image
        return _loadRasterNetworkImage(url);
      }
    } else {
      // load local image
      if (url.endsWith('.svg')) {
        return _loadSvgLocalImage(url);
      } else {
        return _loadRasterLocalImage(url);
      }
    }
  }

  Future<FutureBuilder<Widget>> _loadSvgLocalImage(String url) {
    // Logic to load local svg image
    return Future.value(
      FutureBuilder<Widget>(
          future: Future.value(SvgPicture.asset(
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

  Future<FutureBuilder<Widget>> _loadRasterNetworkImage(String url) {
    // Logic to load raster network image
    return Future.value(
      FutureBuilder<Widget>(
          future: Future.value(
            Image.network(
              url,
              errorBuilder: (context, error, stackTrace) {
                console.log(
                  'NetworkImage: Error loading image: $url does not exist',
                  textColor: ColorizerTextColor.red,
                );
                return getDefaultImage();
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!;
            } else {
              return getDefaultImage();
            }
          }),
    );
  }

  Future<FutureBuilder<Widget>> _loadRasterLocalImage(String url) {
    // Logic to load raster local image
    return Future.value(
      FutureBuilder<Widget>(
          future: Future.value(
            Image.asset(
              url,
              errorBuilder: (context, error, stackTrace) {
                console.log(
                    'LocalImage: Error loading image: $url does not exist',
                    textColor: ColorizerTextColor.red);
                return getDefaultImage();
              },
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) {
                  return child;
                } else {
                  return AnimatedOpacity(
                    opacity: frame == null ? 0 : 1,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeOut,
                    child: child,
                  );
                }
              },
            ),
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!;
            } else {
              return getDefaultImage();
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
