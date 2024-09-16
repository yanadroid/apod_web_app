import 'package:nasa_apod/core/http_service/http_service.dart';
import 'package:nasa_apod/features/data/models/apod_model.dart';
import 'package:nasa_apod/generated/l10n.dart';

abstract class ApodRemoteDataSource {
  Future<ApodModel> getApod();
}

class ApodRemoteDataSourceImpl implements ApodRemoteDataSource {
  final HttpService client;
  static const String _url = "https://api.nasa.gov/planetary/apod";

  ApodRemoteDataSourceImpl({required this.client});

  @override
  Future<ApodModel> getApod() async {
    final response = await client.client.get(
      _url,
      queryParameters: {'api_key': 'IHE6wfIXbhRbcJKIZQTcJt0MmvCPQffEa3Ox70ey'},
    );

    if (response.statusCode == 200 || response.statusCode == 202) {
      return ApodModel.fromJson(response.data);
    } else {
      throw Exception(S.current.error_apod_response);
    }
  }
}
