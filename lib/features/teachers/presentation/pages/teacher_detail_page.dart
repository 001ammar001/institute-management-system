import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/constants.dart';
import 'package:institute_management_system/core/widgets/bodies_alert_dialogs/body_delete.dart';
import 'package:institute_management_system/core/widgets/buttons/custom_details_page_button.dart';
import 'package:institute_management_system/core/widgets/custom_text.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;
import 'package:institute_management_system/core/widgets/title_back_button.dart';
import 'package:institute_management_system/features/drawer/presentation/bloc/drawer_bloc.dart';
import 'package:institute_management_system/features/teachers/presentation/bloc/list_teachers_bloc/list_teachers_bloc.dart';
import 'package:institute_management_system/features/teachers/presentation/bloc/teacher_details_bloc/teacher_details_bloc.dart';
import 'package:institute_management_system/features/teachers/presentation/pages/add_teacher_page.dart';
import 'package:institute_management_system/features/teachers/presentation/widgets/list_view_teachers_course.dart';

class TeacherDetailPage extends StatelessWidget {
  const TeacherDetailPage({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    DrawerBloc drawerBloc = BlocProvider.of<DrawerBloc>(context);
    drawerBloc.statusSaveData = true;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TitleWhitBackButton(
              function: () {
                screenStack.popScreen();
                drawerBloc.add(ChangeWidgetEvent());
              },
              text: "تفاصيل استاذ",
            ),
          ),
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getit.sl<TeacherDetailsBloc>()
                  ..add(GetTeacherDetailEvent(id: id)),
              ),
              BlocProvider(create: (context) => getit.sl<ListTeachersBloc>()),
            ],
            child: BlocConsumer<ListTeachersBloc, ListTeachersStates>(
              listener: (context, state) {
                if (state is DeleteTeachersSuccessState) {
                  screenStack.popScreen();
                  drawerBloc.add(ChangeWidgetEvent());
                }
              },
              builder: (context, state) {
                return BlocBuilder<TeacherDetailsBloc, TeacherDetailsStates>(
                  builder: (context, state) {
                    return (state is TeacherDataLoadedState)
                        ? Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      spreadRadius: 7,
                                      blurRadius: 7,
                                      color: Color.fromARGB(82, 128, 128, 128)),
                                ],
                                color:
                                    const Color.fromARGB(255, 238, 218, 238)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomText20(
                                      text:
                                          "اسم الأستاذ : ${state.teacher.name}"),
                                  CustomText20(
                                      text:
                                          "تاريخ الولادة:${state.teacher.birthDate} "),
                                  CustomText20(
                                      text:
                                          "رقم الهاتف :${state.teacher.phoneNumber} "),
                                  if (state.teacher.credentials
                                      .trim()
                                      .isNotEmpty)
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: SingleChildScrollView(
                                        child: Center(
                                          child: CustomText20(
                                              text:
                                                  "المؤهلات :${state.teacher.credentials}"),
                                        ),
                                      ),
                                    ),
                                  Container(
                                      color: const Color.fromARGB(
                                          255, 238, 218, 238),
                                      child: (state
                                              .teacher.teacherCourse!.isEmpty)
                                          ? const CustomText20(
                                              text: "لم يعطي دورة بعد")
                                          : Column(
                                              children: [
                                                const CustomText20(
                                                    text: "الدورات التي قدمها"),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TeacherListCourse(
                                                    course: state.teacher
                                                        .teacherCourse!),
                                              ],
                                            )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      DetailPageButton(
                                        onPressed: () {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          alertDialogGeneral(
                                            title:
                                                "هل أنت متأكد من حذف هذا العنصر",
                                            context: context,
                                            submitFunction: () {
                                              BlocProvider.of<ListTeachersBloc>(
                                                      context)
                                                  .add(DeleteTeacherEvent(
                                                      indexTeacher: id));
                                            },
                                          );
                                        },
                                        color: Colors.red,
                                        text: "حذف الأستاذ",
                                      ),
                                      DetailPageButton(
                                        onPressed: () {
                                          screenStack.pushScreen(
                                              screen: AddTeacherPage(id: id),
                                              title: "تعديل بيانات استاذ");
                                          drawerBloc.add(ChangeWidgetEvent());
                                        },
                                        color: Colors.green,
                                        text: "تعديل الأستاذ",
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ))
                        : (state is TeacherDataFailureState)
                            ? Center(child: Text(state.message))
                            : const Center(
                                child: CircularProgressIndicator(),
                              );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
