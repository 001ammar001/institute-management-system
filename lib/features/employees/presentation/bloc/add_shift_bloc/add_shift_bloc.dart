import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';
import 'package:institute_management_system/features/employees/domain/entites/shift_entity.dart';
import 'package:institute_management_system/features/employees/domain/usecases/add_update_shift_usecase.dart';

part 'add_shift_event.dart';
part 'add_shift_state.dart';

class AddShiftBloc extends Bloc<AddUpdateShiftEvent, AddShiftStates> {
  final AddUpdateShiftUseCase addUpdateShift;
  AddShiftBloc({required this.addUpdateShift})
      : super(AddUpdateShiftInitialState()) {
    on<AddUpdateShiftEvent>((event, emit) async {
      emit(AddUpdateShiftLoadingState());
      final result = await addUpdateShift(event.shift);
      result.fold(
        (l) => emit(
          AddUpdateShiftFailureState(message: mapFailureToMessage(l)),
        ),
        (r) => emit(AddUpdateShiftSucessState()),
      );
    });
  }
}
