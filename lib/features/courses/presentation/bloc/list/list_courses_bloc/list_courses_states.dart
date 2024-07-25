part of "list_courses_bloc.dart";

abstract class ListCoursesStates  {}

class ListCoursesInitialState extends ListCoursesStates {}

class PageChangedState extends ListCoursesStates {}

class DeleteCourseState extends ListCoursesStates {}

class ChangeCounterState extends ListCoursesStates {}

final class ListCoursesSuccessState extends ListCoursesStates {
  final CourseModelList courses;
  ListCoursesSuccessState(this.courses);
}

final class ListCoursesLoadingState extends ListCoursesStates {}

class ListCoursesFailureState extends ListCoursesStates {
  final String message;

  ListCoursesFailureState({required this.message});
}

class DeleteCoursesFailureState extends ListCoursesStates {
  final String message;

  DeleteCoursesFailureState({required this.message});
}

class DeleteCoursesSuccessState extends ListCoursesStates {}
