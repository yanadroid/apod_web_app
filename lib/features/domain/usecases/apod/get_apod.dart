import 'package:dartz/dartz.dart';
import 'package:nasa_apod/core/error/failure.dart';
import 'package:nasa_apod/core/usecase/usecase.dart';
import 'package:nasa_apod/features/domain/entities/apod/apod_entity.dart';
import 'package:nasa_apod/features/domain/repositories/apod/apod_repository.dart';

class GetApod implements UseCase<Either<Failure, ApodEntity>, void> {
  final ApodRepository repository;

  GetApod(this.repository);

  @override
  Future<Either<Failure, ApodEntity>> call({void params}) async {
    return await repository.getApod();
  }

}
