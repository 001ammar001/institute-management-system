import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/functions/linear_scalr.dart';
import 'package:institute_management_system/features/dashbord/presentation/widgets/bar_chart/bar_graph_card.dart';
import 'package:institute_management_system/features/dashbord/presentation/widgets/dash_board_button.dart';
import 'package:institute_management_system/features/dashbord/presentation/widgets/line_chart.dart';
import 'package:institute_management_system/features/dashbord/presentation/widgets/dashboard_header.dart';
import 'package:institute_management_system/features/employees/presentation/pages/job_list_page.dart';
import 'package:institute_management_system/features/employees/presentation/pages/shift_list_page.dart';
import '../../../../core/constants.dart';
import '../widgets/bar_chart/ring_chart.dart';
import '../../../courses/presentation/pages/list_pages/show_categories.dart';
import '../../../courses/presentation/pages/list_pages/show_rooms.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';
import '../../../warehouse/presentation/pages/warehouse_screen.dart';

final y = ScaleLinear(
  domainMin: 100,
  domainMax: 111,
  rangeMin: 1,
  rangeMax: 100,
);

final bottomTitle = {
  0: 'Jan',
  10: 'Feb',
  20: 'Mar',
  30: 'Apr',
  40: 'May',
  50: 'Jun',
  60: 'Jul',
  70: 'Aug',
  80: 'Sep',
  90: 'Oct',
  100: 'Nov',
  110: 'Dec',
};

List<FlSpot> spots = [
  FlSpot(0, y.calc(104)),
  FlSpot(10, y.calc(105)),
  FlSpot(20, y.calc(106)),
  FlSpot(30, y.calc(107)),
  FlSpot(40, y.calc(100)),
  FlSpot(50, y.calc(101)),
  FlSpot(60, y.calc(102)),
  FlSpot(70, y.calc(103)),
  FlSpot(80, y.calc(108)),
  FlSpot(90, y.calc(109)),
  FlSpot(100, y.calc(110)),
  FlSpot(110, y.calc(111)),
];

double minValue = spots.map((e) => e.y).toList().reduce(min);
double maxValue = spots.map((e) => e.y).toList().reduce(max);
final leftTitle = {
  0: y.numString(minValue),
  50: y.numString((minValue + maxValue) / 2),
  100: y.numString(maxValue)
};

class DashBordPage extends StatelessWidget {
  const DashBordPage({super.key});

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const DashBoardHeader(),
            Expanded(
              child: Row(
                children: [
                  Expanded(child: BarGraphCard()),
                  const SizedBox(width: 12),
                  Expanded(child: RingChart()),
                  const SizedBox(width: 12),
                  Expanded(child: BarGraphCard()),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              DashBoardButton(
                                text: "الشهادات",
                                onPressed: () {},
                              ),
                              DashBoardButton(
                                onPressed: () {
                                  screenStack.pushScreen(
                                      screen: const WareHouseScreen(),
                                      title: "المستودع");
                                  bloc.add(ChangeWidgetEvent());
                                  // navigateTo(widget: const HomeScreen(index: 7,),context: context);
                                },
                                text: "المستودع",
                              ),
                              DashBoardButton(
                                text: "الورديات",
                                onPressed: () {
                                  screenStack.pushScreen(
                                      screen: const ShiftListPage(),
                                      title: "الورديات");
                                  bloc.add(ChangeWidgetEvent());
                                  // navigateTo(widget: const HomeScreen(index: 12,),context: context);
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              DashBoardButton(
                                text: "المسميات الوظيفية",
                                onPressed: () {
                                  screenStack.pushScreen(
                                      screen: const JobTitleListPage(),
                                      title: "المسميات الوظيفية");
                                  bloc.add(ChangeWidgetEvent());
                                  // navigateTo(widget: const HomeScreen(index: 9,),context: context);
                                },
                              ),
                              DashBoardButton(
                                text: "عرض الغرف",
                                onPressed: () {
                                  screenStack.pushScreen(
                                      screen: const ShowRoomsScreen(),
                                      title: "عرض الغرف");
                                  bloc.add(ChangeWidgetEvent());
                                  // navigateTo(widget: const HomeScreen(index: 9,),context: context);
                                },
                              ),
                              DashBoardButton(
                                onPressed: () {
                                  screenStack.pushScreen(
                                      screen: const ShowCategoriesScreen(),
                                      title: "عرض التصنيفات");
                                  bloc.add(ChangeWidgetEvent());
                                  // navigateTo(widget: const HomeScreen(index: 11,),context: context);
                                },
                                text: "عرض التصنيفات",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: LineChartCard(
                      bottomTitle: bottomTitle,
                      leftTitle: leftTitle,
                      scaleLinear: y,
                      spots: spots,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              DashBoardButton(
                                text: "",
                                onPressed: () {},
                              ),
                              DashBoardButton(
                                text: "",
                                onPressed: () {},
                              ),
                              DashBoardButton(
                                onPressed: () {},
                                text: "",
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              DashBoardButton(
                                text: "",
                                onPressed: () {},
                              ),
                              DashBoardButton(
                                text: "",
                                onPressed: () {},
                              ),
                              DashBoardButton(
                                onPressed: () {},
                                text: "",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
