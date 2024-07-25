import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/constants.dart';
import 'package:institute_management_system/features/drawer/presentation/bloc/drawer_bloc.dart';
import 'package:institute_management_system/features/teachers/presentation/pages/teacher_detail_page.dart';
import '../../../../core/widgets/bodies_alert_dialogs/body_delete.dart';
import '../../../../core/widgets/table_screen/icons_options.dart';
import '../../data/models/filters_teachers_model.dart';
import '../../data/models/teacher_model_list.dart';
import '../bloc/list_teachers_bloc/list_teachers_bloc.dart';

class ItemBuilderTeacher extends StatelessWidget {
  const ItemBuilderTeacher({
    super.key,
    required this.bloc,
    required this.state,
    required this.teachers,
  });

  final ListTeachersBloc bloc;
  final ListTeachersStates state;
  final TeacherModelList teachers;

  @override
  Widget build(BuildContext context) {
    DrawerBloc drawerBloc = BlocProvider.of<DrawerBloc>(context);
    return Expanded(
        flex: 8,
        child: (state is ListTeachersSuccessState || state is PageChangedState)
            ? ListView.builder(
                itemCount: teachers.data?.length,
                itemBuilder: (context, index) {
                  final Teachers? teacher = teachers.data?[index];
                  final isEven = index.isEven;
                  final backgroundColor =
                      isEven ? Colors.grey[200] : Colors.white;
                  const textColor = Colors.black;
                  return MaterialButton(
                    padding: const EdgeInsets.all(1),
                    onPressed: () {
                      drawerBloc.teachersFilter = FiltersTeacherModel(
                          pageNumber: currentPageTeacher,
                          name: nameTeacher,
                          phoneNumber: phoneNumberTeacher,
                          getArchived: getArchivedTeacher);
                      screenStack.pushScreen(
                          screen: TeacherDetailPage(id: teacher!.id!),
                          title: "تفاصيل الاستاذ");
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
                              child: Text('   ${teacher?.id}',
                                  style: const TextStyle(color: textColor))),
                          Expanded(
                              flex: 6,
                              child: Center(
                                child: Text('${teacher?.name}',
                                    style: const TextStyle(color: textColor)),
                              )),
                          Expanded(
                              flex: 6,
                              child: Center(
                                child: Text('${teacher?.birthDate}',
                                    style: const TextStyle(color: textColor)),
                              )),
                          Expanded(
                              flex: 6,
                              child: Center(
                                child: Text("${teacher?.phoneNumber}",
                                    style: const TextStyle(color: textColor)),
                              )),
                          Expanded(
                            flex: 2,
                            child: IconsRowOptions(
                              item: teacher,
                              checkBox: (newValue) {
                                BlocProvider.of<ListTeachersBloc>(context)
                                    .add(CheckboxEvent());
                                teacher?.index = newValue!;
                                if (newValue!) {
                                  //Bloc.teachers.add(value);
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
                                    FiltersTeacherModel filter = FiltersTeacherModel(
                                        pageNumber: currentPageTeacher,
                                        name: nameTeacher,
                                        phoneNumber: phoneNumberTeacher,
                                        getArchived: getArchivedTeacher);
                                    BlocProvider.of<ListTeachersBloc>(context)
                                        .add(DeleteTeacherEvent(
                                            indexTeacher: teacher!.id!));
                                    BlocProvider.of<ListTeachersBloc>(context)
                                        .add(FilterTeachersListEvent(
                                           teachersFilter2: filter));
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
            : state is ListTeachersFailureState
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
