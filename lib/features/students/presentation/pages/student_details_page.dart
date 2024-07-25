import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:institute_management_system/core/constants.dart';
import 'package:institute_management_system/core/widgets/bodies_alert_dialogs/body_delete.dart';
import 'package:institute_management_system/core/widgets/buttons/custom_details_page_button.dart';
import 'package:institute_management_system/core/widgets/custom_text.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;
import 'package:institute_management_system/core/widgets/title_back_button.dart';
import 'package:institute_management_system/features/drawer/presentation/bloc/drawer_bloc.dart';
import 'package:institute_management_system/features/students/presentation/bloc/list_students_bloc/list_students_bloc.dart';
import 'package:institute_management_system/features/students/presentation/bloc/student_details_bloc/student_details_bloc.dart';
import 'package:institute_management_system/features/students/presentation/pages/add_student_page.dart';
import 'package:institute_management_system/features/students/presentation/widgets/student_courses_dialog.dart';

class StudentDetailPage extends StatelessWidget {
  const StudentDetailPage({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    DrawerBloc drawerBloc = BlocProvider.of<DrawerBloc>(context);
    drawerBloc.statusSaveData = true;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getit.sl<StudentDetailsBloc>()
            ..add(GetStudentDetailEvent(id: id)),
        ),
        BlocProvider(
          create: (context) => getit.sl<ListStudentsBloc>(),
        ),
      ],
      child: BlocConsumer<ListStudentsBloc, ListStudentsStates>(
        listener: (context, state) {
          if (state is DeleteStudentsSucessState) {
            screenStack.popScreen();
            drawerBloc.add(ChangeWidgetEvent());
          }
        },
        builder: (context, state) {
          return BlocConsumer<StudentDetailsBloc, StudentDetailsStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TitleWhitBackButton(
                        function: () {
                          screenStack.popScreen();
                          drawerBloc.add(ChangeWidgetEvent());
                          // navigator?.pop();
                        },
                        text: "تفاصيل طالب",
                      ),
                      Center(
                        child: state is StudentDataLoadedState
                            ? Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 7,
                                          blurRadius: 7,
                                          color: state.student.gender == "F"
                                              ? const Color.fromARGB(
                                                  255, 248, 196, 214)
                                              : const Color.fromARGB(
                                                  255, 205, 228, 247)),
                                    ],
                                    color: state.student.gender == "F"
                                        ? const Color.fromARGB(
                                            255, 252, 223, 233)
                                        : const Color.fromARGB(
                                            255, 234, 243, 250)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          width: 120,
                                          height: 120,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                          child: SvgPicture.asset(
                                              "assets/images/account.svg"),
                                        ),
                                      ),
                                      Container(
                                        height: 300,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
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
                                                        "اسم الطالب : ${state.student.aName}"),
                                                CustomText20(
                                                    text:
                                                        "اسم الأب : ${state.student.fArName}"),
                                                CustomText20(
                                                    text:
                                                        "اسم الأم : ${state.student.mArName}"),
                                                CustomText20(
                                                    text:
                                                        "رقم الهاتف : ${state.student.phoneNumber}"),
                                                CustomText20(
                                                    text:
                                                        "تاريخ الولادة:${state.student.birthDate} "),
                                                CustomText20(
                                                    text:
                                                        "الجنسية : ${state.student.nationality}")
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                CustomText20(
                                                    text:
                                                        "اسم باللغة الإنكليزية : ${state.student.eName}"),
                                                CustomText20(
                                                    text:
                                                        "اسم الأب باللغة الإنكليزية : ${state.student.fEnName}"),
                                                CustomText20(
                                                    text:
                                                        "اسم الأم باللغة الإنكليزية : ${state.student.mEnName}"),
                                                CustomText20(
                                                    text:
                                                        " رقم الخط الأرضي :${state.student.lineNumber} "),
                                                CustomText20(
                                                    text:
                                                        "المستوى التعليمي: ${state.student.educationLevel}"),
                                                CustomText20(
                                                    text:
                                                        "الرقم الوطني : ${state.student.nationalNumber}")
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            DetailPageButton(
                                              text: "تعديل الطالب",
                                              color: Colors.green,
                                              onPressed: () {
                                                screenStack.pushScreen(
                                                    screen: AddStudentPage(
                                                      id: id,
                                                    ),
                                                    title: "تعديل طالب");
                                                drawerBloc
                                                    .add(ChangeWidgetEvent());
                                              },
                                            ),
                                            DetailPageButton(
                                              text:
                                                  "عرض الدورات التي سجلها الطالب",
                                              color: Colors.yellow,
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return StudentCoursesDialog(
                                                      id: id,
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                            DetailPageButton(
                                              text: "حذف الطالب",
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
                                                                ListStudentsBloc>(
                                                            context)
                                                        .add(DeleteStudentEvent(
                                                            indexStudent: id));
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : state is StudentDataFailureState
                                ? Center(
                                    child: CustomText25(text: state.message))
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
