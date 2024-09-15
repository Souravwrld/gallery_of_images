import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_of_images/home/bloc/image_bloc.dart';
import 'package:gallery_of_images/home/screens/widgets/image_grid.dart';
import 'package:gallery_of_images/home/screens/widgets/search_field.dart';

class ImageGalleryScreen extends StatefulWidget {
  @override
  State<ImageGalleryScreen> createState() => _ImageGalleryScreenState();
}

class _ImageGalleryScreenState extends State<ImageGalleryScreen> {
  @override
  void initState() {
    context.read<ImageBloc>().add(FetchImages());
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount =
        screenWidth > 600 ? 4 : 2; // Adjust column count based on screen width

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Gallery'),
        backgroundColor: Colors.white10,
      ),
      body: Column(
        children: [
          const SearchField(),
          Expanded(
            child: BlocBuilder<ImageBloc, ImageState>(
              builder: (context, state) {
                if (state is ImageLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ImageLoaded) {
                  return LayoutBuilder(builder: (context, constraints) {
                    int crossAxisCount =
                        (constraints.maxWidth ~/ 150).clamp(2, 4);
                    return ImageGrid(
                      images: state.images,
                      crossAxisCount: crossAxisCount,
                    );
                  });
                } else if (state is ImageError) {
                  return const Center(child: Text('Failed to load images'));
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
