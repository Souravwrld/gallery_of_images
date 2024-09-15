import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_of_images/data_provider/remote_data_source.dart';
import 'package:gallery_of_images/home/bloc/image_bloc.dart';
import 'package:gallery_of_images/home/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageBloc(pixabayService: PixabayService()),
      child: MaterialApp(
          home: ImageGalleryScreen(), debugShowCheckedModeBanner: false),
    );
  }
}
