
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_apod/features/presentation/pages/apod/apod_page.dart';
import 'package:nasa_apod/features/domain/entities/apod/apod_entity.dart';
import 'package:nasa_apod/features/presentation/blocs/apod/apod_bloc.dart';
import 'package:nasa_apod/features/presentation/blocs/apod/apod_state.dart';
import 'package:nasa_apod/generated/l10n.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'apod_page_test.mocks.dart';

@GenerateMocks([ApodBloc])
void main() {
  group('ApodPage Widget Tests', () {
    late MockApodBloc mockApodBloc;
    setUp(() async {
      await S.load(const Locale.fromSubtags(languageCode: 'en'));
      mockApodBloc = MockApodBloc();
      when(mockApodBloc.stream).thenAnswer((v) => Stream.value(ApodInitial()));
    });

    tearDown(() {
      mockApodBloc.close();
    });

    testWidgets('Shows CircularProgressIndicator on ApodInitial', (WidgetTester tester) async {
      when(mockApodBloc.state).thenReturn(ApodInitial());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ApodBloc>(
            create: (_) => mockApodBloc,
            child: const ApodPage(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Shows CircularProgressIndicator on ApodLoading', (WidgetTester tester) async {
      when(mockApodBloc.state).thenReturn(ApodLoading());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ApodBloc>(
            create: (_) => mockApodBloc,
            child: const ApodPage(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Shows Image and Text on ApodLoaded', (WidgetTester tester) async {
      const mockApod = ApodEntity(title: 'Test Title', url: 'https://example.com/image.jpg');
      when(mockApodBloc.state).thenReturn(ApodLoaded(apod: mockApod));
      await mockNetworkImagesFor(
            () async {
          return await tester.pumpWidget(
            MaterialApp(
              home: BlocProvider<ApodBloc>(
                create: (_) => mockApodBloc,
                child: const ApodPage(),
              ),
            ),
          );
        },
      );
      expect(find.byType(Image), findsOneWidget);
      expect(find.text('"Test Title"'), findsOneWidget);
    });

    testWidgets('Shows error message on ApodError', (WidgetTester tester) async {
      when(mockApodBloc.state).thenReturn(ApodError(message: 'Error message'));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ApodBloc>(
            create: (_) => mockApodBloc,
            child: const ApodPage(),
          ),
        ),
      );

      expect(find.text('Error message'), findsOneWidget);
    });
  });
}

