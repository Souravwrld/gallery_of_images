import 'package:bloc/bloc.dart';
import 'package:gallery_of_images/data_provider/remote_data_source.dart';
import 'package:gallery_of_images/home/model/image_model.dart';
import 'package:meta/meta.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final PixabayService pixabayService;
  int currentPage = 1;
  String currentQuery = '';
  bool isLoadingMore = false;

  ImageBloc({required this.pixabayService}) : super(ImageInitial()) {
    on<FetchImages>((event, emit) async {
      emit(ImageLoading());

      try {
        final images = await pixabayService.fetchImages(query: '', page: 1);
        emit(ImageLoaded(images: images, hasReachedMax: false));
        currentPage = 1;
        currentQuery = '';
      } catch (e) {
        emit(ImageError(error: e.toString()));
      }
    });

    on<SearchImages>((event, emit) async {
      emit(ImageLoading());

      try {
        currentQuery = event.query;
        final images =
            await pixabayService.fetchImages(query: currentQuery, page: 1);
        emit(ImageLoaded(images: images, hasReachedMax: false));
        currentPage = 1;
      } catch (e) {
        emit(ImageError(error: e.toString()));
      }
    });

    on<LoadMoreImages>((event, emit) async {
      if (isLoadingMore || state is! ImageLoaded) return;

      final currentState = state as ImageLoaded;

      if (currentState.hasReachedMax) return;

      isLoadingMore = true;
      try {
        currentPage += 1;
        final newImages = await pixabayService.fetchImages(
            query: currentQuery, page: currentPage);

        // If there are no more images to fetch
        if (newImages.isEmpty) {
          emit(ImageLoaded(images: currentState.images, hasReachedMax: true));
        } else {
          emit(ImageLoaded(
              images: currentState.images + newImages, hasReachedMax: false));
        }
      } catch (e) {
        emit(ImageError(error: e.toString()));
      } finally {
        isLoadingMore = false;
      }
    });
  }
}
