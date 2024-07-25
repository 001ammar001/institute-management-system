import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/constants.dart';
import 'package:institute_management_system/features/drawer/presentation/bloc/drawer_bloc.dart';
import 'package:institute_management_system/features/employees/presentation/pages/employee_details_page.dart';
import '../../../../core/widgets/bodies_alert_dialogs/body_delete.dart';
import '../../../../core/widgets/table_screen/icons_options.dart';
import '../../data/models/employee_model_list.dart';
import '../bloc/list_employee_bloc/list_employees_bloc.dart';

class ItemBuilderEmployee extends StatelessWidget {
  const ItemBuilderEmployee({
    super.key,
    required this.bloc,
    required this.state,
    required this.employees,
  });

  final ListEmployeesBloc bloc;
  final ListEmployeesStates state;
  final EmployeeModelList employees;

  @override
  Widget build(BuildContext context) {
    DrawerBloc drawerBloc = BlocProvider.of<DrawerBloc>(context);
    return Expanded(
        flex: 8,
        child: (state is ListEmployeesSuccessState || state is PageChangedState)
            ? ListView.builder(
                itemCount: employees.data?.length,
                itemBuilder: (context, index) {
                  final Employees? employee = employees.data?[index];
                  final isEven = index.isEven;
                  final backgroundColor =
                      isEven ? Colors.grey[200] : Colors.white;
                  const textColor = Colors.black;
                  return GestureDetector(
                    onTap: () {
                      screenStack.pushScreen(
                          screen: EmployeeDetailsPage(id: employee!.id!),
                          title: "تفاصيل الاستاذ");
                      drawerBloc.add(ChangeWidgetEvent());
                    },
                    child: Container(
                      color: backgroundColor,
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text('   ${employee?.id}',
                                  style: const TextStyle(color: textColor))),
                          Expanded(
                              flex: 6,
                              child: Center(
                                child: Text('${employee?.name}',
                                    style: const TextStyle(color: textColor)),
                              )),
                          Expanded(
                              flex: 6,
                              child: Center(
                                child: Text('${employee?.jobTitle?.name}',
                                    style: const TextStyle(color: textColor)),
                              )),
                          Expanded(
                              flex: 6,
                              child: Center(
                                child: Text("${employee?.jobTitle?.baseSalary}",
                                    style: const TextStyle(color: textColor)),
                              )),
                          Expanded(
                            flex: 2,
                            child: IconsRowOptions(
                              item: employee,
                              checkBox: (newValue) {
                                BlocProvider.of<ListEmployeesBloc>(context)
                                    .add(CheckboxEvent());
                                employee?.index = newValue!;
                                if (newValue!) {
                                  //Bloc.employees.add(value);
                                }
                              },
                              delete: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                alertDialogGeneral(
                                  title: "هل أنت متأكد من حذف هذا العنصر",
                                  context: context,
                                  submitFunction: () {
                                    BlocProvider.of<ListEmployeesBloc>(context)
                                        .add(DeleteEmployeeEvent(
                                            indexEmployee: employee!.id!));
                                    BlocProvider.of<ListEmployeesBloc>(context)
                                        .add(EmployeesEvents(
                                            currentPage: bloc.currentPage));
                                  },
                                );
                              },
                              edit: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
            : state is ListEmployeesFailureState
                ? Center(
                    child: Text(
                      bloc.failureText,
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ));
  }
}
