part of 'student_course_bloc.dart';

sealed class StudentCourseState extends Equatable {
  const StudentCourseState();

  @override
  List<Object> get props => [];
}

final class StudentCourseInitial extends StudentCourseState {}

final class StudentCourseLoading extends StudentCourseState {}

final class StudentCourseSuccess extends StudentCourseState {
  final StudentCourseModelList studentCourseModelList;
  const StudentCourseSuccess(this.studentCourseModelList);
}

final class StudentCourseFailure extends StudentCourseState {
  final String message;
  StudentCourseFailure(this.message);
}
