import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:institute_management_system/core/functions/data_extinsions.dart';
import 'package:institute_management_system/features/courses/presentation/bloc/calendar_bloc/calendar_bloc.dart';

class CourseCustomTable extends StatelessWidget {
  final CalendarFilterdEventsState state;
  const CourseCustomTable({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Table(
          children: List.generate(
            state.events.length + 1,
            (index) {
              if (index == 0) {
                return buildHeader();
              }
              return buildCalendarTableRow(
                state.events[index - 1],
              );
            },
          ),
        ),
      ),
    );
  }
}

TableRow buildHeader() {
  return const TableRow(
    children: [
      Center(child: Text("Subject")),
      Center(child: Text("Teacher")),
      Center(child: Text("Start Time")),
      Center(child: Text("End Time")),
    ],
  );
}

TableRow buildCalendarTableRow(CalendarEventData event) {
  return TableRow(
    children: [
      Center(child: Text("${event.description}")),
      Center(child: Text(event.title)),
      Center(child: Text(event.startTime!.parseDateTimeToTime())),
      Center(child: Text(event.endTime!.parseDateTimeToTime())),
    ],
  );
}
