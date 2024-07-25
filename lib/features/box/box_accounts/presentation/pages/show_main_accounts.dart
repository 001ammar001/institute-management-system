import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/widgets/table_screen/table_list_component.dart';
import '../../../../drawer/presentation/bloc/drawer_bloc.dart';
import '../bloc/list_main_accounts_bloc/main_accounts_bloc.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;

import '../widgets/main_accounts/main_accounts_pages.dart';

TextEditingController valueSearchMainAccount = TextEditingController();

class ShowMainAccountsScreen extends StatelessWidget {
  const ShowMainAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    Size media = screenMedia(context);
    return BlocProvider(
      create: (context) => getit.sl<ListMainAccountsBloc>()
        ..add(const MainAccountsEvents(currentPage: 1)),
      child: Scaffold(
        body: TableListComponent(
          label: '',
          onSubmit: () {},
          search: valueSearchMainAccount,
          function: () {
            screenStack.popScreen();
            bloc.add(ChangeWidgetEvent());
          },
          buttonsNum: 2,
          media: media,
          widgetButtons: const Row(
            children: [],
          ),
          widgetPage: MainAccountListPageState(media: media),
        ),
      ),
    );
  }
}
