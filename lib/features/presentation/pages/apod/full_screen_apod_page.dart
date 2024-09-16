import 'package:flutter/material.dart';
import 'package:nasa_apod/features/domain/entities/apod/apod_entity.dart';

class FullScreenApodPage extends StatelessWidget {
  final ApodEntity apod;

  const FullScreenApodPage({super.key, required this.apod});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Image.network(
          apod.url,
          fit: BoxFit.contain,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}