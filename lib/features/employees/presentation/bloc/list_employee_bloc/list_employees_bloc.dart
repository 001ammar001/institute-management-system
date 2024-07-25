import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/Errors/error_message_mapper.dart';
import '../../../data/models/employee_model_list.dart';
import '../../../domain/usecases/delete_employee_usecase.dart';
import '../../../domain/usecases/fetch_employees_usecase.dart';

part "list_employees_events.dart";

part "list_employees_states.dart";

class ListEmployeesBloc extends Bloc<ListEmployeesEvents, ListEmployeesStates> {
  final FetchEmployeesUseCase fetchEmployeesUseCase;
  final DeleteEmployeeUseCase deleteEmployeeUseCase;
  EmployeeModelList employees = EmployeeModelList();

  String failureText = 'error';
  int currentPage = 1;
  int stateButtonArrowForwardEmployee = 0;
  int stateButtonArrowBackEmployee = 0;
  int stateButtonDeleteEmployee = 0;

  ListEmployeesBloc({required this.fetchEmployeesUseCase, required this.deleteEmployeeUseCase})
      : super(ListEmployeesInitialState()) {
    on<EmployeesEvents>(_getEmployeesAll);
    on<CheckboxEvent>(_checkboxControl);
    on<DeleteEmployeeEvent>(_deleteEmployee);
  }

  FutureOr<void> _getEmployeesAll(EmployeesEvents event,
      Emitter<ListEmployeesStates> emit) async {
    emit(ListEmployeesLoadingState());
    final result = await fetchEmployeesUseCase.call(
        pageNumber: event.currentPage);
    result.fold(
            (failure) =>
            emit(
              ListEmployeesFailureState(message: mapFailureToMessage(failure)),
            ), (listEmployee) {
              employees=listEmployee;
      emit(ListEmployeesSuccessState(listEmployee));
    });
  }

  FutureOr<void> _checkboxControl(CheckboxEvent event,
      Emitter<ListEmployeesStates> emit) async {
    emit(PageChangedState());
  }

  FutureOr<void> _deleteEmployee(DeleteEmployeeEvent event,
      Emitter<ListEmployeesStates> emit) async {
    emit(ListEmployeesLoadingState());
   final result = await deleteEmployeeUseCase.call(event.indexEmployee);
    result.fold(
            (failure) =>
            emit(
              DeleteEmployeesFailureState(message: mapFailureToMessage(failure)),
            ), (delete) {

      employees.data!.removeWhere((employee) => employee.id == event.indexEmployee);
    });
  }
}




