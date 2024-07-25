part of 'add_shift_bloc.dart';

sealed class AddShiftStates extends Equatable {
  const AddShiftStates();

  @override
  List<Object> get props => [];
}

final class AddUpdateShiftInitialState extends AddShiftStates {}

final class AddUpdateShiftLoadingState extends AddShiftStates {}

final class AddUpdateShiftFailureState extends AddShiftStates {
  final String message;

  const AddUpdateShiftFailureState({required this.message});
}

final class AddUpdateShiftSucessState extends AddShiftStates {}
