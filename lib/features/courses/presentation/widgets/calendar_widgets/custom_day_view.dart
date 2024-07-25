import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/features/courses/presentation/bloc/calendar_bloc/calendar_bloc.dart';
import 'package:institute_management_system/features/courses/presentation/pages/coures_details.dart';
import 'package:institute_management_system/features/drawer/presentation/bloc/drawer_bloc.dart';
import '../../../../../core/constants.dart';

class BuildDayView extends StatelessWidget {
  const BuildDayView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<DrawerBloc>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            color: Colors.yellow,
            onPressed: () => BlocProvider.of<CalendarBloc>(context).add(
              ChangeViewEvent(isWeekView: true),
            ),
            child: const Text("الجدول الاسبوعي"),
          ),
        ),
        Expanded(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: DayView(
              controller:
                  BlocProvider.of<CalendarBloc>(context).eventController,
              keepScrollOffset: true,
              timeLineWidth: 75,
              heightPerMinute: 1,
              onEventTap: (events, date) {
                screenStack.pushScreen(
                  screen: CourseDetailsPage(id: events.first.event as int),
                  title: "تعديل كورس",
                );
                bloc.add(ChangeWidgetEvent());
              },
            ),
          ),
        ),
      ],
    );
  }
}
