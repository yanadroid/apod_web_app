
import 'package:nasa_apod/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:nasa_apod/features/data/data_sources/remote/apod_remote_data_source.dart';
import 'package:nasa_apod/features/domain/entities/apod/apod_entity.dart';
import 'package:nasa_apod/features/domain/repositories/apod/apod_repository.dart';

class ApodRepositoryImpl implements ApodRepository {
  final ApodRemoteDataSource remoteDataSource;

  ApodRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ApodEntity>> getApod() async {
    try {
      final apod = await remoteDataSource.getApod();
      return Right(apod.toEntity());
    } catch (e) {
      return const Left(Failure('Failed to fetch APOD'));
    }
  }
}
