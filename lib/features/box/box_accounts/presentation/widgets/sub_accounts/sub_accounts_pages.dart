import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/functions/response_dialogs.dart';
import '../../bloc/list_sub_accounts_bloc/sub_accounts_bloc.dart';
import 'header_sub_accounts.dart';
import 'item_builder_sub_accounts.dart';

class SubAccountListPageState extends StatelessWidget {
  final Size media;

  const SubAccountListPageState({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    ListSubAccountsBloc bloc = BlocProvider.of<ListSubAccountsBloc>(context);
    return BlocConsumer<ListSubAccountsBloc, ListSubAccountsStates>(
        listener: (context, state) {
       if (state is ListSubAccountsFailureState) {
        bloc.failureText = state.message;
      }else if (state is DeleteSubAccountsFailureState) {
        showErrorSnackBar(context, state.message);
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Column(
          children: [
            HeaderListSubAccounts(media: media),
            ItemBuilderSubAccount(
              bloc: bloc,
              state: state,
              subAccounts: bloc.subAccounts,
            ),
          ],
        ),
      );
    });
  }
}
