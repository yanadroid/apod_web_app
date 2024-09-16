import 'package:nasa_apod/features/domain/entities/apod/apod_entity.dart';

class ApodModel {
  final String title;
  final String url;

  ApodModel({required this.title, required this.url});

  factory ApodModel.fromJson(Map<String, dynamic> json) {
    return ApodModel(
      title: json['title'],
      url: json['url'],
    );
  }

  ApodEntity toEntity() {
    return ApodEntity(title: title, url: url);
  }
}
