import 'package:equatable/equatable.dart';

class ApodEntity extends Equatable {
  final String title;
  final String url;

  const ApodEntity({required this.title, required this.url});

  @override
  List<Object?> get props => [title, url];

}
