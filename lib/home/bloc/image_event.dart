part of 'image_bloc.dart';

@immutable
sealed class ImageEvent {}

class FetchImages extends ImageEvent {}

class SearchImages extends ImageEvent {
  final String query;

  SearchImages({required this.query});
}

class LoadMoreImages extends ImageEvent {}
