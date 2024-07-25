import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/functions/response_dialogs.dart';
import '../../../../core/widgets/table_screen/buttons_pages_row.dart';
import '../bloc/list_roles_bloc/list_role_bloc.dart';
import 'header_list_roles.dart';
import 'item_builder_role.dart';

class RoleListPageState extends StatelessWidget {
  final Size media;

  const RoleListPageState({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    ListRolesBloc bloc = BlocProvider.of<ListRolesBloc>(context);
    return BlocConsumer<ListRolesBloc, ListRolesStates>(
        listener: (context, state) {
      if (state is ListRolesSuccessState) {
        bloc.stateButtonArrowForwardRole = 0;
        bloc.stateButtonArrowBackRole = 0 ;
        bloc.stateButtonDeleteRole=0;
      } else if (state is ListRolesFailureState) {
        bloc.failureText = state.message;
      }else if (state is DeleteRolesFailureState) {
        showErrorSnackBar(context, state.message);
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Column(
          children: [
            HeaderListRoles(media: media),
            ItemBuilderRole(
              bloc: bloc,
              state: state,
              roleList: bloc.roles,
            ),
            ButtonsPagesRow(
              pageNumber: bloc.currentPage,
              onPresBack: () {
                  if (bloc.stateButtonArrowBackRole == 0) {
                    if (bloc.currentPage > 1) {
                      bloc.currentPage--;
                      BlocProvider.of<ListRolesBloc>(context)
                          .add(RolesEvents(currentPage: bloc.currentPage));
                    }
                    bloc.stateButtonArrowBackRole++;
                  }
              },
              onPresForward: () {
                if (bloc.stateButtonArrowForwardRole == 0) {
                  if (bloc.roles.meta!.currentPage! <
                      bloc.roles.meta!.lastPage!) {
                    bloc.currentPage++;
                    BlocProvider.of<ListRolesBloc>(context)
                        .add(RolesEvents(currentPage: bloc.currentPage));
                  }
                  bloc.stateButtonArrowForwardRole++;
                }
              },
            ),
          ],
        ),
      );
    });
  }
}
