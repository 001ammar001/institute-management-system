part of "list_students_bloc.dart";

abstract class ListStudentsStates {}

class ListStudentsInitialState extends ListStudentsStates {}

class PageChangedState extends ListStudentsStates {}

class DeleteStudentState extends ListStudentsStates {}

class ChangeCounterState extends ListStudentsStates {}

final class ListStudentsSuccessState extends ListStudentsStates {
  final StudentModelList students;
  ListStudentsSuccessState(this.students);
}

final class ListStudentsLoadingState extends ListStudentsStates {}

class ListStudentsFailureState extends ListStudentsStates {
  final String message;

  ListStudentsFailureState({required this.message});
}

final class ListStudentsPieceSuccessState extends ListStudentsStates {
  final StudentModelList students;
  ListStudentsPieceSuccessState(this.students);
}

final class ListStudentsPieceLoadingState extends ListStudentsStates {}

class ListStudentsPieceFailureState extends ListStudentsStates {
  final String message;

  ListStudentsPieceFailureState({required this.message});
}

class DeleteStudentsSucessState extends ListStudentsStates {}

class DeleteStudentsFailureState extends ListStudentsStates {
  final String message;

  DeleteStudentsFailureState({required this.message});
}
