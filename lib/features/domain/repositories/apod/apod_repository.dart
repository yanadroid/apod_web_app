
import 'package:dartz/dartz.dart';
import 'package:nasa_apod/core/error/failure.dart';
import 'package:nasa_apod/features/domain/entities/apod/apod_entity.dart';

abstract class ApodRepository {
  Future<Either<Failure, ApodEntity>> getApod();
}
