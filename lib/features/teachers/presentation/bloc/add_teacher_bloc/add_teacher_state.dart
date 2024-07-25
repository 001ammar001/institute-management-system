part of 'add_teacher_bloc.dart';

sealed class AddTeacherStates extends Equatable {
  const AddTeacherStates();

  @override
  List<Object> get props => [];
}

final class AddTeacherInitial extends AddTeacherStates {}

final class TeacherAddUpdateLoadingState extends AddTeacherStates {}

final class TeacherAddUpdateSucessState extends AddTeacherStates {}

final class TeacherAddUpdateFailureState extends AddTeacherStates {
  final String message;

  const TeacherAddUpdateFailureState({required this.message});
}
