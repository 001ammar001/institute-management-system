import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/features/accounts/presentation/pages/show_users.dart';
import '../../../../core/constants.dart';
import '../../../activities/presentation/pages/show_activities.dart';
import '../../../box/box_accounts/presentation/pages/show_main_accounts.dart';
import '../../../box/box_accounts/presentation/pages/show_sub_accounts.dart';
import '../../../courses/presentation/pages/calendar_page.dart';
import '../../../courses/presentation/pages/list_pages/show_courses.dart';
import '../../../dashbord/presentation/pages/dash_bord.dart';
import '../../../dashbord/presentation/widgets/dash_board_button.dart';
import '../../../employees/presentation/pages/show_employees.dart';
import '../../../students/presentation/pages/show_students.dart';
import '../../../teachers/presentation/pages/show_teachers.dart';
import '../bloc/drawer_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 30),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      bottomLeft: Radius.circular(60)),
                  color: Colors.yellow),
              child: Stack(children: <Widget>[
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<DrawerBloc, DrawerState>(
                      builder: (context, state) {
                        return Text(
                          textAlign: TextAlign.center,
                          state.text,
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: MediaQuery.of(context).size.width > 800
                                ? MediaQuery.of(context).size.width / 67
                                : MediaQuery.of(context).size.height / 40,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 20, left: 28),
                      child: Divider(
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 65,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                          width: double.infinity,
                        ),
                        DashBoardButton(
                          type: "Drawer",
                          maxLines: 1,
                          color: Colors.purple,
                          textColor: Colors.white,
                          onPressed: () {
                            bloc.statusSaveData=false;
                            screenStack.clearScreens();
                            screenStack.pushScreen(
                                screen: const DashBordPage(),
                                title: "اللوحة الرئيسية");
                            bloc.add(ChangeWidgetEvent());
                          },
                          text: "اللوحة الرئيسية",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DashBoardButton(
                          type: "Drawer",
                          maxLines: 1,
                          text: "المخطط الزمني",
                          textColor: Colors.white,
                          color: Colors.purple,
                          onPressed: () {
                            bloc.statusSaveData=false;
                            screenStack.clearScreens();
                            screenStack.pushScreen(
                                screen: const CalendarPage(),
                                title: "المخطط الزمني");
                            bloc.add(ChangeWidgetEvent());
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DashBoardButton(
                          type: "Drawer",
                          maxLines: 1,
                          text: "الطلاب",
                          textColor: Colors.white,
                          color: Colors.purple,
                          onPressed: () {
                            bloc.statusSaveData=false;
                            screenStack.clearScreens();
                            screenStack.pushScreen(
                                screen:  const ShowStudentsScreen(),
                                title: "الطلاب");
                            bloc.add(ChangeWidgetEvent());
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DashBoardButton(
                          type: "Drawer",
                          maxLines: 1,
                          textColor: Colors.white,
                          color: Colors.purple,
                          onPressed: () {
                            bloc.statusSaveData=false;
                            screenStack.clearScreens();
                            screenStack.pushScreen(
                                screen: const ShowCoursesScreen(),
                                title: "الدورات");
                            bloc.add(ChangeWidgetEvent());
                          },
                          text: "الدورات",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DashBoardButton(
                          type: "Drawer",
                          maxLines: 1,
                          textColor: Colors.white,
                          color: Colors.purple,
                          onPressed: () {
                            bloc.statusSaveData=false;
                            screenStack.clearScreens();
                            screenStack.pushScreen(
                                screen: const ShowTeachersScreen(),
                                title: "المعلمين");
                            bloc.add(ChangeWidgetEvent());
                          },
                          text: "المعلمين",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DashBoardButton(
                          type: "Drawer",
                          maxLines: 1,
                          textColor: Colors.white,
                          color: Colors.purple,
                          onPressed: () {
                            bloc.statusSaveData=false;
                            screenStack.clearScreens();
                            screenStack.pushScreen(
                                screen: const ShowEmployeesScreen(),
                                title: "الموظفين");
                            bloc.add(ChangeWidgetEvent());
                          },
                          text: "الموظفين",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DashBoardButton(
                          type: "Drawer",
                          maxLines: 1,
                          textColor: Colors.white,
                          color: Colors.purple,
                          onPressed: () {
                            bloc.statusSaveData=false;
                            screenStack.clearScreens();
                            screenStack.pushScreen(
                                screen: const ShowUsersScreen(),
                                title: "الحسابات");
                            bloc.add(ChangeWidgetEvent());
                          },
                          text: "الحسابات",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DashBoardButton(
                          type: "Drawer",
                          maxLines: 1,
                          text: "السجلات",
                          textColor: Colors.white,
                          color: Colors.purple,
                          onPressed: () {
                            bloc.statusSaveData=false;
                            screenStack.clearScreens();
                            screenStack.pushScreen(
                                screen: const ShowActivitiesScreen(),
                                title: "السجلات");
                            bloc.add(ChangeWidgetEvent());
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DashBoardButton(
                          type: "Drawer",
                          maxLines: 1,
                          textColor: Colors.white,
                          color: Colors.purple,
                          onPressed: () {
                            bloc.statusSaveData=false;
                            screenStack.clearScreens();
                            screenStack.pushScreen(
                                screen: const ShowMainAccountsScreen(),
                                title: "الحسابات الرئيسية");
                            bloc.add(ChangeWidgetEvent());
                          },
                          text: "الحسابات الرئيسية",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DashBoardButton(
                          type: "Drawer",
                          maxLines: 1,
                          textColor: Colors.white,
                          color: Colors.purple,
                          onPressed: () {
                            bloc.statusSaveData=false;
                            screenStack.clearScreens();
                            screenStack.pushScreen(
                                screen: const ShowSubAccountsScreen(),
                                title: "الحسابات الفرعية");
                            bloc.add(ChangeWidgetEvent());
                          },
                          text: "الحسابات الفرعية",
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
          Expanded(
            flex: 5,
            child: BlocBuilder<DrawerBloc, DrawerState>(
              builder: (context, state) {
                return state.page;
              },
            ),
          )
        ],
      ),
    );
  }
}
