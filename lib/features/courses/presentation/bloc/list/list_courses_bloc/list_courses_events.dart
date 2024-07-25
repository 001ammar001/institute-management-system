part of "list_courses_bloc.dart";

abstract class ListCoursesEvents extends Equatable {
  const ListCoursesEvents();

  @override
  List<Object?> get props => [];
}

class CoursesEvents extends ListCoursesEvents {
  final int currentPage;
  const CoursesEvents({required this.currentPage});
  @override
  List<Object?> get props => [currentPage];
}

class NextPageEvent extends ListCoursesEvents {}

class PreviousPageEvent extends ListCoursesEvents {}

class CheckboxEvent extends ListCoursesEvents {}

class DeleteCourseEvent extends ListCoursesEvents {
  final int indexCourse;
  const DeleteCourseEvent({required this.indexCourse});
  @override
  List<Object?> get props => [indexCourse];
}

class ControlCoursesPageEvent extends ListCoursesEvents {}

class FilterCoursesListEvent extends ListCoursesEvents {
  final FiltersCourseModel coursesFilter2 ;

  const FilterCoursesListEvent({required this.coursesFilter2});

  @override
  List<Object?> get props => [coursesFilter2];

}
