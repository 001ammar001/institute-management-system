part of "subjects_list_bloc.dart";

abstract class SubjectsListStates {}

class PageChangedState extends SubjectsListStates {}

final class SubjectsListSuccessState extends SubjectsListStates {}

final class SubjectsListLoadingState extends SubjectsListStates {}

class SubjectsListFailureState extends SubjectsListStates {
  final String message;

  SubjectsListFailureState({required this.message});
}

class DeleteSubjectFailureState extends SubjectsListStates {
  final String message;

  DeleteSubjectFailureState({required this.message});
}
