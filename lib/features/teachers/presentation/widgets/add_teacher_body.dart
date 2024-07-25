import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/functions/response_dialogs.dart';
import 'package:institute_management_system/core/utils/enums.dart';
import 'package:institute_management_system/core/widgets/buttons/submit_button.dart';
import 'package:institute_management_system/core/widgets/text_fields/disapled_text_field.dart';
import 'package:institute_management_system/core/widgets/text_fields/enabled_text_field.dart';
import 'package:institute_management_system/features/teachers/domain/entites/teacher_entity.dart';
import 'package:institute_management_system/features/teachers/presentation/bloc/add_teacher_bloc/add_teacher_bloc.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;

class AddTeacherBody extends StatelessWidget {
  const AddTeacherBody({
    this.id,
    super.key,
    required this.formKey,
    required this.nameController,
    required this.phoneNumberController,
    required this.birthDateController,
    required this.credentialsController,
  });

  final int? id;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController phoneNumberController;
  final TextEditingController birthDateController;
  final TextEditingController credentialsController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            EnabledTextField(
              label: "اسم الأستاذ بالغة العربية",
              controller: nameController,
            ),
            EnabledTextField(
              label: "رقم الهاتف",
              controller: phoneNumberController,
              isNumeric: true,
            ),
            DisabledTextField(
              label: "تاريخ الميلاد",
              controller: birthDateController,
              type: DialogTypeEnum.age,
            ),
            EnabledTextField(
              label: "الشهادات",
              controller: credentialsController,
            ),
            BlocProvider(
              create: (context) => getit.sl<AddTeacherBloc>(),
              child: BlocConsumer<AddTeacherBloc, AddTeacherStates>(
                listener: (context, state) {
                  if (state is TeacherAddUpdateSucessState) {
                    if (id == null) {
                      formKey.currentState!.reset();
                    }
                    showSucessSnackBar(context);
                  } else if (state is TeacherAddUpdateFailureState) {
                    showErrorSnackBar(context, state.message);
                  }
                },
                builder: (context, state) {
                  return SubmitButton(
                    isLoading: state is TeacherAddUpdateLoadingState,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final entity = TeacherEntity(
                            name: nameController.text,
                            phoneNumber: phoneNumberController.text,
                            birthDate: birthDateController.text,
                            credentials: credentialsController.text);
                        BlocProvider.of<AddTeacherBloc>(context)
                            .add(AddUpdateTeacherEvent(teacher: entity));
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
  }
}
