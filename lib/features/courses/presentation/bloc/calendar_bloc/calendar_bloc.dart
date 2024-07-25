import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';
import 'package:institute_management_system/features/courses/domain/useCases/get_calendar_events_usecase.dart';

part "calendar_events.dart";
part "calendar_states.dart";

class CalendarBloc extends Bloc<CalendarEvents, CalendarStates> {
  final GetCalendarEventsUseCase getCalendarEvents;
  EventController eventController = EventController();

  CalendarBloc({required this.getCalendarEvents})
      : super(const CalendarLoadingState()) {
    on<LoadEventsEvent>((event, emit) async {
      emit(const CalendarLoadingState());
      final results = await getCalendarEvents();
      results.fold(
        (l) => emit(
          CalendarFailureState(message: mapFailureToMessage(l)),
        ),
        (r) {
          eventController.addAll(r);
          emit(const CalendarLoadedEventsState());
        },
      );
    });
    on<ChangeTableDateEvent>((event, emit) async {
      final events = eventController.getEventsOnDay(event.date);
      emit(CalendarFilterdEventsState(events: events));
    });
    on<ChangeViewEvent>((event, emit) async {
      emit(CalendarLoadedEventsState(isWeekView: event.isWeekView));
    });
  }
}
