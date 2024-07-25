part of "list_students_bloc.dart";

abstract class ListStudentsEvents extends Equatable {
  const ListStudentsEvents();

  @override
  List<Object?> get props => [];
}

class StudentEventsWithoutPagination extends ListStudentsEvents {
  const StudentEventsWithoutPagination();
  @override
  List<Object?> get props => [];
}

class StudentsEvents extends ListStudentsEvents {
  final int currentPage;

  const StudentsEvents({
    required this.currentPage,
  });
  @override
  List<Object?> get props => [currentPage];
}

class StudentsRegisterEvents extends ListStudentsEvents {
  final int currentPage;
  final String? nameStudent;
  const StudentsRegisterEvents({
    required this.currentPage,
    this.nameStudent,
  });
  @override
  List<Object?> get props => [currentPage, nameStudent];
}

class NextPageEvent extends ListStudentsEvents {}

class PreviousPageEvent extends ListStudentsEvents {}

class CheckboxEvent extends ListStudentsEvents {}

class DeleteStudentEvent extends ListStudentsEvents {
  final int indexStudent;
  const DeleteStudentEvent({required this.indexStudent});
  @override
  List<Object?> get props => [indexStudent];
}

class ControlStudentsPageEvent extends ListStudentsEvents {}

class FilterStudentsListEvent extends ListStudentsEvents {
  final FiltersStudentModel studentsFilter2;

  const FilterStudentsListEvent({required this.studentsFilter2});

  @override
  List<Object?> get props => [studentsFilter2];
}
