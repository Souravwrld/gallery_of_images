import 'package:dio/dio.dart';
import 'package:gallery_of_images/home/model/image_model.dart';

class PixabayService {
  final Dio _dio = Dio();
  final String _apiKey = '45983491-e245d06f729af57a6ad5b1b0b';
  final String _baseUrl = 'https://pixabay.com/api/';

  Future<List<ImageModel>> fetchImages(
      {required String query, required int page}) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'key': _apiKey,
          'q': query,
          'image_type': 'photo',
          'page': page,
          'per_page': 20, // Adjust this value based on your requirements
        },
      );

      List<dynamic> hits = response.data['hits'];
      return hits.map((imageData) => ImageModel.fromJson(imageData)).toList();
    } catch (error) {
      throw Exception('Failed to load images: $error');
    }
  }
}
