import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';
import 'package:institute_management_system/features/employees/domain/entites/shift_entity.dart';
import 'package:institute_management_system/features/employees/domain/usecases/get_shift_details.dart';

part 'shift_details_event.dart';
part 'shift_details_state.dart';

class ShiftDetailsBloc extends Bloc<ShiftDetailsEvent, ShiftDetailsStates> {
  final GetShiftDataUseCase getShiftData;
  ShiftDetailsBloc({required this.getShiftData})
      : super((ShiftDataLoadingState())) {
    on<GetShiftDetailEvent>((event, emit) async {
      emit(ShiftDataLoadingState());
      final result = await getShiftData(event.id);
      result.fold(
        (l) => emit(
          ShiftDataFailureState(message: mapFailureToMessage(l)),
        ),
        (r) => emit(ShiftDataLoadedState(shift: r)),
      );
    });
  }
}
