part of "job_title_list_bloc.dart";

abstract class JobTitleListStates {}

class PageChangedState extends JobTitleListStates {}

final class JobTitleListSuccessState extends JobTitleListStates {}

final class JobTitlteListLoadingState extends JobTitleListStates {}

class JobTitleListFailureState extends JobTitleListStates {
  final String message;

  JobTitleListFailureState({required this.message});
}

class DeleteJobTitleFailureState extends JobTitleListStates {
  final String message;

  DeleteJobTitleFailureState({required this.message});
}
