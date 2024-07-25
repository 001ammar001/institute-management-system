import 'package:equatable/equatable.dart';

class ShiftEntity extends Equatable {
  final int? id;
  final String name;
  final String startTime;
  final String endTime;
  final Set<int> days;

  const ShiftEntity(
      {this.id,
      required this.name,
      required this.startTime,
      required this.endTime,
      required this.days});

  @override
  List<Object?> get props => [id, name, startTime, endTime, days];
}
