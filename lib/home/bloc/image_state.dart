part of 'image_bloc.dart';

@immutable
sealed class ImageState {}

final class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  final List<ImageModel> images;
  final bool hasReachedMax;

  ImageLoaded({
    required this.images,
    required this.hasReachedMax,
  });
}

class ImageError extends ImageState {
  final String error;

  ImageError({required this.error});

  @override
  List<Object?> get props => [error];
}
