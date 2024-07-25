import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/functions/response_dialogs.dart';
import 'package:institute_management_system/core/utils/enums.dart';
import 'package:institute_management_system/core/widgets/buttons/submit_button.dart';
import 'package:institute_management_system/core/widgets/text_fields/disapled_text_field.dart';
import 'package:institute_management_system/core/widgets/text_fields/enabled_text_field.dart';
import 'package:institute_management_system/core/widgets/text_fields/list_disapled_text_field.dart';
import 'package:institute_management_system/features/employees/domain/entites/employee_entity.dart';
import 'package:institute_management_system/features/employees/presentation/bloc/add_employee_bloc/add_employee_bloc.dart';
import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;

class AddEmployeeBody extends StatelessWidget {
  const AddEmployeeBody({
    super.key,
    required this.formKey,
    required this.id,
    required this.nameController,
    required this.phoneNumberController,
    required this.birthDateController,
    required this.credentialsController,
    required this.job,
    required this.shift,
    required this.user,
  });

  final int? id;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController phoneNumberController;
  final TextEditingController birthDateController;
  final TextEditingController credentialsController;
  final SearchEntity job;
  final SearchEntity shift;
  final SearchEntity user;

  @override
  Widget build(BuildContext context) {
    const space = SizedBox(height: 5);
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 100, right: 100),
          child: Column(
            children: [
              EnabledTextField(
                label: "اسم الموظف",
                controller: nameController,
              ),
              space,
              EnabledTextField(
                label: "رقم الهاتف",
                controller: phoneNumberController,
                isNumeric: true,
              ),
              space,
              DisabledTextField(
                label: "تاريخ الميلاد",
                controller: birthDateController,
                type: DialogTypeEnum.age,
              ),
              space,
              EnabledTextField(
                label: "الشهادات",
                controller: credentialsController,
              ),
              space,
              ListDisapledTextField(
                label: "المسمى الوظيفي",
                searchType: SearchTypeEnum.job,
                searchEnity: job,
              ),
              space,
              ListDisapledTextField(
                label: "الوردية",
                searchType: SearchTypeEnum.shifts,
                searchEnity: shift,
              ),
              ListDisapledTextField(
                label: "المستخدم",
                required: false,
                searchType: SearchTypeEnum.unattachedAccount,
                searchEnity: user,
              ),
              const SizedBox(height: 25),
              BlocProvider(
                create: (context) => getit.sl<AddEmployeeBloc>(),
                child: BlocConsumer<AddEmployeeBloc, AddEmployeetates>(
                  listener: (context, state) {
                    if (state is AddUpdateEmployeeSucessState) {
                      if (id == null) {
                        formKey.currentState!.reset();
                        job.reset();
                        shift.reset();
                        user.reset();
                      }
                      showSucessSnackBar(context);
                    } else if (state is AddUpdateEmployeeFailureState) {
                      showErrorSnackBar(context, state.message);
                    }
                  },
                  builder: (context, state) {
                    return SubmitButton(
                      isLoading: state is AddUpdateEmployeeLoadingState,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final entity = EmployeeEntity(
                              id: id,
                              name: nameController.text,
                              birthDate: birthDateController.text,
                              phoneNumber: phoneNumberController.text,
                              credentials: credentialsController.text,
                              job: job,
                              shift: shift,
                              user: user);
                          BlocProvider.of<AddEmployeeBloc>(context).add(
                              AddUpdateEmployeeEvent(employeeEntity: entity));
                        }
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
