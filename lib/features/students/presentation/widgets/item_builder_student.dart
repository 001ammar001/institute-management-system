import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/constants.dart';
import 'package:institute_management_system/features/drawer/presentation/bloc/drawer_bloc.dart';
import 'package:institute_management_system/features/students/data/models/student_model_list.dart';
import 'package:institute_management_system/features/students/presentation/bloc/list_students_bloc/list_students_bloc.dart';
import 'package:institute_management_system/features/students/presentation/pages/student_details_page.dart';
import '../../../../core/widgets/bodies_alert_dialogs/body_delete.dart';
import '../../../../core/widgets/table_screen/icons_options.dart';
import '../../data/models/filters_students_model.dart';

class ItemBuilderStudent extends StatelessWidget {
  const ItemBuilderStudent({
    super.key,
    required this.bloc,
    required this.state,
    required this.students,
  });

  final ListStudentsBloc bloc;
  final ListStudentsStates state;
  final StudentModelList students;
  @override
  Widget build(BuildContext context) {
    DrawerBloc drawerBloc = BlocProvider.of<DrawerBloc>(context);
    return Expanded(
        flex: 8,
        child: (state is ListStudentsSuccessState || state is PageChangedState)
            ? ListView.builder(
                itemCount: students.data?.length,
                itemBuilder: (context, index) {
                  final Students? student = students.data?[index];
                  final isEven = index.isEven;
                  final backgroundColor =
                      isEven ? Colors.grey[200] : Colors.white;
                  const textColor = Colors.black;
                  return MaterialButton(
                    padding: const EdgeInsets.all(1),
                    onPressed: () {
                      //drawerBloc.statusSaveData=true; in  (( StudentDetailPage ))
                      drawerBloc.studentsFilter = FiltersStudentModel(
                            pageNumber: currentPageStudent,
                            arabicNameStudent: arabicNameStudent,
                            englishNameStudent: englishNameStudent,
                            fatherName: fatherName,
                            motherName: motherName,
                            createDate: createDate,
                            educationLevel: educationLevel,
                            lineNumber: lineNumber,
                            getArchived: getArchivedStudent);
                      screenStack.pushScreen(
                          screen: StudentDetailPage(id: student!.id!),
                          title: "تفاصيل طالب");
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
                              child: Text('   ${student?.id}',
                                  style: const TextStyle(color: textColor))),
                          Expanded(
                              flex: 6,
                              child: Center(
                                child: Text('${student?.name}',
                                    style: const TextStyle(color: textColor)),
                              )),
                          Expanded(
                              flex: 6,
                              child: Center(
                                child: Text('${student?.fatherName}',
                                    style: const TextStyle(color: textColor)),
                              )),
                          Expanded(
                              flex: 6,
                              child: Center(
                                child: Text("${student?.phoneNumber}",
                                    style: const TextStyle(color: textColor)),
                              )),
                          Expanded(
                            flex: 2,
                            child: IconsRowOptions(
                              item: student,
                              checkBox: (newValue) {
                                BlocProvider.of<ListStudentsBloc>(context)
                                    .add(CheckboxEvent());
                                student?.index = newValue!;
                                if (newValue!) {
                                  //Bloc.students.add(value);
                                }
                              },
                              delete: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                alertDialogGeneral(
                                  title: "هل أنت متأكد من حذف هذا العنصر",
                                  context: context,
                                  submitFunction: () {
                                    drawerBloc.statusSaveData=true;
                                    FiltersStudentModel filter = FiltersStudentModel(
                                        pageNumber: currentPageStudent,
                                        arabicNameStudent: arabicNameStudent,
                                        englishNameStudent: englishNameStudent,
                                        fatherName: fatherName,
                                        motherName: motherName,
                                        createDate: createDate,
                                        educationLevel: educationLevel,
                                        lineNumber: lineNumber,
                                        getArchived: getArchivedStudent);
                                    BlocProvider.of<ListStudentsBloc>(context)
                                        .add(DeleteStudentEvent(
                                            indexStudent: student!.id!));
                                    BlocProvider.of<ListStudentsBloc>(context)
                                        .add(FilterStudentsListEvent(
                                            studentsFilter2: filter));
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
            : state is ListStudentsFailureState
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
