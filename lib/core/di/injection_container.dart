import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:nasa_apod/core/http_service/http_service.dart';
import 'package:nasa_apod/features/data/data_sources/remote/apod_remote_data_source.dart';
import 'package:nasa_apod/features/data/repositories/apod_repository_impl.dart';
import 'package:nasa_apod/features/domain/repositories/apod/apod_repository.dart';
import 'package:nasa_apod/features/domain/usecases/apod/get_apod.dart';
import 'package:nasa_apod/features/presentation/blocs/apod/apod_bloc.dart';


final sl = GetIt.instance;

void init() {
  // Blocs
  sl.registerFactory(() => ApodBloc(getApod: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetApod(sl()));

  // Repository
  sl.registerLazySingleton<ApodRepository>(() => ApodRepositoryImpl(remoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<ApodRemoteDataSource>(() => ApodRemoteDataSourceImpl(client: sl()));

  // External
  sl.registerLazySingleton(() => HttpService(Dio()));
}
