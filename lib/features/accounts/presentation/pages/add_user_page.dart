import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/widgets/title_back_button.dart';
import 'package:institute_management_system/features/accounts/presentation/widgets/add_user_body.dart';
import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';
import '../../../../core/constants.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';

class AddUserPage extends StatefulWidget {
  final int? id;
  const AddUserPage({this.id, super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController repasswordControlle;
  late SearchEntity employee;
  late SearchEntity role;

  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  @override
  void dispose() {
    super.dispose();
    _disposeControllers();
  }

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TitleWhitBackButton(
            function: () {
              screenStack.popScreen();
              bloc.add(ChangeWidgetEvent());
            },
            text: widget.id == null ? "إضافة مستخدم" : "تعديل موظف",
          ),
          Expanded(
              child: AddUserBody(
            formKey: formKey,
            id: widget.id,
            nameController: nameController,
            passwordController: passwordController,
            repasswordControlle: repasswordControlle,
            employee: employee,
            role: role,
          )),
        ],
      ),
    );
  }

  void _initControllers() {
    nameController = TextEditingController();
    passwordController = TextEditingController();
    repasswordControlle = TextEditingController();
    employee = SearchEntity();
    role = SearchEntity();
    formKey = GlobalKey<FormState>();
  }

  void _disposeControllers() {
    nameController.dispose();
    passwordController.dispose();
    repasswordControlle.dispose();
    employee.dispose();
    role.dispose();
  }
}
