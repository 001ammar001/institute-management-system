part of "calendar_bloc.dart";

@immutable
sealed class CalendarStates extends Equatable {
  const CalendarStates();

  @override
  List<Object?> get props => [];
}

class CalendarLoadingState extends CalendarStates {
  const CalendarLoadingState();
}

class CalendarLoadedEventsState extends CalendarStates {
  final bool isWeekView;
  const CalendarLoadedEventsState({this.isWeekView = true});

  @override
  List<Object?> get props => [isWeekView];
}

class CalendarFilterdEventsState extends CalendarStates {
  final List<CalendarEventData> events;
  const CalendarFilterdEventsState({required this.events});

  @override
  List<Object?> get props => [events];
}

class CalendarFailureState extends CalendarStates {
  final String message;

  const CalendarFailureState({required this.message});
}


