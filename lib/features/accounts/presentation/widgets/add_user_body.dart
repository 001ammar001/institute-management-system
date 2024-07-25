import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/functions/response_dialogs.dart';
import 'package:institute_management_system/core/utils/enums.dart';
import 'package:institute_management_system/core/widgets/buttons/submit_button.dart';
import 'package:institute_management_system/core/widgets/text_fields/enabled_text_field.dart';
import 'package:institute_management_system/core/widgets/text_fields/list_disapled_text_field.dart';
import 'package:institute_management_system/features/accounts/domain/entites/user_entity.dart';
import 'package:institute_management_system/features/accounts/presentation/bloc/add_user_bloc/add_user_bloc.dart';
import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;

class AddUserBody extends StatelessWidget {
  const AddUserBody({
    super.key,
    required this.formKey,
    required this.id,
    required this.nameController,
    required this.passwordController,
    required this.repasswordControlle,
    required this.employee,
    required this.role,
  });

  final int? id;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController passwordController;
  final TextEditingController repasswordControlle;
  final SearchEntity employee;
  final SearchEntity role;

  @override
  Widget build(BuildContext context) {
    bool passwordVisibilty = false;
    bool repasswordVisibilty = false;
    const space = SizedBox(height: 5);
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
          child: Column(
            children: [
              EnabledTextField(
                label: "اسم المستخدم",
                controller: nameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "هذا الحقل مطلوب";
                  } else if (value.contains(" ")) {
                    return "اسم المستخدم لا يجب ان يحوي فراغات";
                  }
                  return null;
                },
              ),
              space,
              StatefulBuilder(
                builder: (context, setState) {
                  return EnabledTextField(
                    label: "كلمة المرور",
                    controller: passwordController,
                    obsecure: passwordVisibilty,
                    validator: (value) {
                      if (value == null) {
                        return "كلمة السر يجب ان لاتكون فارغة";
                      } else if (value.length <= 7) {
                        return "كلمة السر يجب ان تكون من ثمانية محارف";
                      } else if (value.contains(" ")) {
                        return "كلمة السر يجب ان لا تحوي فراغات";
                      } else if (num.tryParse(value) is num) {
                        return "يجب على كلمة السر ان تحوي حرف واحد على الأقل";
                      } else if (value != repasswordControlle.text) {
                        return "كلمة السر غير متطابقة";
                      }
                      return null;
                    },
                    suffix: FittedBox(
                      child: IconButton(
                        icon: const Icon(Icons.shield),
                        onPressed: () {
                          setState(
                            () {
                              passwordVisibilty = !passwordVisibilty;
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              space,
              StatefulBuilder(
                builder: (context, setState) {
                  return EnabledTextField(
                    label: "تاكيد كلمة المرور",
                    obsecure: repasswordVisibilty,
                    controller: repasswordControlle,
                    suffix: IconButton(
                      splashRadius: 1,
                      icon: const Icon(Icons.shield),
                      onPressed: () {
                        setState(
                          () {
                            repasswordVisibilty = !repasswordVisibilty;
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              space,
              ListDisapledTextField(
                label: "الدور",
                searchEnity: role,
                searchType: SearchTypeEnum.role,
              ),
              space,
              ListDisapledTextField(
                label: "حساب الموظف",
                searchType: SearchTypeEnum.unattachedEmployee,
                searchEnity: employee,
                required: false,
              ),
              const SizedBox(height: 25),
              BlocProvider(
                create: (context) => getit.sl<AddUserBloc>(),
                child: BlocConsumer<AddUserBloc, AddUserStates>(
                  listener: (context, state) {
                    if (state is AddUserSucessState) {
                      if (id == null) {
                        formKey.currentState!.reset();
                        employee.reset();
                        role.reset();
                      }
                      showSucessSnackBar(context);
                    } else if (state is AddUserFailureState) {
                      showErrorSnackBar(context, state.message);
                    }
                  },
                  builder: (context, state) {
                    return SubmitButton(
                      isLoading: state is AddUserLoadingState,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final entity = UserEntity(
                            id: id,
                            username: nameController.text,
                            password: passwordController.text,
                            employee: employee,
                            role: role,
                          );
                          BlocProvider.of<AddUserBloc>(context)
                              .add(AddUserEvent(user: entity));
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
