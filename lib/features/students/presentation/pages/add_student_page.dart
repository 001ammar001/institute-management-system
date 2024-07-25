import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/functions/response_dialogs.dart';
import 'package:institute_management_system/core/utils/enums.dart';
import 'package:institute_management_system/core/widgets/buttons/custom_segmented_buttons.dart';
import 'package:institute_management_system/core/widgets/buttons/resend_button.dart';
import 'package:institute_management_system/core/widgets/buttons/submit_button.dart';
import 'package:institute_management_system/core/widgets/text_fields/disapled_text_field.dart';
import 'package:institute_management_system/core/widgets/text_fields/enabled_text_field.dart';
import 'package:institute_management_system/core/widgets/text_fields/pairs/pair_of_enabled_fields.dart';
import 'package:institute_management_system/features/students/domain/entites/student_entity.dart';
import 'package:institute_management_system/features/students/presentation/bloc/add_student_bloc/add_student_bloc.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;
import 'package:institute_management_system/features/students/presentation/bloc/student_details_bloc/student_details_bloc.dart';
import '../../../../core/constants.dart';
import '../../../../core/widgets/title_back_button.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';

class AddStudentPage extends StatefulWidget {
  final int? id;
  const AddStudentPage({this.id, super.key});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  late TextEditingController aNameController;
  late TextEditingController eNameController;
  late TextEditingController aFatherNameController;
  late TextEditingController eFatherNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController lineNumberController;
  late TextEditingController bioController;
  late TextEditingController afullMotherNameController;
  late TextEditingController efulleMotherNameController;
  late TextEditingController idNumberController;
  late TextEditingController dateOfBrithController;
  late TextEditingController nationalityController;
  late GlobalKey<FormState> formKey;

  late Set gender;

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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlocProvider(
        create: (context) {
          final bloc = getit.sl<StudentDetailsBloc>();
          if (widget.id != null) {
            bloc.add(GetStudentDetailEvent(id: widget.id!));
          }
          return bloc;
        },
        child: BlocConsumer<StudentDetailsBloc, StudentDetailsStates>(
          listener: (context, state) {
            if (state is StudentDataLoadedState) {
              _populateFileds(state.student);
            }
          },
          builder: (context, state) {
            if (state is StudentDataLoadingState && widget.id != null) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StudentDataFailureState) {
              return ReseendButton(
                message: state.message,
                onPressed: () {
                  BlocProvider.of<StudentDetailsBloc>(context)
                      .add(GetStudentDetailEvent(id: widget.id!));
                },
              );
            }
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TitleWhitBackButton(
                      function: () {
                        screenStack.popScreen();
                        bloc.add(ChangeWidgetEvent());
                      },
                      text: widget.id != null ? "تعديل طالب" : 'إضافة طالب',
                    ),
                    PairOfEnabledField(
                      label1: "اسم الطالب بالغة العربية",
                      controller1: aNameController,
                      label2: "اسم الطالب بالغة الإنكليزية",
                      controller2: eNameController,
                    ),
                    PairOfEnabledField(
                      label1: "اسم الأب بالغة العربية",
                      controller1: aFatherNameController,
                      label2: "اسم الأب بالغة الإنكليزية",
                      controller2: eFatherNameController,
                    ),
                    PairOfEnabledField(
                      label1: "اسم الأم بالغة العربية",
                      controller1: afullMotherNameController,
                      label2: "اسم الأم بالغة الإنكليزية",
                      controller2: efulleMotherNameController,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: DisabledTextField(
                            label: "تاريخ الميلاد",
                            controller: dateOfBrithController,
                            type: DialogTypeEnum.age,
                          ),
                        ),
                        const Spacer(),
                        _buildgenderButtons()
                      ],
                    ),
                    PairOfEnabledField(
                      label1: "رقم الجوال",
                      controller1: phoneNumberController,
                      label2: "رقم الهاتف",
                      controller2: lineNumberController,
                      isNumeric1: true,
                      isNumeric2: true,
                    ),
                    PairOfEnabledField(
                      label1: "الرقم الوطني",
                      controller1: idNumberController,
                      label2: "الجنسية",
                      controller2: nationalityController,
                      isNumeric1: true,
                      isRequired1: false,
                      isRequired2: false,
                    ),
                    EnabledTextField(
                      controller: bioController,
                      label: "المرحلة الدراسية",
                    ),
                    const SizedBox(height: 10),
                    BlocProvider(
                      create: (context) => getit.sl<AddStudentBloc>(),
                      child: BlocConsumer<AddStudentBloc, AddStudentStates>(
                        listener: (context, state) {
                          if (state is StudentAddUpdateSucessState) {
                            if (widget.id == null) {
                              formKey.currentState!.reset();
                              setState(() {
                                gender = {"M"};
                              });
                            }
                            showSucessSnackBar(context);
                          } else if (state is StudentAddUpdateFailureState) {
                            showErrorSnackBar(context, state.message);
                          }
                        },
                        builder: (context, state) {
                          return SubmitButton(
                            isLoading: state is StudentAddUpdateLoadingState,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                _peformSend(context);
                              }
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _peformSend(context) {
    final entity = StudentEnity(
      id: widget.id,
      aName: aNameController.text,
      eName: eNameController.text,
      fArName: aFatherNameController.text,
      fEnName: eFatherNameController.text,
      mArName: afullMotherNameController.text,
      mEnName: efulleMotherNameController.text,
      birthDate: dateOfBrithController.text,
      lineNumber: lineNumberController.text,
      phoneNumber: phoneNumberController.text,
      gender: gender.first,
      nationality: nationalityController.text,
      nationalNumber: idNumberController.text,
      educationLevel: bioController.text,
    );
    BlocProvider.of<AddStudentBloc>(context)
        .add(AddUpdateStudentEvent(student: entity));
  }

  void _initControllers() {
    aNameController = TextEditingController();
    eNameController = TextEditingController();
    aFatherNameController = TextEditingController();
    eFatherNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    afullMotherNameController = TextEditingController();
    efulleMotherNameController = TextEditingController();
    idNumberController = TextEditingController();
    dateOfBrithController = TextEditingController();
    nationalityController = TextEditingController();
    lineNumberController = TextEditingController();
    bioController = TextEditingController();
    gender = {"M"};
    formKey = GlobalKey<FormState>();
  }

  void _disposeControllers() {
    aNameController.dispose();
    eNameController.dispose();
    aFatherNameController.dispose();
    eFatherNameController.dispose();
    phoneNumberController.dispose();
    afullMotherNameController.dispose();
    efulleMotherNameController.dispose();
    idNumberController.dispose();
    dateOfBrithController.dispose();
    lineNumberController.dispose();
    bioController.dispose();
    nationalityController.dispose();
  }

  StatefulBuilder _buildgenderButtons() {
    return StatefulBuilder(
      builder: (context, setState) {
        return CustomSegmentedButton(
          label: ":الجنس",
          selectedValue: gender,
          onSelectionChanged: (data) {
            setState(() {
              gender = data;
            });
          },
          segments: const [
            ButtonSegment(
              value: "M",
              label: Text(
                "ذكر",
                softWrap: false,
              ),
            ),
            ButtonSegment(
              value: "F",
              label: Text(
                "انثى",
                softWrap: false,
              ),
            ),
          ],
        );
      },
    );
  }

  void _populateFileds(StudentEnity student) {
    aNameController.text = student.aName;
    eNameController.text = student.eName;
    aFatherNameController.text = student.fArName;
    eFatherNameController.text = student.fEnName;
    phoneNumberController.text = student.phoneNumber;
    lineNumberController.text = student.lineNumber;
    bioController.text = student.educationLevel;
    afullMotherNameController.text = student.mArName;
    efulleMotherNameController.text = student.mEnName;
    idNumberController.text = student.nationalNumber;
    dateOfBrithController.text = student.birthDate;
    nationalityController.text = student.nationality;
    gender = {student.gender};
  }
}
