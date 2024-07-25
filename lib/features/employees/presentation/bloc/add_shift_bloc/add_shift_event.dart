part of 'add_shift_bloc.dart';

final class AddUpdateShiftEvent extends Equatable {
  final ShiftEntity shift;

  const AddUpdateShiftEvent({required this.shift});

  @override
  List<Object> get props => [shift];
}
