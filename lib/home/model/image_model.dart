class ImageModel {
  final String id;
  final String imageUrl;
  final int likes;
  final int views;

  ImageModel({
    required this.id,
    required this.imageUrl,
    required this.likes,
    required this.views,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'].toString(),
      imageUrl: json['webformatURL'],
      likes: json['likes'],
      views: json['views'],
    );
  }

  // Optional: toJson method if you need to serialize data back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'webformatURL': imageUrl,
      'likes': likes,
      'views': views,
    };
  }
}
