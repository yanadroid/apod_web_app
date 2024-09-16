import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:nasa_apod/features/domain/entities/apod/apod_entity.dart';
import 'package:nasa_apod/features/presentation/pages/apod/full_screen_apod_page.dart';
import 'package:network_image_mock/network_image_mock.dart';


@GenerateMocks([NavigatorObserver])
void main() {
  late ApodEntity apodEntity;

  setUp(() {
    apodEntity = const ApodEntity(
      url: 'https://example.com/image.jpg',
      title: 'Mock Title',
    );
  });

  testWidgets('Displays image with correct URL', (WidgetTester tester) async {

    await mockNetworkImagesFor(
          () async {
        return await tester.pumpWidget(
          MaterialApp(
            home: FullScreenApodPage(apod: apodEntity),
          ),
        );
      },
    );
    expect(find.byType(Image), findsOneWidget);

    final networkImage = tester.widget<Image>(find.byType(Image));
    expect((networkImage.image as NetworkImage).url, equals(apodEntity.url));
  });
}

