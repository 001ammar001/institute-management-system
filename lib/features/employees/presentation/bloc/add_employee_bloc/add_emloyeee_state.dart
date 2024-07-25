part of 'add_employee_bloc.dart';

sealed class AddEmployeetates extends Equatable {
  const AddEmployeetates();

  @override
  List<Object> get props => [];
}

final class AddUpdateEmployeeInitialState extends AddEmployeetates {}

final class AddUpdateEmployeeLoadingState extends AddEmployeetates {}

final class AddUpdateEmployeeFailureState extends AddEmployeetates {
  final String message;

  const AddUpdateEmployeeFailureState({required this.message});
}

final class AddUpdateEmployeeSucessState extends AddEmployeetates {}
