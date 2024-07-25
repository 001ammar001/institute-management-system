part of "shits_list_bloc.dart";

abstract class ShiftListEvents extends Equatable {
  const ShiftListEvents();

  @override
  List<Object?> get props => [];
}

class GetShiftsEvent extends ShiftListEvents {}

class CheckboxEvent extends ShiftListEvents {}

class DeleteShiftEvent extends ShiftListEvents {
  final int shiftId;
  const DeleteShiftEvent({required this.shiftId});
  @override
  List<Object?> get props => [shiftId];
}
