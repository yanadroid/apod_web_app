import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_apod/features/domain/usecases/apod/get_apod.dart';

import 'apod_event.dart';
import 'apod_state.dart';

class ApodBloc extends Bloc<ApodEvent, ApodState> {
  final GetApod getApod;

  ApodBloc({required this.getApod}) : super(ApodInitial()) {
    on<GetApodEvent>((event, emit) async {
      emit(ApodLoading());
      final failureOrApod = await getApod();
      failureOrApod.fold(
            (failure) => emit(ApodError(message: failure.message)),
            (apod) => emit(ApodLoaded(apod: apod)),
      );
    });
  }
}
