import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_apod/core/error/failure.dart';
import 'package:nasa_apod/features/data/data_sources/remote/apod_remote_data_source.dart';
import 'package:nasa_apod/features/data/models/apod_model.dart';
import 'package:nasa_apod/features/data/repositories/apod_repository_impl.dart';

import 'apod_repository_impl_test.mocks.dart';

@GenerateMocks([ApodRemoteDataSource])
void main() {
  group('ApodRepositoryImpl', () {
    late MockApodRemoteDataSource mockRemoteDataSource;
    late ApodRepositoryImpl apodRepository;

    setUp(() {
      mockRemoteDataSource = MockApodRemoteDataSource();
      apodRepository = ApodRepositoryImpl(remoteDataSource: mockRemoteDataSource);
    });

    test('should return an ApodEntity when remote data source returns ApodModel', () async {
      final apodModel = ApodModel(title: 'title', url: 'url');
      final apodEntity = apodModel.toEntity();
      when(mockRemoteDataSource.getApod()).thenAnswer((_) async => apodModel);
      final result = await apodRepository.getApod();
      expect(result, equals(Right(apodEntity)));
    });

    test('should return a Failure when remote data source throws an exception', () async {
      when(mockRemoteDataSource.getApod()).thenThrow((_) async => Exception('Failed to fetch APOD'));
      final result = await apodRepository.getApod();
      expect(result, equals(const Left(Failure('Failed to fetch APOD'))));
    });
  });
}
