part of 'add_employee_bloc.dart';

sealed class AddUpdateEmployeeEvents extends Equatable {
  const AddUpdateEmployeeEvents();
}

class AddUpdateEmployeeEvent extends AddUpdateEmployeeEvents {
  final EmployeeEntity employeeEntity;

  const AddUpdateEmployeeEvent({required this.employeeEntity});

  @override
  List<Object> get props => [employeeEntity];
}
