part of 'student_course_bloc.dart';

sealed class StudentCourseEvent extends Equatable {
  const StudentCourseEvent();

  @override
  List<Object> get props => [];
}

class GetStudentCourse extends StudentCourseEvent {
  final int id;
  const GetStudentCourse({required this.id});
}
