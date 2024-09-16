
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:nasa_apod/features/domain/entities/apod/apod_entity.dart';
import 'package:nasa_apod/features/domain/usecases/apod/get_apod.dart';

import 'package:nasa_apod/core/error/failure.dart';
import 'package:nasa_apod/features/presentation/blocs/apod/apod_bloc.dart';
import 'package:nasa_apod/features/presentation/blocs/apod/apod_event.dart';
import 'package:nasa_apod/features/presentation/blocs/apod/apod_state.dart';

import 'apod_bloc_test.mocks.dart';


@GenerateMocks([GetApod])
void main() {
  late ApodBloc bloc;
  late MockGetApod mockGetApod;

  setUp(() {
    mockGetApod = MockGetApod();
    bloc = ApodBloc(getApod: mockGetApod);
  });

  blocTest(
    'Emits [ApodLoading, ApodLoaded] when successful',
    build: () {
      when(mockGetApod()).thenAnswer((value) async => const Right(ApodEntity(title: 'Test Title', url: 'test.jpg')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetApodEvent()),
    expect: () => [
      ApodLoading(),
      ApodLoaded(apod: const ApodEntity(title: 'Test Title', url: 'test.jpg'))],
    verify: (bloc) {
      verify(mockGetApod());
    },
  );

  blocTest<ApodBloc, ApodState>(
    'Should emits ApodLoading and ApodError when no internet connection',
    build: () {
      when(mockGetApod()).thenAnswer((value) async => const Left(Failure('No internet connection')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetApodEvent()),
    expect: () => [
      ApodLoading(),
      ApodError(message: 'No internet connection'),
    ],
    verify: (bloc) {
      verify(mockGetApod());
    },
  );
}
