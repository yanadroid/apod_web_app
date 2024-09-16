import 'package:equatable/equatable.dart';
import 'package:nasa_apod/features/domain/entities/apod/apod_entity.dart';

abstract class ApodState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ApodInitial extends ApodState {}

class ApodLoading extends ApodState { }

class ApodLoaded extends ApodState {
  final ApodEntity apod;

  ApodLoaded({required this.apod});

  @override
  List<Object?> get props => [apod.url, apod.title];
}

class ApodError extends ApodState {
  final String message;

  ApodError({required this.message});

  @override
  List<Object?> get props => [message];
}
