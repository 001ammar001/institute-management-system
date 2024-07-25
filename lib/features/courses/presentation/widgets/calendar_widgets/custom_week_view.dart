import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/constants.dart';
import 'package:institute_management_system/core/functions/data_extinsions.dart';
import 'package:institute_management_system/features/courses/presentation/bloc/calendar_bloc/calendar_bloc.dart';
import 'package:institute_management_system/features/courses/presentation/pages/coures_details.dart';
import 'package:institute_management_system/features/drawer/presentation/bloc/drawer_bloc.dart';

class BuildWeekView extends StatelessWidget {
  const BuildWeekView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<DrawerBloc>(context);
    return Column(
      children: [
        Expanded(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: WeekView(
              controller:
                  BlocProvider.of<CalendarBloc>(context).eventController,
              headerStringBuilder: (date, {secondaryDate}) {
                return "من ${date.parseTimeToString()} إلى ${secondaryDate?.parseTimeToString()}";
              },
              weekDayStringBuilder: (p0) {
                return arabicWeekDays[p0];
              },
              weekNumberBuilder: (firstDayOfWeek) {
                return MaterialButton(
                  color: Colors.yellow,
                  onPressed: () => BlocProvider.of<CalendarBloc>(context).add(
                    ChangeViewEvent(isWeekView: false),
                  ),
                  child: const Text("الجدول اليومي"),
                );
              },
              startDay: WeekDays.sunday,
              onEventTap: (events, date) {
                screenStack.pushScreen(
                  screen: CourseDetailsPage(id: events.first.event as int),
                  title: "تعديل كورس",
                );
                bloc.add(ChangeWidgetEvent());
              },
              keepScrollOffset: true,
              timeLineWidth: 100,
              heightPerMinute: 1.5,
              onDateTap: (date) {
                BlocProvider.of<CalendarBloc>(context).add(
                  ChangeTableDateEvent(date: date),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
