import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CachedNetworkImageWidget extends StatelessWidget {
  CachedNetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.fit,
    this.width,
    this.height,
  });
  String imageUrl;
  BoxFit? fit;
  double? width;
  double? height;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imageUrl,
      errorWidget: (context, url, error) =>
          Icon(Icons.broken_image, size: 50, color: Colors.grey),
      fit: fit,
    );
  }
}
