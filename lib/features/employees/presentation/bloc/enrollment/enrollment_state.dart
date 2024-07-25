part of 'enrollment_bloc.dart';

sealed class EnrollmentState extends Equatable {
  const EnrollmentState();

  @override
  List<Object> get props => [];
}

final class EnrollmentInitial extends EnrollmentState {}

final class AddingEnrollmentSucess extends EnrollmentState {}

final class AddingEnrollmentFailure extends EnrollmentState {
  final String message;
  const AddingEnrollmentFailure({required this.message});
}

final class AddingEnrollmentLoading extends EnrollmentState {}
