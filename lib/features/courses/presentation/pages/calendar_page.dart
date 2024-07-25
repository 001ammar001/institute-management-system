import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/widgets/buttons/resend_button.dart';
import 'package:institute_management_system/features/courses/presentation/bloc/calendar_bloc/calendar_bloc.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;
import 'package:institute_management_system/features/courses/presentation/widgets/calendar_widgets/course_calendar_table.dart';
import 'package:institute_management_system/features/courses/presentation/widgets/calendar_widgets/custom_day_view.dart';
import 'package:institute_management_system/features/courses/presentation/widgets/calendar_widgets/custom_week_view.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getit.sl<CalendarBloc>()..add(LoadEventsEvent()),
      child: BlocBuilder<CalendarBloc, CalendarStates>(
        buildWhen: (previous, current) => _buildWhen(previous, current),
        builder: (context, state) {
          if (state is CalendarLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CalendarLoadedEventsState) {
            if (state.isWeekView) {
              return const Column(
                children: [
                  Expanded(flex: 5, child: BuildWeekView()),
                  CourseCalendarTable(),
                ],
              );
            } else {
              return const BuildDayView();
            }
          }
          return ReseendButton(
            onPressed: () {
              BlocProvider.of<CalendarBloc>(context).add(LoadEventsEvent());
            },
          );
        },
      ),
    );
  }

  bool _buildWhen(CalendarStates previous, CalendarStates current) {
    return current is CalendarLoadedEventsState ||
        current is CalendarLoadingState ||
        current is CalendarFailureState;
  }
}
