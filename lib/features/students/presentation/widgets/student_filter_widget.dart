import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/widgets/buttons/custom_segmented_buttons.dart';
import 'package:institute_management_system/core/widgets/buttons/yes_no_button.dart';
import 'package:institute_management_system/core/widgets/text_fields/enabled_text_field.dart';
import '../../../../core/widgets/text_fields/pairs/pair_of_enabled_fields.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';
import '../../data/models/filters_students_model.dart';
import '../bloc/list_students_bloc/list_students_bloc.dart';

class StudentFilterWidget extends StatefulWidget {
  final ListStudentsBloc bloc;
  final TextEditingController valueSearchStudent;

  const StudentFilterWidget({
    super.key,
    required this.bloc, required this.valueSearchStudent,
  });

  @override
  State<StudentFilterWidget> createState() => _StudentFilterWidgetState();
}

class _StudentFilterWidgetState extends State<StudentFilterWidget> {
  late Set operation;
  late TextEditingController arabicNameStudentController;
  late TextEditingController englishNameStudentController;
  late TextEditingController fatherNameController;
  late TextEditingController motherNameController;
  late TextEditingController createDateController;
  late TextEditingController educationLevelController;
  late TextEditingController lineNumberController;


  @override
  void initState() {
    super.initState();
    operation = {false};
    arabicNameStudentController = TextEditingController(
      text: '',
    );
    englishNameStudentController = TextEditingController(
      text: '',
    );
    fatherNameController = TextEditingController(
      text: '',
    );
    motherNameController = TextEditingController(
      text: '',
    );
    createDateController = TextEditingController(
      text: '',
    );
    educationLevelController = TextEditingController(
      text: '',
    );
    lineNumberController = TextEditingController(
      text: '',
    );
  }

  @override
  void dispose() {
    super.dispose();
    arabicNameStudentController.dispose();
    englishNameStudentController.dispose();
    fatherNameController.dispose();
    motherNameController.dispose();
    createDateController.dispose();
    educationLevelController.dispose();
    lineNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size media= MediaQuery.sizeOf(context);
    DrawerBloc drawerBloc = BlocProvider.of<DrawerBloc>(context);
    return Dialog(
      child: SizedBox(
        width: media.width,
        height: media.height,
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: media.width/4 , right:  media.width/4),
                    child: _buildOperationButton(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  PairOfEnabledField(
                    label1: "اسم الطالب بالغة العربية",
                    controller1: arabicNameStudentController,
                    label2: "اسم الطالب بالغة الإنكليزية",
                    controller2: englishNameStudentController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PairOfEnabledField(
                    label1: "اسم الأب",
                    controller1: fatherNameController,
                    label2: "اسم الأم",
                    controller2: motherNameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PairOfEnabledField(
                    label1: "تاريخ تسجيل الطالب",
                    controller1: createDateController,
                    label2: "المستوى التعليمي",
                    controller2: educationLevelController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: media.width/4 , right:  media.width/4),
                    child: EnabledTextField(
                      controller: lineNumberController,
                      label: "رقم الهاتف الأرضي",
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      YesNoButton(
                        yes: true,
                        onYesSubmited: () {
                          widget.valueSearchStudent.text='';
                          drawerBloc.statusSaveData=true;
                          currentPageStudent=1;
                          getArchivedStudent = operation.first;
                          arabicNameStudent =arabicNameStudentController.text;
                          englishNameStudent = englishNameStudentController.text;
                          fatherName = fatherNameController.text;
                          motherName = motherNameController.text;
                          createDate = createDateController.text;
                          educationLevel = educationLevelController.text;
                          lineNumber = lineNumberController.text;
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
                          widget.bloc.add(FilterStudentsListEvent(
                              studentsFilter2: filter));
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
              label: "حالة الطالب:",
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
