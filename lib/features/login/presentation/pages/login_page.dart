import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/functions/navigator.dart';
import 'package:institute_management_system/core/functions/response_dialogs.dart';
import 'package:institute_management_system/features/drawer/presentation/pages/drawer_page.dart';
import 'package:institute_management_system/features/login/presentation/manager/cubit/login_cubit.dart';
import 'package:institute_management_system/features/login/presentation/manager/cubit/login_state.dart';

import '../../../../core/utils/Network/local/shared_preferences.dart';
import '../widgets/login_and_update.dart';

class LoginPage extends StatefulWidget {
  final String type;
  const LoginPage({super.key, required this.type});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  late GlobalKey<FormState> formKey;
  late final String type;

  _LoginPageState();

  @override
  void initState() {
    super.initState();
    type = widget.type;
    userNameController = TextEditingController(
      text: type == 'Login' ? '' : CacheHelper.getData(key: "userName"),
    );
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    passwordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  void resetFields() {
    passwordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          LoginCubit bloc = BlocProvider.of<LoginCubit>(context);
          if (state is LoginSuccessState) {
            navigateAndFinish(context, const HomeScreen());
          }
          if (state is LoginErrorState) {
            showErrorSnackBar(context, state.error);
            formKey.currentState!.reset();
          }
          if (state is UpdateDataSuccessState) {
            showSucessSnackBar(context);
            formKey.currentState!.reset();
            bloc.statusChangePassword == true ? bloc.changeFields() : null;
            resetFields();
          }
          if (state is UpdateDataErrorState) {
            showErrorSnackBar(context, state.error);
            formKey.currentState!.reset();
          }
        },
        builder: (context, state) {
          LoginCubit bloc = BlocProvider.of<LoginCubit>(context);
          return LoginAndUpdate(
            bloc: bloc,
            type: type,
            formKey: formKey,
            userNameController: userNameController,
            passwordController: passwordController,
            newPasswordController: newPasswordController,
            confirmPasswordController: confirmPasswordController,
            state: state,
            submit: () {
              if (formKey.currentState!.validate()) {
                if (type == 'Login') {
                  BlocProvider.of<LoginCubit>(context).loginUser(
                    userName: userNameController.value.text,
                    password: passwordController.value.text,
                  );
                } else {
                  BlocProvider.of<LoginCubit>(context).updateDataLogin(
                    userName: userNameController.value.text,
                    password: passwordController.value.text,
                    newPassword: newPasswordController.value.text,
                    confirmPassword: confirmPasswordController.value.text,
                  );
                }
              }
            },
          );
        },
      ),
    );
  }
}

