part of "list_activity_bloc.dart";

abstract class ListActivitiesStates  {

}

class ListActivitiesInitialState extends ListActivitiesStates {}

class PageChangedState extends ListActivitiesStates {}

class DeleteActivitiesState extends ListActivitiesStates {}

class ChangeCounterState extends ListActivitiesStates {}

final class ListActivitiesSuccessState extends ListActivitiesStates {
  final ActivityModelList activities;
  ListActivitiesSuccessState(this.activities);
}

final class ListActivitiesLoadingState extends ListActivitiesStates {}

class ListActivitiesFailureState extends ListActivitiesStates {
  final String message;

   ListActivitiesFailureState({required this.message});
}

class DeleteActivitiesFailureState extends ListActivitiesStates {
  final String message;

  DeleteActivitiesFailureState({required this.message});
}




