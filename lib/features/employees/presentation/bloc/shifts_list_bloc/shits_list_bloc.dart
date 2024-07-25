import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/features/employees/domain/entites/list_entity.dart';
import 'package:institute_management_system/features/employees/domain/entites/shift_entity.dart';
import 'package:institute_management_system/features/employees/domain/usecases/delete_shift_usecase.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';
import 'package:institute_management_system/features/employees/domain/usecases/get_shifts_list_usecase.dart';

part "shifts_list_events.dart";

part "shifts_list_states.dart";

class ShiftListBloc extends Bloc<ShiftListEvents, ShiftListStates> {
  final GetShiftsListUseCase getShiftList;
  final DeleteShiftUseCase deleteShift;

  int currentPage = 1;
  ListEntity<ShiftEntity> shifts = ListEntity(maxPage: 1, entitys: []);

  ShiftListBloc({required this.getShiftList, required this.deleteShift})
      : super((ShiftListLoadingState())) {
    on<GetShiftsEvent>(_getJopsList);
    on<CheckboxEvent>(_checkboxControl);
    on<DeleteShiftEvent>(_deleteJob);
  }

  FutureOr<void> _getJopsList(
      GetShiftsEvent event, Emitter<ShiftListStates> emit) async {
    emit(ShiftListLoadingState());
    final result = await getShiftList(currentPage);
    result.fold((failure) {
      shifts = ListEntity(maxPage: 1, entitys: []);
      emit(ShiftListFailureState(message: mapFailureToMessage(failure)));
    }, (newShifts) {
      shifts = newShifts;
      emit(ShiftListSuccessState());
    });
  }

  FutureOr<void> _checkboxControl(
      CheckboxEvent event, Emitter<ShiftListStates> emit) async {
    emit(PageChangedState());
  }

  FutureOr<void> _deleteJob(
      DeleteShiftEvent event, Emitter<ShiftListStates> emit) async {
    emit(ShiftListLoadingState());
    final result = await deleteShift(event.shiftId);
    result.fold(
        (failure) => emit(
              DeleteShiftFailureState(message: mapFailureToMessage(failure)),
            ),
        (delete) {});
    add(GetShiftsEvent());
  }
}
