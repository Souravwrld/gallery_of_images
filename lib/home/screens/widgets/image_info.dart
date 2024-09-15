import 'package:flutter/material.dart';
import 'package:gallery_of_images/home/model/image_model.dart';

class ImageInfoWidget extends StatelessWidget {
  final ImageModel image;

  const ImageInfoWidget({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              '${image.likes} Likes',
              style: const TextStyle(
                fontSize: 12,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Flexible(
            child: Text(
              '${image.views} Views',
              style: const TextStyle(
                fontSize: 12,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
