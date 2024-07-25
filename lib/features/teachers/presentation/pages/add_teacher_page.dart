import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/constants.dart';
import 'package:institute_management_system/core/widgets/buttons/resend_button.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;
import 'package:institute_management_system/core/widgets/title_back_button.dart';
import 'package:institute_management_system/features/teachers/domain/entites/teacher_entity.dart';
import 'package:institute_management_system/features/teachers/presentation/bloc/teacher_details_bloc/teacher_details_bloc.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';
import '../widgets/add_teacher_body.dart';

class AddTeacherPage extends StatefulWidget {
  final int? id;
  const AddTeacherPage({super.key, this.id});

  @override
  State<AddTeacherPage> createState() => _AddTeacherPageState();
}

class _AddTeacherPageState extends State<AddTeacherPage> {
  late TextEditingController nameController;
  late TextEditingController phoneNumberController;
  late TextEditingController birthDateController;
  late TextEditingController credentialsController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneNumberController = TextEditingController();
    birthDateController = TextEditingController();
    credentialsController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    birthDateController.dispose();
    credentialsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TitleWhitBackButton(
            function: () {
              screenStack.popScreen();
              bloc.add(ChangeWidgetEvent());
            },
            text: widget.id != null ? "تعديل استاذ" : 'إضافة استاذ',
          ),
          Expanded(
            child: BlocProvider(
              create: (context) {
                final bloc = getit.sl<TeacherDetailsBloc>();
                if (widget.id != null) {
                  bloc.add(GetTeacherDetailEvent(id: widget.id!));
                }
                return bloc;
              },
              child: BlocConsumer<TeacherDetailsBloc, TeacherDetailsStates>(
                listener: (context, state) {
                  if (state is TeacherDataLoadedState) {
                    _populateFileds(state.teacher);
                  }
                },
                builder: (context, state) {
                  if (state is TeacherDataLoadingState && widget.id != null) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TeacherDataFailureState) {
                    return ReseendButton(
                      message: state.message,
                      onPressed: () {
                        BlocProvider.of<TeacherDetailsBloc>(context)
                            .add(GetTeacherDetailEvent(id: widget.id!));
                      },
                    );
                  }
                  return AddTeacherBody(
                    id: widget.id,
                    formKey: formKey,
                    nameController: nameController,
                    phoneNumberController: phoneNumberController,
                    birthDateController: birthDateController,
                    credentialsController: credentialsController,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _populateFileds(TeacherEntity teacher) {
    nameController.text = teacher.name;
    phoneNumberController.text = teacher.phoneNumber;
    birthDateController.text = teacher.birthDate;
    credentialsController.text = teacher.credentials;
  }
}
