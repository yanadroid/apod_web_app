import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_apod/core/http_service/http_service.dart';
import 'package:nasa_apod/features/data/data_sources/remote/apod_remote_data_source.dart';
import 'package:nasa_apod/features/data/models/apod_model.dart';
import 'package:nasa_apod/generated/l10n.dart';

import 'apod_remote_data_source_test.mocks.dart';

@GenerateMocks([HttpService, Dio])
void main() {
  group('ApodRemoteDataSourceImpl', () {
    late MockDio mockDio;
    late MockHttpService mockHttpService;
    late ApodRemoteDataSourceImpl apodRemoteDataSource;

    setUp(() async {
      await S.load(const Locale.fromSubtags(languageCode: 'en'));
      mockDio = MockDio();
      mockHttpService = MockHttpService();
      when(mockHttpService.client).thenReturn(mockDio);
      apodRemoteDataSource = ApodRemoteDataSourceImpl(client: mockHttpService);
    });

    test('should return ApodModel when the response status code is 200', () async {
      final response = Response(
        data: {'title': 'Test', 'url': 'Test description'}, // Mocked response data
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(mockDio.get(
        any,
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => response);

      final result = await apodRemoteDataSource.getApod();
      expect(result, isA<ApodModel>());
    });

    test('should throw an exception when the response status code is not 200', () async {
      final response = Response(
        data: {},
        statusCode: 404,
        requestOptions: RequestOptions(path: ''),
      );

      when(mockDio.get(
        any,
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => response);

      expect(() => apodRemoteDataSource.getApod(), throwsException);
    });
  });
}
