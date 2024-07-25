part of 'shift_details_bloc.dart';

sealed class ShiftDetailsStates extends Equatable {
  const ShiftDetailsStates();

  @override
  List<Object> get props => [];
}

final class ShiftDataLoadedState extends ShiftDetailsStates {
  final ShiftEntity shift;

  const ShiftDataLoadedState({required this.shift});
}

final class ShiftDataLoadingState extends ShiftDetailsStates {}

final class ShiftDataFailureState extends ShiftDetailsStates {
  final String message;

  const ShiftDataFailureState({required this.message});
}
