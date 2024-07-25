part of 'add_student_bloc.dart';

sealed class AddStudentStates extends Equatable {
  const AddStudentStates();

  @override
  List<Object> get props => [];
}

final class AddStudentInitial extends AddStudentStates {}

final class StudentAddUpdateLoadingState extends AddStudentStates {}

final class StudentAddUpdateSucessState extends AddStudentStates {}

final class StudentAddUpdateFailureState extends AddStudentStates {
  final String message;

  const StudentAddUpdateFailureState({required this.message});
}
