import 'package:flutter/material.dart';

abstract class ImageService {
  Future<FutureBuilder<Widget>> getImageUrl(String path);
}
