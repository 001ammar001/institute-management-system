import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/constants.dart';
import 'package:institute_management_system/core/widgets/bodies_alert_dialogs/body_delete.dart';
import 'package:institute_management_system/core/widgets/buttons/custom_details_page_button.dart';
import 'package:institute_management_system/core/widgets/custom_text.dart';
import 'package:institute_management_system/core/widgets/title_back_button.dart';
import 'package:institute_management_system/core/widgets/week_day.dart';
import 'package:institute_management_system/features/courses/presentation/bloc/coures_details_bloc/course_details_bloc.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;
import 'package:institute_management_system/features/courses/presentation/pages/add_course_page.dart';
import 'package:institute_management_system/features/courses/presentation/widgets/custom_list_dialog.dart';
import 'package:institute_management_system/features/drawer/presentation/bloc/drawer_bloc.dart';

import '../bloc/list/list_courses_bloc/list_courses_bloc.dart';

class CourseDetailsPage extends StatelessWidget {
  final int id;
  const CourseDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    DrawerBloc drawerBloc = BlocProvider.of<DrawerBloc>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TitleWhitBackButton(
              function: () {
                screenStack.popScreen();
                drawerBloc.add(ChangeWidgetEvent());
              },
              text: "تفاصيل الدورة",
            ),
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getit.sl<CourseDetailsBloc>()
                    ..add(GetCourseDetailEvent(id: id)),
                ),
                BlocProvider(
                  create: (context) => getit.sl<ListCoursesBloc>(),
                ),
              ],
              child: BlocConsumer<ListCoursesBloc, ListCoursesStates>(
                listener: (context, state) {
                  if (state is DeleteCoursesSuccessState) {
                    screenStack.popScreen();
                    drawerBloc.add(ChangeWidgetEvent());
                  }
                },
                builder: (context, state) {
                  return BlocBuilder<CourseDetailsBloc, CourseDetailsStates>(
                    builder: (context, state) {
                      return (state is CouresDataLoadedState)
                          ? Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: MediaQuery.of(context).size.height * 0.8,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 40),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        spreadRadius: 7,
                                        blurRadius: 7,
                                        color:
                                            Color.fromARGB(82, 128, 128, 128)),
                                  ],
                                  color:
                                      const Color.fromARGB(255, 238, 218, 238)),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                CustomText20(
                                                    text:
                                                        "المادة:${state.course.subject.name}"),
                                                CustomText20(
                                                    text:
                                                        "الاستاذ:${state.course.teacher.name}"),
                                                CustomText20(
                                                    text:
                                                        "الحالة:${state.course.courseStatus}"),
                                                CustomText20(
                                                    text:
                                                        "تبدأ بتاريخ:${state.course.startDate}"),
                                                CustomText20(
                                                    text:
                                                        "من الساعة :${state.course.startTime}"),
                                                CustomText20(
                                                    text:
                                                        "نوع الأجرة:${state.course.selectedSalartType}")
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                CustomText20(
                                                    text:
                                                        "الغرفة:${state.course.room.name}"),
                                                CustomText20(
                                                    text:
                                                        "أقل عدد مسموح للطلاب:${state.course.minStudent}"),
                                                CustomText20(
                                                    text:
                                                        " الكلفة للطالب: ${state.course.priceToStudent}"),
                                                CustomText20(
                                                    text:
                                                        "تنتهي بتاريخ:${state.course.endDate}"),
                                                CustomText20(
                                                    text:
                                                        "إلى الساعة :${state.course.endTime}"),
                                                CustomText20(
                                                    text:
                                                        "الأجرة للاستاذ:${state.course.teacherSalary}")
                                              ],
                                            ),
                                          ],
                                        )),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    child: Row(
                                      children: [
                                        const CustomText20(
                                            text: "أيام الدوام :"),
                                        Expanded(
                                          child: WeekDay(
                                              days: state.course.days.toList()),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      DetailPageButton(
                                          text: "حذف الدورة",
                                          color: Colors.red,
                                          onPressed: () {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            alertDialogGeneral(
                                              title:
                                                  "هل أنت متأكد من حذف هذا العنصر",
                                              context: context,
                                              submitFunction: () {
                                                BlocProvider.of<
                                                            ListCoursesBloc>(
                                                        context)
                                                    .add(DeleteCourseEvent(
                                                        indexCourse: id));
                                              },
                                            );
                                          }),
                                      DetailPageButton(
                                          text: "تعديل الدورة",
                                          color: Colors.green,
                                          onPressed: () {
                                            screenStack.pushScreen(
                                                screen: AddCoursePage(id: id),
                                                title: "تعديل بيانات الدورة");
                                            drawerBloc.add(ChangeWidgetEvent());
                                          }),
                                      DetailPageButton(
                                          text: "إضافة طالب",
                                          color: Colors.yellow,
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return CustomListDialog(
                                                      id: id);
                                                });
                                          }),
                                      DetailPageButton(
                                          text: "عرض الطلاب",
                                          color: Colors.yellow,
                                          onPressed: () {}),
                                    ],
                                  )
                                ],
                              ),
                            )
                          : (state is CouresDataFailureState)
                              ? CustomText20(text: state.message)
                              : const CircularProgressIndicator();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


}
