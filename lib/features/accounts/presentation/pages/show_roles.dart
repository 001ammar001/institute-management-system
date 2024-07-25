import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants.dart';
import '../../../../core/widgets/table_screen/table_list_buttons_appbar.dart';
import '../../../../core/widgets/table_screen/table_list_component.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';
import '../bloc/list_roles_bloc/list_role_bloc.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;

import '../widgets/role_list_pages.dart';
import 'add_role_page.dart';



TextEditingController valueSearchRole = TextEditingController();

class ShowRolesScreen extends StatelessWidget {
  const ShowRolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    Size media = screenMedia(context);
    return BlocProvider(
      create: (context) =>
          getit.sl<ListRolesBloc>()..add(const RolesEvents(currentPage: 1)),
      child: Scaffold(
        body: TableListComponent(
          label: '',
          onSubmit: (){},
          search: valueSearchRole,
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
              TableListButtonsAppBar(
                function: () {
                  screenStack.clearScreens();
                  screenStack.pushScreen(
                      screen: const AddRolePage(),
                      title: "الأدوار");
                  bloc.add(ChangeWidgetEvent());
                },
                text: 'إضافة دور',
              ),
            ],
          ),
          widgetPage: RoleListPageState(media: media),
        ),
      ),
    );
  }
}
