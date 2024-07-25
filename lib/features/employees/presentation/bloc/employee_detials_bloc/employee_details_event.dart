part of 'employee_details_bloc.dart';

sealed class EmployeeDetailsEvent extends Equatable {
  const EmployeeDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetEmployeeDetailEvent extends EmployeeDetailsEvent {
  final int id;

  const GetEmployeeDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}
