import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final Map<String, dynamic>? data;
  final int? statusCode;

  const Failure(
    this.message, {
    this.statusCode,
    this.data,
  });

  @override
  List<Object?> get props => [message, statusCode, data];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.statusCode});
}

class AddToFavoriteFailure extends Failure {
  const AddToFavoriteFailure(super.message, {super.statusCode, super.data});
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class SliderFailure extends Failure {
  const SliderFailure(super.message);
}

class SearchForMeFailure extends Failure {
  const SearchForMeFailure(super.message);
}
