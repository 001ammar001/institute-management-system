import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/widgets/buttons/custom_segmented_buttons.dart';
import 'package:institute_management_system/core/widgets/buttons/yes_no_button.dart';
import '../../../../../core/widgets/text_fields/pairs/pair_of_enabled_fields.dart';
import '../../../../drawer/presentation/bloc/drawer_bloc.dart';
import '../../../data/models/filters_courses_model.dart';
import '../../bloc/list/list_courses_bloc/list_courses_bloc.dart';

class CourseFilterWidget extends StatefulWidget {
  final ListCoursesBloc bloc;
  final TextEditingController valueSearchCourse;

  const CourseFilterWidget({
    super.key,
    required this.bloc,
    required this.valueSearchCourse,
  });

  @override
  State<CourseFilterWidget> createState() => _CourseFilterWidgetState();
}

class _CourseFilterWidgetState extends State<CourseFilterWidget> {
  late Set operation;
  late TextEditingController statusCourseController;
  late TextEditingController teacherCourseController;
  late TextEditingController roomController;
  late TextEditingController subjectController;
  late TextEditingController startAtController;
  late TextEditingController endAtController;

  @override
  void initState() {
    super.initState();
    operation = {false};
    statusCourseController = TextEditingController(
      text: '',
    );
    teacherCourseController = TextEditingController(
      text: '',
    );
    roomController = TextEditingController(
      text: '',
    );
    subjectController = TextEditingController(
      text: '',
    );
    startAtController = TextEditingController(
      text: '',
    );
    endAtController = TextEditingController(
      text: '',
    );
  }

  @override
  void dispose() {
    super.dispose();
    statusCourseController.dispose();
    teacherCourseController.dispose();
    roomController.dispose();
    subjectController.dispose();
    startAtController.dispose();
    endAtController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.sizeOf(context);
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
                    padding: EdgeInsets.only(
                        left: media.width / 4, right: media.width / 4),
                    child: _buildOperationButton(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  PairOfEnabledField(
                    label1: "المادة",
                    controller1: subjectController,
                    label2: "الاستاذ",
                    controller2: teacherCourseController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PairOfEnabledField(
                    label1: "الغرفة",
                    controller1: roomController,
                    label2: "الحالة",
                    controller2: statusCourseController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PairOfEnabledField(
                    label1: "تاريخ البداية",
                    controller1: startAtController,
                    label2: "تاريخ النهاية",
                    controller2: endAtController,
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
                          widget.valueSearchCourse.text = '';
                          drawerBloc.statusSaveData = true;
                          currentPageCourse = 1;
                          getArchivedCourse = operation.first;
                          statusCourse = statusCourseController.text;
                          teacher = teacherCourseController.text;
                          room = roomController.text;
                          subject = subjectController.text;
                          startAt = startAtController.text;
                          endAt = endAtController.text;
                          FiltersCourseModel filter = FiltersCourseModel(
                            pageNumber: currentPageCourse,
                            getArchived: getArchivedCourse,
                            status: statusCourse,
                            teacher: teacher,
                            room: room,
                            subject: subject,
                            startAt: startAt,
                            endAt: endAt,
                          );
                          widget.bloc.add(
                              FilterCoursesListEvent(coursesFilter2: filter));
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
              label: "حالة الدورة:",
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
