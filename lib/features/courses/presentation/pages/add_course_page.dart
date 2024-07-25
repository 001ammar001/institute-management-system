import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:institute_management_system/core/functions/response_dialogs.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;
import 'package:institute_management_system/core/utils/enums.dart';
import 'package:institute_management_system/core/widgets/buttons/custom_segmented_buttons.dart';
import 'package:institute_management_system/core/widgets/buttons/resend_button.dart';
import 'package:institute_management_system/core/widgets/buttons/submit_button.dart';
import 'package:institute_management_system/core/widgets/text_fields/enabled_text_field.dart';
import 'package:institute_management_system/core/widgets/text_fields/list_disapled_text_field.dart';
import 'package:institute_management_system/core/widgets/text_fields/pairs/pair_of_disabled_fields.dart';
import 'package:institute_management_system/core/widgets/buttons/week_day_selector.dart';
import 'package:institute_management_system/core/widgets/text_fields/pairs/pair_of_enabled_fields.dart';
import 'package:institute_management_system/core/widgets/text_fields/pairs/pair_of_list_disabled_field.dart';
import 'package:institute_management_system/core/widgets/title_back_button.dart';
import 'package:institute_management_system/features/courses/domain/entites/course_entity.dart';
import 'package:institute_management_system/features/courses/domain/entites/procurement_item.dart';
import 'package:institute_management_system/features/courses/presentation/bloc/add_course_bloc/add_coures_bloc.dart';
import 'package:institute_management_system/features/courses/presentation/bloc/coures_details_bloc/course_details_bloc.dart';
import 'package:institute_management_system/features/courses/presentation/widgets/procurement_dialog.dart';
import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';

import '../../../../core/constants.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';
import 'add_subject_page.dart';

class AddCoursePage extends StatefulWidget {
  final int? id;
  const AddCoursePage({this.id, super.key});

  @override
  State<AddCoursePage> createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  SearchEntity teacher = SearchEntity();
  SearchEntity subject = SearchEntity();
  SearchEntity room = SearchEntity();

  late TextEditingController minNumberController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;
  late TextEditingController priceToStudentController;
  late TextEditingController teacherSalaryController;
  late GlobalKey<FormState> formKey;

  Set<int> selectdDays = {};
  List<ProcurementItemEntity> procurementItems = [];
  Set selectdSalaryType = {"C"};
  Set selectdStatusType = {"P"};

  String status = "قيد العمل";

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  @override
  void dispose() {
    super.dispose();
    _disposeControllers();
  }

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocProvider(
          create: (context) {
            final bloc = getit.sl<CourseDetailsBloc>();
            if (widget.id != null) {
              bloc.add(GetCourseDetailEvent(id: widget.id!));
            }
            return bloc;
          },
          child: BlocConsumer<CourseDetailsBloc, CourseDetailsStates>(
            listener: (context, state) {
              if (state is CouresDataLoadedState) {
                _populateFileds(state.course);
              }
            },
            builder: (context, state) {
              if (state is CouresDataLoadingState && widget.id != null) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CouresDataFailureState) {
                return ReseendButton(
                  message: state.message,
                  onPressed: () {
                    BlocProvider.of<CourseDetailsBloc>(context)
                        .add(GetCourseDetailEvent(id: widget.id!));
                  },
                );
              }
              return _buidBody(bloc, context);
            },
          ),
        ),
      ),
    );
  }

  Widget _buidBody(DrawerBloc bloc, BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TitleWhitBackButton(
              text: widget.id != null ? "تعديل دورة" : "إضافة دورة جديدة",
              function: () {
                screenStack.popScreen();
                bloc.add(ChangeWidgetEvent());
              },
            ),
            PairOfListDisabledField(
              label1: "المادة",
              searchEnity1: subject,
              searchType1: SearchTypeEnum.subject,
              add1: (){
                navigator?.pop();
                screenStack.pushScreen(
                    screen: const AddSubjectPage(),
                    title: "إضافة مادة تدريبية");
                bloc.add(ChangeWidgetEvent());
              },
              label2: "الأستاذ",
              searchEnity2: teacher,
              searchType2: SearchTypeEnum.teacher,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 3,
                    child: ListDisapledTextField(
                      label: "الغرفة",
                      searchEnity: room,
                      searchType: SearchTypeEnum.room,
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 3,
                    child: EnabledTextField(
                      label: "أقل عدد طلاب لفتح الدورة",
                      controller: minNumberController,
                    ),
                  ),
                ],
              ),
            ),
            PairOfDisabledField(
              label1: "تاريخ البادية",
              controller1: startDateController,
              label2: "تاريخ النهاية",
              controller2: endDateController,
              type: DialogTypeEnum.date,
            ),
            PairOfDisabledField(
              label1: "وقت البداية",
              controller1: startTimeController,
              label2: "وقت النهاية",
              controller2: endTimeController,
              type: DialogTypeEnum.time,
            ),
            PairOfEnabledField(
                label1: "السعر للطالب",
                controller1: priceToStudentController,
                label2: "راتب الأستاذ",
                controller2: teacherSalaryController),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildSalaryButtons(),
                  const Spacer(),
                  _buildStatusButtons(),
                ],
              ),
            ),
            WeekDaySelector(
              days: selectdDays,
            ),
            Row(
              children: [
                BlocProvider(
                  create: (context) => getit.sl<AddCourseBloc>(),
                  child: BlocConsumer<AddCourseBloc, AddCourseStates>(
                    listener: (context, state) {
                      if (state is AddUpdateCourseSucessState) {
                        if (widget.id == null) {
                          formKey.currentState!.reset();
                          setState(() {
                            selectdDays = {};
                            teacher.reset();
                            room.reset();
                            subject.reset();
                            selectdSalaryType = {"C"};
                            selectdStatusType = {"P"};
                          });
                        }
                        showSucessSnackBar(context);
                      } else if (state is AddUpdateCourseFailureState) {
                        showErrorSnackBar(context, state.message);
                      }
                    },
                    builder: (context, state) {
                      return SubmitButton(
                        isLoading: state is AddUpdateCourseLoadingState,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final entity = CourseEntity(
                              teacher: teacher,
                              subject: subject,
                              room: room,
                              minStudent: int.parse(minNumberController.text),
                              startDate: startDateController.text,
                              endDate: endDateController.text,
                              startTime: startTimeController.text,
                              endTime: endTimeController.text,
                              priceToStudent:
                                  int.parse(priceToStudentController.text),
                              teacherSalary:
                                  int.parse(teacherSalaryController.text),
                              days: selectdDays,
                              selectedSalartType: selectdSalaryType.first,
                              courseStatus: selectdStatusType.first,
                            );

                            BlocProvider.of<AddCourseBloc>(context)
                                .add(AddUpdateCouresEvent(course: entity));
                          }
                        },
                      );
                    },
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 40,
                  width: MediaQuery.sizeOf(context).width * .175,
                  child: MaterialButton(
                    color: Colors.yellow,
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        return ProcurementListDialog(
                          procurementItems: procurementItems,
                        );
                      },
                    ).then((value) {
                      procurementItems = value;
                    }),
                    child: const Text("إضافة مشتريات"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  StatefulBuilder _buildSalaryButtons() {
    return StatefulBuilder(
      builder: (context, setState) {
        return CustomSegmentedButton(
          label: "نوع راتب الأستاذ",
          selectedValue: selectdSalaryType,
          onSelectionChanged: (data) {
            setState(() {
              selectdSalaryType = data;
            });
          },
          segments: const [
            ButtonSegment(
              value: "C",
              label: Text(
                "دورة",
                softWrap: false,
              ),
            ),
            ButtonSegment(
              value: "S",
              label: Text(
                "ساعي",
                softWrap: false,
              ),
            ),
          ],
        );
      },
    );
  }

  StatefulBuilder _buildStatusButtons() {
    return StatefulBuilder(
      builder: (context, setState) {
        return CustomSegmentedButton(
          label: "حالة الكورس",
          selectedValue: selectdStatusType,
          onSelectionChanged: (data) {
            setState(() {
              selectdStatusType = data;
            });
          },
          segments: [
            const ButtonSegment(
              value: "C",
              label: Text(
                "ملغى",
                softWrap: false,
              ),
            ),
            const ButtonSegment(
              value: "P",
              label: Text(
                "معلق",
                softWrap: false,
              ),
            ),
            ButtonSegment(
              value: "O",
              label: Text(
                status,
                softWrap: false,
              ),
            ),
          ],
        );
      },
    );
  }

  void _initControllers() {
    minNumberController = TextEditingController();
    startDateController = TextEditingController();
    endDateController = TextEditingController();
    startTimeController = TextEditingController();
    endTimeController = TextEditingController();
    priceToStudentController = TextEditingController();
    teacherSalaryController = TextEditingController();

    formKey = GlobalKey<FormState>();
  }

  void _disposeControllers() {
    minNumberController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    priceToStudentController.dispose();
    teacherSalaryController.dispose();
    teacher.dispose();
    subject.dispose();
    room.dispose();
  }

  void _populateFileds(CourseEntity course) {
    teacher = course.teacher;
    subject = course.subject;
    room = course.room;

    minNumberController.text = course.minStudent.toString();
    startDateController.text = course.startDate;
    endDateController.text = course.endDate;
    startTimeController.text = course.startTime;
    endTimeController.text = course.endTime;
    priceToStudentController.text = course.priceToStudent.toString();
    teacherSalaryController.text = course.teacherSalary.toString();

    selectdDays = course.days;
    procurementItems = [];
    selectdSalaryType = {course.selectedSalartType};
    selectdStatusType = {course.getStatusValue()};

    status = course.courseStatus;
  }
}
