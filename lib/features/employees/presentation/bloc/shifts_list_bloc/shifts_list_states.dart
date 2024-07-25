part of "shits_list_bloc.dart";

abstract class ShiftListStates {}

class PageChangedState extends ShiftListStates {}

final class ShiftListSuccessState extends ShiftListStates {}

final class ShiftListLoadingState extends ShiftListStates {}

class ShiftListFailureState extends ShiftListStates {
  final String message;

  ShiftListFailureState({required this.message});
}

class DeleteShiftFailureState extends ShiftListStates {
  final String message;

  DeleteShiftFailureState({required this.message});
}
