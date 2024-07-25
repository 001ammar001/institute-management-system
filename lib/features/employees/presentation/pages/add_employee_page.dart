import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/widgets/buttons/resend_button.dart';
import 'package:institute_management_system/core/widgets/title_back_button.dart';
import 'package:institute_management_system/features/employees/domain/entites/employee_entity.dart';
import 'package:institute_management_system/features/employees/presentation/bloc/employee_detials_bloc/employee_details_bloc.dart';
import 'package:institute_management_system/features/employees/presentation/widgets/add_employee_body.dart';
import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;
import '../../../../core/constants.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';

class AddEmployeePage extends StatefulWidget {
  final int? id;
  const AddEmployeePage({this.id, super.key});

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  late TextEditingController nameController;
  late TextEditingController phoneNumberController;
  late TextEditingController credentialsController;
  late TextEditingController birthDateController;
  late SearchEntity shift;
  late SearchEntity job;
  late SearchEntity user;

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
            text: widget.id == null ? "إضافة موظف" : "تعديل موظف",
          ),
          Expanded(
            child: BlocProvider(
              create: (context) {
                final bloc = getit.sl<EmployeeDetailsBloc>();
                if (widget.id != null) {
                  bloc.add(GetEmployeeDetailEvent(id: widget.id!));
                }
                return bloc;
              },
              child: BlocConsumer<EmployeeDetailsBloc, EmployeeDetailsStates>(
                listener: (context, state) {
                  if (state is EmployeeDataLoadedState) {
                    _populateFileds(state.employee);
                  }
                },
                builder: (context, state) {
                  if (state is EmployeeDataLoadingState && widget.id != null) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is EmployeeDataFailureState) {
                    return ReseendButton(
                      message: state.message,
                      onPressed: () {
                        BlocProvider.of<EmployeeDetailsBloc>(context)
                            .add(GetEmployeeDetailEvent(id: widget.id!));
                      },
                    );
                  }
                  return AddEmployeeBody(
                    formKey: formKey,
                    id: widget.id,
                    nameController: nameController,
                    phoneNumberController: phoneNumberController,
                    birthDateController: birthDateController,
                    credentialsController: credentialsController,
                    job: job,
                    shift: shift,
                    user: user,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _populateFileds(EmployeeEntity employee) {
    nameController.text = employee.name;
    phoneNumberController.text = employee.phoneNumber;
    birthDateController.text = employee.birthDate;
    credentialsController.text = employee.credentials;

    shift.update(
      SearchEntity(id: employee.shift.id, name: employee.shift.name),
    );

    job.update(
      SearchEntity(id: employee.job.id, name: employee.job.name),
    );

    if (employee.user != null) {
      user.update(
        SearchEntity(id: employee.user!.id, name: employee.user!.name),
      );
    }
  }

  void _initControllers() {
    nameController = TextEditingController();
    phoneNumberController = TextEditingController();
    birthDateController = TextEditingController();
    credentialsController = TextEditingController();
    shift = SearchEntity();
    job = SearchEntity();
    user = SearchEntity();
    formKey = GlobalKey<FormState>();
  }

  void _disposeControllers() {
    nameController.dispose();
    phoneNumberController.dispose();
    birthDateController.dispose();
    credentialsController.dispose();
    job.dispose();
    shift.dispose();
    user.dispose();
  }
}
