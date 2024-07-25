import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/constants.dart';
import 'package:institute_management_system/features/courses/data/models/course_model_list.dart';
import 'package:institute_management_system/features/courses/data/models/filters_courses_model.dart';
import 'package:institute_management_system/features/courses/presentation/pages/coures_details.dart';
import 'package:institute_management_system/features/drawer/presentation/bloc/drawer_bloc.dart';

import '../../../../../core/widgets/bodies_alert_dialogs/body_delete.dart';
import '../../../../../core/widgets/table_screen/icons_options.dart';
import '../../bloc/list/list_courses_bloc/list_courses_bloc.dart';

class ItemBuilderCourse extends StatelessWidget {
  const ItemBuilderCourse({
    super.key,
    required this.bloc,
    required this.state,
    required this.courses,
  });

  final ListCoursesBloc bloc;
  final ListCoursesStates state;
  final CourseModelList courses;

  @override
  Widget build(BuildContext context) {
    DrawerBloc drawerBloc = BlocProvider.of<DrawerBloc>(context);
    return Expanded(
        flex: 8,
        child: (state is ListCoursesSuccessState || state is PageChangedState)
            ? ListView.builder(
                itemCount: courses.data?.length,
                itemBuilder: (context, index) {
                  final Courses? course = courses.data?[index];
                  final isEven = index.isEven;
                  final backgroundColor =
                      isEven ? Colors.grey[200] : Colors.white;
                  const textColor = Colors.black;
                  return MaterialButton(
                    padding: const EdgeInsets.all(1),
                    onPressed: () {
                      drawerBloc.coursesFilter = FiltersCourseModel(
                        pageNumber: currentPageCourse,
                        getArchived: getArchivedCourse,
                        status: statusCourse,
                        teacher: teacher,
                        room: room,
                        subject: subject,
                        startAt: startAt,
                        endAt: endAt,
                      );
                      screenStack.pushScreen(
                          screen: CourseDetailsPage(id: course!.id!),
                          title: "تفاصيل الدورة");
                      drawerBloc.add(ChangeWidgetEvent());
                    },
                    child: Container(
                      color: backgroundColor,
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text('   ${course?.id}',
                                  style: const TextStyle(color: textColor))),
                          Expanded(
                              flex: 6,
                              child: Center(
                                child: Text('${course?.subject?.name}',
                                    style: const TextStyle(color: textColor)),
                              )),
                          Expanded(
                              flex: 6,
                              child: Center(
                                child: Text('${course?.teacher?.name}',
                                    style: const TextStyle(color: textColor)),
                              )),
                          Expanded(
                              flex: 6,
                              child: Center(
                                child: Text("${course?.status}",
                                    style: const TextStyle(color: textColor)),
                              )),
                          Expanded(
                            flex: 2,
                            child: IconsRowOptions(
                              item: course,
                              checkBox: (newValue) {
                                BlocProvider.of<ListCoursesBloc>(context)
                                    .add(CheckboxEvent());
                                course?.index = newValue!;
                                if (newValue!) {
                                  //Bloc.courses.add(value);
                                }
                              },
                              delete: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                alertDialogGeneral(
                                  title: "هل أنت متأكد من حذف هذا العنصر",
                                  context: context,
                                  submitFunction: () {
                                    drawerBloc.statusSaveData = true;
                                    FiltersCourseModel filter =
                                        FiltersCourseModel(
                                      pageNumber: currentPageCourse,
                                      getArchived: getArchivedCourse,
                                      status: statusCourse,
                                      teacher: teacher,
                                      room: room,
                                      subject: subject,
                                      startAt: startAt,
                                      endAt: endAt,
                                    );
                                    BlocProvider.of<ListCoursesBloc>(context)
                                        .add(DeleteCourseEvent(
                                            indexCourse: course!.id!));
                                    BlocProvider.of<ListCoursesBloc>(context)
                                        .add(FilterCoursesListEvent(
                                            coursesFilter2: filter));
                                  },
                                );
                              },
                              edit: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
            : state is ListCoursesFailureState
                ? Center(
                    child: Text(
                      bloc.failureText,
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ));
  }
}
