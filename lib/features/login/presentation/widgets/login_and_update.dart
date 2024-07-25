import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/widgets/buttons/submit_button.dart';
import '../../../../core/widgets/text_fields/enabled_text_field.dart';
import '../manager/cubit/login_state.dart';

class LoginAndUpdate extends StatelessWidget {
  const LoginAndUpdate({
    super.key,
    required this.formKey,
    required this.userNameController,
    required this.passwordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.submit,
    required this.state,
    required this.type,
    this.bloc,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final Function submit;
  final dynamic state;
  final String type;
  final dynamic bloc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (type == 'Login')
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.amber.shade300),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/7070629_3293466.svg')
                ],
              ),
            ),
          ),
        Expanded(
            child: Stack(alignment: Alignment.center, children: [
          Container(
            color: type == 'Login' ? Colors.amber.shade100 : Colors.grey[100],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              width: 400,
              height: type == 'Login' ? 450 : 700,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          //type: 'Login',
                          type == 'Login'
                              ? 'تسجيل الدخول'
                              : 'تعديل بيانات الحساب',
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        EnabledTextField(
                          controller: userNameController,
                          label: type == 'Login'
                              ? 'اسم المستخدم'
                              : 'تعديل اسم المستخدم',
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        EnabledTextField(
                            controller: passwordController,
                            label: 'كلمة المرور'),
                        const SizedBox(
                          height: 40,
                        ),
                        if (type != 'Login')
                          Column(children: [
                            //  bloc.changeFields();  ,
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
                                  newPasswordController.text = '';
                                  confirmPasswordController.text = '';
                                },
                                child: Text(
                                  bloc.statusChangePassword == false
                                      ? "تعديل كلمة المرور"
                                      : "عدم تعديل كلمة المرور",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            bloc.statusChangePassword == true
                                ? EnabledTextField(
                                    controller: newPasswordController,
                                    label: 'كلمة المرور الجديدة',
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 20,
                            ),
                            bloc.statusChangePassword == true
                                ? EnabledTextField(
                                    controller: confirmPasswordController,
                                    label: 'تأكيد كلمة المرور',
                                  )
                                : const SizedBox(),
                          ]),
                        const SizedBox(
                          height: 20,
                        ),
                        SubmitButton(
                            text: type == 'Login' ? 'إرسال' : 'تعديل',
                            onPressed: () async {
                              submit();
                            },
                            isLoading: state is LoginLoadingState ||
                                state is UpdateDataLoadingState)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ])),
      ],
    );
  }
}
