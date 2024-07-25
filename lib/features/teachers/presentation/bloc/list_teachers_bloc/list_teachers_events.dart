part of "list_teachers_bloc.dart";

abstract class ListTeachersEvents extends Equatable {
  const ListTeachersEvents();

  @override
  List<Object?> get props => [];
}

class TeachersEvents extends ListTeachersEvents {
  final int currentPage;
  const TeachersEvents({required this.currentPage});
  @override
  List<Object?> get props => [currentPage];
}

class NextPageEvent extends ListTeachersEvents {}

class PreviousPageEvent extends ListTeachersEvents {}

class CheckboxEvent extends ListTeachersEvents {}

class DeleteTeacherEvent extends ListTeachersEvents {
  final int indexTeacher;
  const DeleteTeacherEvent({required this.indexTeacher});
  @override
  List<Object?> get props => [indexTeacher];
}

class ControlTeachersPageEvent extends ListTeachersEvents {}

class FilterTeachersListEvent extends ListTeachersEvents {
  final FiltersTeacherModel teachersFilter2 ;

  const FilterTeachersListEvent({required this.teachersFilter2});

  @override
  List<Object?> get props => [teachersFilter2];

}
