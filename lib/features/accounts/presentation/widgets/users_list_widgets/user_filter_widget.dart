import 'package:flutter/material.dart';
import 'package:institute_management_system/core/widgets/buttons/custom_segmented_buttons.dart';
import 'package:institute_management_system/core/widgets/buttons/yes_no_button.dart';
import 'package:institute_management_system/core/widgets/text_fields/enabled_text_field.dart';
import 'package:institute_management_system/features/accounts/presentation/bloc/list_users_bloc/list_users_bloc.dart';

class UserFilterWidget extends StatefulWidget {
  final ListUsersBloc bloc;
  const UserFilterWidget({
    super.key,
    required this.bloc,
  });

  @override
  State<UserFilterWidget> createState() => _UserFilterWidgetState();
}

class _UserFilterWidgetState extends State<UserFilterWidget> {
  late Set operation;
  late TextEditingController roleNameController;

  @override
  void initState() {
    super.initState();
    operation = {widget.bloc.getArchived};
    roleNameController = TextEditingController(
      text: widget.bloc.roleName,
    );
  }

  @override
  void dispose() {
    super.dispose();
    roleNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width / 2,
        height: MediaQuery.sizeOf(context).height / 1.5,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildOperationButton(),
              EnabledTextField(
                controller: roleNameController,
                label: "أسم الدور",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  YesNoButton(
                    yes: true,
                    onYesSubmited: () {
                      widget.bloc.getArchived = operation.first;
                      widget.bloc.roleName = roleNameController.text;
                      widget.bloc.add(const GetUsersEvent());
                    },
                  ),
                  const YesNoButton(
                    yes: false,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOperationButton() {
    return Row(
      children: [
        StatefulBuilder(
          builder: (context, setState) {
            return CustomSegmentedButton(
              label: "حالة الحساب:",
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
