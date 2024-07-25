part of 'shift_details_bloc.dart';

sealed class ShiftDetailsEvent extends Equatable {
  const ShiftDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetShiftDetailEvent extends ShiftDetailsEvent {
  final int id;

  const GetShiftDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}
