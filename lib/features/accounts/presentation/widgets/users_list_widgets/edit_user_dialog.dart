import 'package:flutter/material.dart';
import 'package:institute_management_system/core/utils/enums.dart';
import 'package:institute_management_system/core/widgets/buttons/yes_no_button.dart';
import 'package:institute_management_system/core/widgets/custom_text.dart';
import 'package:institute_management_system/core/widgets/text_fields/list_disapled_text_field.dart';
import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';

class UserEditDialog extends StatelessWidget {
  const UserEditDialog({
    super.key,
    required this.role,
    required this.employee,
    required this.onSubmit,
  });

  final SearchEntity role;
  final SearchEntity employee;
  final Function() onSubmit;

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
              const CustomText25(
                text: "تعديل بيانات الحساب",
              ),
              ListDisapledTextField(
                label: "الدور",
                searchType: SearchTypeEnum.role,
                searchEnity: role,
              ),
              ListDisapledTextField(
                label: "الموظف",
                searchType: SearchTypeEnum.unattachedEmployee,
                searchEnity: employee,
                required: false,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  YesNoButton(
                    yes: true,
                    onYesSubmited: () {
                      onSubmit();
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
}
