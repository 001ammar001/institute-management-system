part of "calendar_bloc.dart";

sealed class CalendarEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadEventsEvent extends CalendarEvents {}

class ChangeTableDateEvent extends CalendarEvents {
  final DateTime date;

  ChangeTableDateEvent({required this.date});

  @override
  List<Object?> get props => [date];
}

class ChangeViewEvent extends CalendarEvents {
  final bool isWeekView;

  ChangeViewEvent({required this.isWeekView});
}
