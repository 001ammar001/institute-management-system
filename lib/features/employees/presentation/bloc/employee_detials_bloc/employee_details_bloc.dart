import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';
import 'package:institute_management_system/features/employees/domain/entites/employee_entity.dart';
import 'package:institute_management_system/features/employees/domain/usecases/get_emloyee_data_usecase.dart';

part 'employee_details_event.dart';
part 'employee_details_state.dart';

class EmployeeDetailsBloc
    extends Bloc<EmployeeDetailsEvent, EmployeeDetailsStates> {
  final GetEmployeeDataUseCase getEmployeeDetail;

  EmployeeDetailsBloc({required this.getEmployeeDetail})
      : super(EmployeeDataLoadingState()) {
    on<GetEmployeeDetailEvent>((event, emit) async {
      emit(EmployeeDataLoadingState());
      final result = await getEmployeeDetail(event.id);
      result.fold(
        (l) => emit(
          EmployeeDataFailureState(message: mapFailureToMessage(l)),
        ),
        (r) => emit(EmployeeDataLoadedState(employee: r)),
      );
    });
  }
}
