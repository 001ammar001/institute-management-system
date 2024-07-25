import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants.dart';
import '../../../../core/widgets/table_screen/table_list_buttons_appbar.dart';
import '../../../../core/widgets/table_screen/table_list_component.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;

import '../bloc/list_employee_bloc/list_employees_bloc.dart';
import '../widgets/employee_list_pages.dart';
import 'add_employee_page.dart';

TextEditingController valueSearchEmployee = TextEditingController();

class ShowEmployeesScreen extends StatelessWidget {
  const ShowEmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    Size media = screenMedia(context);
    return BlocProvider(
      create: (context) => getit.sl<ListEmployeesBloc>()
        ..add(const EmployeesEvents(currentPage: 1)),
      child: Scaffold(
        body: TableListComponent(
          label: '',
          onSubmit: (){},
          search: valueSearchEmployee,
          function: () {
            screenStack.popScreen();
            bloc.add(ChangeWidgetEvent());
          },
          buttonsNum: 2,
          media: media,
          widgetButtons: Row(
            children: [
              TableListButtonsAppBar(
                function: () {},
                text: 'الفلاتر',
              ),
              const SizedBox(
                width: 20,
              ),
              TableListButtonsAppBar(function: () {
                screenStack.clearScreens();
                screenStack.pushScreen(
                    screen: const AddEmployeePage(),
                    title: "إضافة موظف");
                bloc.add(ChangeWidgetEvent());
              }, text: 'إضافة موظف')
            ],
          ),
          widgetPage: EmployeeListPageState(media: media),
        ),
      ),
    );
  }
}
