import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';
import 'package:institute_management_system/features/employees/domain/entites/employee_entity.dart';
import 'package:institute_management_system/features/employees/domain/usecases/add_update_employee_usecase.dart';

part 'add_employee_event.dart';
part 'add_emloyeee_state.dart';

class AddEmployeeBloc extends Bloc<AddUpdateEmployeeEvents, AddEmployeetates> {
  final AddUpdateEmployeeUseCase addUpdateEmployeeUseCase;
  AddEmployeeBloc({
    required this.addUpdateEmployeeUseCase,
  }) : super(AddUpdateEmployeeInitialState()) {
    on<AddUpdateEmployeeEvent>((event, emit) async {
      emit(AddUpdateEmployeeLoadingState());
      final result = await addUpdateEmployeeUseCase(event.employeeEntity);
      result.fold(
        (l) => emit(
          AddUpdateEmployeeFailureState(message: mapFailureToMessage(l)),
        ),
        (r) => emit(AddUpdateEmployeeSucessState()),
      );
    });
   
  }
}
