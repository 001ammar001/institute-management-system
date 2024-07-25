import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/functions/response_dialogs.dart';
import 'package:institute_management_system/core/widgets/buttons/submit_button.dart';
import 'package:institute_management_system/core/widgets/text_fields/enabled_text_field.dart';
import 'package:institute_management_system/features/accounts/domain/entites/role_entity.dart';
import 'package:institute_management_system/features/accounts/presentation/bloc/add_role_bloc/add_role_bloc.dart';
import 'package:institute_management_system/features/accounts/presentation/bloc/role_details_bloc/role_details_bloc.dart';
import 'package:institute_management_system/features/accounts/presentation/widgets/permission_widget.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;

class AddRoleBody extends StatelessWidget {
  const AddRoleBody(
      {this.id,
      super.key,
      required this.formKey,
      required this.nameController,
      required this.detailsState});

  final int? id;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final RoleDetailsState detailsState;

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = MediaQuery.of(context).size.width >= 500 ? 2 : 1;
    print("in build");
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 50),
        child: Column(
          children: [
            EnabledTextField(
              label: "اسم الدور",
              controller: nameController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "هذا الحقل مطلوب";
                } else if (!detailsState.chosedPermissions.contains(true)) {
                  return "يجب ان يتم اختيار صلاحية واحدة على الأقل";
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            Expanded(
              child: GridView.builder(
                itemCount: detailsState.permissions.length,
                padding: const EdgeInsets.all(12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisExtent: 50,
                  crossAxisSpacing: 50,
                  mainAxisSpacing: 25,
                ),
                itemBuilder: (context, index) =>
                    StatefulBuilder(builder: (context, setState) {
                  return PermissionWidget(
                    name: detailsState.permissions[index].name,
                    value: detailsState.chosedPermissions[index],
                    valueChanged: (value) {
                      setState(
                        () {
                          detailsState.chosedPermissions[index] = value;
                        },
                      );
                    },
                  );
                }),
              ),
            ),
            const SizedBox(height: 10),
            BlocProvider(
              create: (context) => getit.sl<AddRoleBloc>(),
              child: BlocConsumer<AddRoleBloc, AddRoleStates>(
                listener: (context, state) {
                  if (state is AddUpdateRoleSucessState) {
                    if (id == null) {
                      BlocProvider.of<RoleDetailsBloc>(context)
                          .add(RoleFormResetEvent());
                    }
                    showSucessSnackBar(context);
                  } else if (state is AddUpdateRoleFailureState) {
                    showErrorSnackBar(context, state.message);
                  }
                },
                builder: (context, state) {
                  return SubmitButton(
                    isLoading: state is AddUpdateRoleLoadingState,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final entity = RoleEntity(
                          id: id,
                          name: nameController.text,
                          permissions: detailsState.mapPermissions(),
                        );
                        BlocProvider.of<AddRoleBloc>(context)
                            .add(AddUpdateRoleEvent(role: entity));
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
