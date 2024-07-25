part of 'student_details_bloc.dart';

sealed class StudentDetailsStates extends Equatable {
  const StudentDetailsStates();

  @override
  List<Object> get props => [];
}

final class StudentDataLoadedState extends StudentDetailsStates {
  final StudentEnity student;

  const StudentDataLoadedState({required this.student});
}

final class StudentDataLoadingState extends StudentDetailsStates {}

final class StudentDataFailureState extends StudentDetailsStates {
  final String message;

  const StudentDataFailureState({required this.message});
}
