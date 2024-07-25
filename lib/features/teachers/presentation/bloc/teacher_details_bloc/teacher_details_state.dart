part of 'teacher_details_bloc.dart';

sealed class TeacherDetailsStates extends Equatable {
  const TeacherDetailsStates();

  @override
  List<Object> get props => [];
}

final class TeacherDataLoadedState extends TeacherDetailsStates {
  final TeacherEntity teacher;

  const TeacherDataLoadedState({required this.teacher});
}

final class TeacherDataLoadingState extends TeacherDetailsStates {}

final class TeacherDataFailureState extends TeacherDetailsStates {
  final String message;

  const TeacherDataFailureState({required this.message});
}
