part of 'course_details_bloc.dart';

sealed class CourseDetailsEvent extends Equatable {
  const CourseDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetCourseDetailEvent extends CourseDetailsEvent {
  final int id;

  const GetCourseDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}
