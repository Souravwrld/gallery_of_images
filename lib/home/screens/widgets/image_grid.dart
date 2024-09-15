import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_of_images/home/bloc/image_bloc.dart';
import 'package:gallery_of_images/home/model/image_model.dart';
import 'package:gallery_of_images/home/screens/widgets/full_screen_image_view.dart';
import 'package:gallery_of_images/home/screens/widgets/image_info.dart';

class ImageGrid extends StatelessWidget {
  final List<ImageModel> images;
  final int crossAxisCount;

  const ImageGrid({
    Key? key,
    required this.images,
    required this.crossAxisCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.8,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          final image = images[index];

          // Detect when the user scrolls to the bottom and load more images
          if (index == images.length - 1) {
            context.read<ImageBloc>().add(LoadMoreImages());
          }

          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FullScreenImageView(image: image),
              ),
            ),
            child: Hero(
              tag: image.id,
              child: Column(
                children: [
                  Expanded(
                    child: CachedNetworkImage(
                      progressIndicatorBuilder: (context, url, progress) =>
                          Center(
                        child: CircularProgressIndicator(
                          value: progress.progress,
                        ),
                      ),
                      imageUrl: image.imageUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ImageInfoWidget(image: image),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
