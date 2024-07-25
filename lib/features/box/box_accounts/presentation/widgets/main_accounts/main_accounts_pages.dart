import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/functions/response_dialogs.dart';
import '../../bloc/list_main_accounts_bloc/main_accounts_bloc.dart';
import 'header_main_accounts.dart';
import 'item_builder_main_accounts.dart';

class MainAccountListPageState extends StatelessWidget {
  final Size media;

  const MainAccountListPageState({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    ListMainAccountsBloc bloc = BlocProvider.of<ListMainAccountsBloc>(context);
    return BlocConsumer<ListMainAccountsBloc, ListMainAccountsStates>(
        listener: (context, state) {
       if (state is ListMainAccountsFailureState) {
        bloc.failureText = state.message;
      }else if (state is DeleteMainAccountsFailureState) {
        showErrorSnackBar(context, state.message);
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Column(
          children: [
            HeaderListMainAccounts(media: media),
            ItemBuilderMainAccount(
              bloc: bloc,
              state: state,
              mainAccounts: bloc.mainAccounts,
            ),
          ],
        ),
      );
    });
  }
}
