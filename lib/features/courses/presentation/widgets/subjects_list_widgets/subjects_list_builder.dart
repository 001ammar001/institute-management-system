import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/constants.dart';
import 'package:institute_management_system/core/functions/response_dialogs.dart';
import 'package:institute_management_system/core/widgets/bodies_alert_dialogs/body_delete.dart';
import 'package:institute_management_system/core/widgets/buttons/resend_button.dart';
import 'package:institute_management_system/core/widgets/table_screen/icons_options.dart';
import 'package:institute_management_system/features/courses/presentation/bloc/subjects_list_bloc/subjects_list_bloc.dart';
import 'package:institute_management_system/features/courses/presentation/pages/add_subject_page.dart';
import 'package:institute_management_system/features/drawer/presentation/bloc/drawer_bloc.dart';

class SubjetsListItemBuilder extends StatelessWidget {
  const SubjetsListItemBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    DrawerBloc drawerBloc = BlocProvider.of<DrawerBloc>(context);
    final shiftBloc = BlocProvider.of<SubjectsListBloc>(context);
    return BlocConsumer<SubjectsListBloc, SubjectsListStates>(
        listener: (context, state) {
      if (state is DeleteSubjectFailureState) {
        showErrorSnackBar(context, state.message);
      }
    }, builder: (context, state) {
      return Expanded(
          flex: 8,
          child: state is SubjectsListSuccessState || state is PageChangedState
              ? ListView.builder(
                  itemCount: shiftBloc.subjects.entitys.length,
                  itemBuilder: (context, index) {
                    final subject = shiftBloc.subjects.entitys[index];
                    return GestureDetector(
                      onTap: () {
                        screenStack.pushScreen(
                            screen: AddSubjectPage(subject: subject),
                            title: "تفاصيل الدور");
                        drawerBloc.add(ChangeWidgetEvent());
                      },
                      child: Container(
                        color: index.isEven ? Colors.grey[200] : Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${subject.id}',
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                subject.subject,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                subject.category.name,
                              ),
                            ),
                            Expanded(
                              child: IconsRowOptions(
                                item: shiftBloc.subjects.selecetdEntitys[index],
                                checkBox: (newValue) {
                                  shiftBloc.subjects.selecetdEntitys[index] =
                                      newValue!;
                                  shiftBloc.add(CheckboxEvent());
                                },
                                delete: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  alertDialogGeneral(
                                    title: "هل أنت متأكد من حذف هذا العنصر",
                                    context: context,
                                    submitFunction: () {
                                      shiftBloc.add(DeleteSubjectEvent(
                                          subjectId: subject.id!));
                                    },
                                  );
                                },
                                edit: () {
                                  screenStack.pushScreen(
                                      screen: AddSubjectPage(subject: subject),
                                      title: "تفاصيل الدور");
                                  drawerBloc.add(ChangeWidgetEvent());
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              : state is SubjectsListFailureState
                  ? ReseendButton(
                      onPressed: () {
                        BlocProvider.of<SubjectsListBloc>(context)
                            .add(GetSubjectsEvent());
                      },
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ));
    });
  }
}
