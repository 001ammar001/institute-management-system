part of "list_teachers_bloc.dart";

abstract class ListTeachersStates {}

class ListTeachersInitialState extends ListTeachersStates {}

class PageChangedState extends ListTeachersStates {}

class DeleteTeacherState extends ListTeachersStates {}

class ChangeCounterState extends ListTeachersStates {}

final class ListTeachersSuccessState extends ListTeachersStates {
  final TeacherModelList teachers;
  ListTeachersSuccessState(this.teachers);
}

final class ListTeachersLoadingState extends ListTeachersStates {}

class ListTeachersFailureState extends ListTeachersStates {
  final String message;

  ListTeachersFailureState({required this.message});
}

class DeleteTeachersSuccessState extends ListTeachersStates {}

class DeleteTeachersFailureState extends ListTeachersStates {
  final String message;

  DeleteTeachersFailureState({required this.message});
}
