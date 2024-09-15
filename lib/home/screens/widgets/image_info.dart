import 'package:flutter/material.dart';
import 'package:gallery_of_images/home/model/image_model.dart';

class ImageInfoWidget extends StatelessWidget {
  final ImageModel image;

  const ImageInfoWidget({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${image.likes} Likes'),
          Text('${image.views} Views'),
        ],
      ),
    );
  }
}
