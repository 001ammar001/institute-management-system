import 'package:flutter/material.dart';

import '../../../../core/widgets/text_fields/enabled_text_field.dart';

class ChangePassword extends StatelessWidget {
   const ChangePassword({
    super.key,
    required this.type,
    required this.passwordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
    this.bloc,
  });

  final String type;
  final TextEditingController passwordController ;
  final TextEditingController newPasswordController ;
  final TextEditingController confirmPasswordController ;
  final dynamic bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [//  bloc.changeFields();  ,
      MaterialButton(
          height: 75,
          minWidth: 170,
          elevation: 2.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.yellow,
          onPressed: () {
            bloc.changeFields();
            newPasswordController.text='';
            confirmPasswordController.text='';
          },
          child:  Text(
            bloc.statusChangePassword==false?"تعديل كلمة المرور":"عدم تعديل كلمة المرور",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black87,
              overflow: TextOverflow.ellipsis,
            ),
          )),
      const SizedBox(
        height: 20,
      ),
      bloc.statusChangePassword==true?EnabledTextField(
        controller: newPasswordController,
        label: 'كلمة المرور الجديدة',):const SizedBox(),
      const SizedBox(
        height: 20,
      ),
      bloc.statusChangePassword==true?EnabledTextField(
        controller: confirmPasswordController,
        label: 'تأكيد كلمة المرور',):const SizedBox(),
    ]);
  }
}