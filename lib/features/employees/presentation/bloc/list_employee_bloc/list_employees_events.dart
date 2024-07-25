part of "list_employees_bloc.dart";

abstract class ListEmployeesEvents extends Equatable {
  const ListEmployeesEvents();

  @override
  List<Object?> get props => [];
}

class EmployeesEvents extends ListEmployeesEvents {
  final int currentPage;
  const EmployeesEvents({required this.currentPage});
  @override
  List<Object?> get props => [currentPage];
}

class NextPageEvent extends ListEmployeesEvents {}

class PreviousPageEvent extends ListEmployeesEvents {}

class CheckboxEvent extends ListEmployeesEvents {}

class DeleteEmployeeEvent extends ListEmployeesEvents {
  final int indexEmployee;
  const DeleteEmployeeEvent({required this.indexEmployee});
  @override
  List<Object?> get props => [indexEmployee];
}

class ControlEmployeesPageEvent extends ListEmployeesEvents {}
