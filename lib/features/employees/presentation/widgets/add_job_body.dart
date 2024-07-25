import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/functions/response_dialogs.dart';
import 'package:institute_management_system/core/widgets/buttons/submit_button.dart';
import 'package:institute_management_system/core/widgets/text_fields/enabled_text_field.dart';
import 'package:institute_management_system/features/employees/domain/entites/job_entity.dart';
import 'package:institute_management_system/features/employees/presentation/bloc/add_job_bloc/add_job_bloc.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;

class AddJobBody extends StatelessWidget {
  const AddJobBody({
    super.key,
    required this.id,
    required this.formKey,
    required this.size,
    required this.nameController,
    required this.salaryController,
  });

  final int? id;
  final GlobalKey<FormState> formKey;
  final double size;
  final TextEditingController nameController;
  final TextEditingController salaryController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size * 0.15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 75),
                  child: EnabledTextField(
                    controller: nameController,
                    label: "اسم المسمى الوظيفي",
                  ),
                ),
                SizedBox(height: size * 0.10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 75),
                  child: EnabledTextField(
                    controller: salaryController,
                    isNumeric: true,
                    label: "الراتب",
                  ),
                ),
                SizedBox(height: size * 0.15),
                BlocProvider(
                  create: (context) => getit.sl<AddJobBloc>(),
                  child: BlocConsumer<AddJobBloc, AddJobStates>(
                    listener: (context, state) {
                      if (state is AddUpdateJobSucessState) {
                        if (id == null) {
                          formKey.currentState!.reset();
                        }
                        showSucessSnackBar(context);
                      } else if (state is AddUpdateJobFailureState) {
                        showErrorSnackBar(context, state.message);
                      }
                    },
                    builder: (context, state) {
                      return SubmitButton(
                        isLoading: state is AddUpdateJobLoadingState,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final entity = JobEntity(
                              id: id,
                              name: nameController.text,
                              baseSalary: int.parse(salaryController.text),
                            );

                            BlocProvider.of<AddJobBloc>(context)
                                .add(AddUpdateJobEvent(jobEntity: entity));
                          }
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
