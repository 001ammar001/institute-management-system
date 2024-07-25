part of 'employee_details_bloc.dart';

sealed class EmployeeDetailsStates extends Equatable {
  const EmployeeDetailsStates();

  @override
  List<Object> get props => [];
}

final class EmployeeDataLoadedState extends EmployeeDetailsStates {
  final EmployeeEntity employee;

  const EmployeeDataLoadedState({required this.employee});
}

final class EmployeeDataLoadingState extends EmployeeDetailsStates {}

final class EmployeeDataFailureState extends EmployeeDetailsStates {
  final String message;

  const EmployeeDataFailureState({required this.message});
}
