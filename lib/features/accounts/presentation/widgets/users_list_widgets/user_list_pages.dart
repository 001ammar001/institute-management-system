import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/functions/response_dialogs.dart';
import 'package:institute_management_system/core/widgets/table_screen/buttons_pages_row.dart';
import 'package:institute_management_system/features/accounts/presentation/bloc/list_users_bloc/list_users_bloc.dart';
import 'header_list_users.dart';
import 'item_builder_user.dart';

class UserListPageBody extends StatelessWidget {
  final Size media;

  const UserListPageBody({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    ListUsersBloc bloc = BlocProvider.of<ListUsersBloc>(context);
    return BlocConsumer<ListUsersBloc, ListUsersStates>(
        listener: (context, state) {
      if (state is UsersOperationFailureState) {
        showErrorSnackBar(context, state.message);
      }
    }, builder: (context, state) {
      return Column(
        children: [
          HeaderListUsers(media: media),
          ItemBuilderUser(
            bloc: bloc,
            state: state,
            users: bloc.users,
          ),
          ButtonsPagesRow(
            pageNumber: bloc.currentPage,
            onPresBack: () {
              if (state is! ListUsersLoadingState) {
                if (bloc.currentPage > 1) {
                  bloc.currentPage--;
                  BlocProvider.of<ListUsersBloc>(context)
                      .add(const GetUsersEvent());
                }
              }
            },
            onPresForward: () {
              if (state is! ListUsersLoadingState) {
                if (bloc.users.meta!.currentPage! <
                    bloc.users.meta!.lastPage!) {
                  bloc.currentPage++;
                  BlocProvider.of<ListUsersBloc>(context)
                      .add(const GetUsersEvent());
                }
              }
            },
          ),
        ],
      );
    });
  }
}
