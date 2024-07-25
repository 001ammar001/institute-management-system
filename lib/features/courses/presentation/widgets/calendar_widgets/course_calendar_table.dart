import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/features/courses/presentation/bloc/calendar_bloc/calendar_bloc.dart';
import 'package:institute_management_system/features/courses/presentation/widgets/calendar_widgets/calendar_course_table.dart';

class CourseCalendarTable extends StatelessWidget {
  const CourseCalendarTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarStates>(
      builder: (context, state) {
        if (state is CalendarFilterdEventsState) {
          if (state.events.isEmpty) {
            return const CenteredText(text: "There is No Events On This Day");
          }
          return CourseCustomTable(state: state);
        }
        return const CenteredText(
            text: "Click On A Cell To See All Events On The Choosed Day");
      },
    );
  }
}

class CenteredText extends StatelessWidget {
  final String text;
  const CenteredText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
        ),
      ),
    );
  }
}
