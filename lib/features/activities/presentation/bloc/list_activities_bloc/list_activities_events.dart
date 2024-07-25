part of "list_activity_bloc.dart";

abstract class ListActivitiesEvents extends Equatable {
  const ListActivitiesEvents();

  @override
  List<Object?> get props => [];
}

class ActivitiesEvents extends ListActivitiesEvents {
  final int currentPage;
  const ActivitiesEvents({required this.currentPage});
  @override
  List<Object?> get props => [currentPage];
}

class NextPageEvent extends ListActivitiesEvents {}

class PreviousPageEvent extends ListActivitiesEvents {}

class CheckboxEvent extends ListActivitiesEvents {}

class DeleteActivityEvent extends ListActivitiesEvents {
  final int indexActivity;
  const DeleteActivityEvent({required this.indexActivity});
  @override
  List<Object?> get props => [indexActivity];
}

class ControlActivitiesPageEvent extends ListActivitiesEvents {}

class FilterActivitiesListEvent extends ListActivitiesEvents {
  final FiltersActivityModel activitiesFilter2 ;

  const FilterActivitiesListEvent({required this.activitiesFilter2});

  @override
  List<Object?> get props => [activitiesFilter2];

}
