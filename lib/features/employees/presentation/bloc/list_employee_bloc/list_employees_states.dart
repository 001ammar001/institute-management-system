part of "list_employees_bloc.dart";

abstract class ListEmployeesStates  {

}

class ListEmployeesInitialState extends ListEmployeesStates {}

class PageChangedState extends ListEmployeesStates {}

class DeleteEmployeeState extends ListEmployeesStates {}

class ChangeCounterState extends ListEmployeesStates {}

final class ListEmployeesSuccessState extends ListEmployeesStates {
  final EmployeeModelList employees;
  ListEmployeesSuccessState(this.employees);
}

final class ListEmployeesLoadingState extends ListEmployeesStates {}

class ListEmployeesFailureState extends ListEmployeesStates {
  final String message;

   ListEmployeesFailureState({required this.message});
}

class DeleteEmployeesFailureState extends ListEmployeesStates {
  final String message;

  DeleteEmployeesFailureState({required this.message});
}




