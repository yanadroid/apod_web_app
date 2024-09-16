import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_apod/features/domain/entities/apod/apod_entity.dart';
import 'package:nasa_apod/features/domain/repositories/apod/apod_repository.dart';
import 'package:nasa_apod/features/domain/usecases/apod/get_apod.dart';

import 'get_apod_test.mocks.dart';

@GenerateMocks([ApodRepository])
void main() {
  late GetApod usecase;
  late MockApodRepository mockApodRepository;

  setUp(() {
    mockApodRepository = MockApodRepository();
    usecase = GetApod(mockApodRepository);
  });

  const apod = ApodEntity(title: 'Test Title', url: 'test_url.jpg');

  test('Should return ApodEntity when the call is successful', () async {
    when(mockApodRepository.getApod()).thenAnswer((_) async => const Right(apod));

    final result = await usecase.call();

    expect(result, const Right(apod));
    verify(mockApodRepository.getApod());
    verifyNoMoreInteractions(mockApodRepository);
  });

  test('Should throw an exception when repository fails', () async {
    when(mockApodRepository.getApod()).thenThrow(Exception('Failed'));

    expect(() => usecase.call(), throwsA(isA<Exception>()));

    verify(mockApodRepository.getApod());
    verifyNoMoreInteractions(mockApodRepository);
  });
}
