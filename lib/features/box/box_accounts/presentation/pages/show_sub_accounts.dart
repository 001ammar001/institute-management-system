import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/widgets/table_screen/table_list_buttons_appbar.dart';
import '../../../../../core/widgets/table_screen/table_list_component.dart';
import '../../../../drawer/presentation/bloc/drawer_bloc.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;

import '../bloc/list_sub_accounts_bloc/sub_accounts_bloc.dart';
import '../widgets/sub_accounts/sub_accounts_pages.dart';



TextEditingController valueSearchSubAccount = TextEditingController();

class ShowSubAccountsScreen extends StatelessWidget {
  const ShowSubAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    Size media = screenMedia(context);
    return BlocProvider(
      create: (context) =>
          getit.sl<ListSubAccountsBloc>()..add(const SubAccountsEvents(currentPage: 1)),
      child: Scaffold(
        body: TableListComponent(
          label: '',
          onSubmit: (){},
          search: valueSearchSubAccount,
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
            ],
          ),
          widgetPage: SubAccountListPageState(media: media),
        ),
      ),
    );
  }
}
