import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/features/accounts/presentation/bloc/list_users_bloc/list_users_bloc.dart';
import 'package:institute_management_system/features/accounts/presentation/widgets/users_list_widgets/user_filter_widget.dart';
import 'package:institute_management_system/features/accounts/presentation/widgets/users_list_widgets/user_list_pages.dart';
import '../../../../core/constants.dart';
import '../../../../core/widgets/table_screen/table_list_buttons_appbar.dart';
import '../../../../core/widgets/table_screen/table_list_component.dart';
import '../../../accounts/presentation/pages/add_user_page.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;

TextEditingController valueSearchUser = TextEditingController();

class ShowUsersScreen extends StatelessWidget {
  const ShowUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    Size media = screenMedia(context);
    return BlocProvider(
      create: (context) =>
          getit.sl<ListUsersBloc>()..add(const GetUsersEvent()),
      child: TableListComponent(
        label: '',
        onSubmit: (){},
        search: valueSearchUser,
        function: () {
          screenStack.popScreen();
          bloc.add(ChangeWidgetEvent());
        },
        buttonsNum: 2,
        media: media,
        widgetButtons: Row(
          children: [
            BlocBuilder<ListUsersBloc, ListUsersStates>(
              builder: (context, state) {
                return TableListButtonsAppBar(
                  function: () {
                    if (state is! ListUsersLoadingState) {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return UserFilterWidget(
                            bloc: BlocProvider.of<ListUsersBloc>(context),
                          );
                        },
                      );
                    }
                  },
                  text: 'الفلاتر',
                );
              },
            ),
            const SizedBox(
              width: 20,
            ),
            TableListButtonsAppBar(
                function: () {
                  screenStack.pushScreen(
                      screen: const AddUserPage(), title: "إضافة مستخدم");
                  bloc.add(ChangeWidgetEvent());
                },
                text: 'إضافة مستخدم')
          ],
        ),
        widgetPage: UserListPageBody(media: media),
      ),
    );
  }
}
