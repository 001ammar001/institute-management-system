import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class NetworkFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class DataFailure extends Failure {
  final String message;

  DataFailure({required this.message});

  @override
  List<Object?> get props => [message];
}