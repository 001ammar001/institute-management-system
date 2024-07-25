import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/widgets/buttons/custom_segmented_buttons.dart';
import 'package:institute_management_system/core/widgets/buttons/yes_no_button.dart';
import 'package:institute_management_system/core/widgets/text_fields/enabled_text_field.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';
import '../../data/models/filters_teachers_model.dart';
import '../bloc/list_teachers_bloc/list_teachers_bloc.dart';

class TeacherFilterWidget extends StatefulWidget {
  final ListTeachersBloc bloc;
  final TextEditingController valueSearchTeacher;

  const TeacherFilterWidget({
    super.key,
    required this.bloc, required this.valueSearchTeacher,
  });

  @override
  State<TeacherFilterWidget> createState() => _TeacherFilterWidgetState();
}

class _TeacherFilterWidgetState extends State<TeacherFilterWidget> {
  late Set operation;
  late TextEditingController nameTeacherController;
  late TextEditingController phoneNumberTeacherController;


  @override
  void initState() {
    super.initState();
    operation = {false};
    nameTeacherController = TextEditingController(
      text: '',
    );
    phoneNumberTeacherController = TextEditingController(
      text: '',
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameTeacherController.dispose();
    phoneNumberTeacherController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size media= MediaQuery.sizeOf(context);
    DrawerBloc drawerBloc = BlocProvider.of<DrawerBloc>(context);
    return Dialog(
      child: SizedBox(
        width: media.width/1.5,
        height: media.height/1.2,
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: media.width/20 , right:  media.width/20,top: 30),
                    child: _buildOperationButton(),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: media.width/6 , right:  media.width/6),
                    child: EnabledTextField(
                      controller: nameTeacherController,
                      label: "اسم المعلم",
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: media.width/6 , right:  media.width/6),
                    child: EnabledTextField(
                      controller: phoneNumberTeacherController,
                      label: "رقم المعلم",
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      YesNoButton(
                        yes: true,
                        onYesSubmited: () {
                          widget.valueSearchTeacher.text='';
                          drawerBloc.statusSaveData=true;
                          currentPageTeacher=1;
                          getArchivedTeacher = operation.first;
                          nameTeacher =nameTeacherController.text;
                          phoneNumberTeacher = phoneNumberTeacherController.text;
                          FiltersTeacherModel filter = FiltersTeacherModel(
                              pageNumber: currentPageTeacher,
                              name: nameTeacher,
                              phoneNumber: phoneNumberTeacher,
                              getArchived: getArchivedTeacher);
                          widget.bloc.add(FilterTeachersListEvent(
                              teachersFilter2: filter));
                        },
                      ),
                      const YesNoButton(
                        yes: false,
                      )
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildOperationButton() {
    return Row(
      children: [
        StatefulBuilder(
          builder: (context, setState) {
            return CustomSegmentedButton(
              label: "حالة المعلم:",
              selectedValue: operation,
              onSelectionChanged: (data) {
                setState(() {
                  operation = data;
                });
              },
              segments: const [
                ButtonSegment(
                  value: false,
                  label: Text(
                    "نشطة",
                    softWrap: true,
                  ),
                ),
                ButtonSegment(
                  value: true,
                  label: Text(
                    "مؤرشفة",
                    softWrap: false,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
