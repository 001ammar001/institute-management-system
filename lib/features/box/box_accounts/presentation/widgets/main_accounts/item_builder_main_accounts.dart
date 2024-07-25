import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/features/drawer/presentation/bloc/drawer_bloc.dart';
import '../../../data/models/accounts_model.dart';
import '../../bloc/list_main_accounts_bloc/main_accounts_bloc.dart';

class ItemBuilderMainAccount extends StatelessWidget {
  const ItemBuilderMainAccount({
    super.key,
    required this.bloc,
    required this.state,
    required this.mainAccounts,
  });

  final ListMainAccountsBloc bloc;
  final ListMainAccountsStates state;
  final AccountModelList mainAccounts;
  @override
  Widget build(BuildContext context) {
    DrawerBloc drawerBloc = BlocProvider.of<DrawerBloc>(context);
    return Expanded(
        flex: 8,
        child:
            (state is ListMainAccountsSuccessState || state is PageChangedState)
                ? ListView.builder(
                    itemCount: mainAccounts.data?.length,
                    itemBuilder: (context, index) {
                      final BoxAccount? mainAccount = mainAccounts.data?[index];
                      final isEven = index.isEven;
                      final backgroundColor =
                          isEven ? Colors.grey[200] : Colors.white;
                      const textColor = Colors.black;
                      return Container(
                        color: backgroundColor,
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Text('   ${mainAccount?.id}',
                                    style: const TextStyle(color: textColor))),
                            Expanded(
                                flex: 6,
                                child: Center(
                                  child: Text('${mainAccount?.name}',
                                      style: const TextStyle(
                                          color: textColor, fontSize: 17)),
                                )),
                          ],
                        ),
                      );
                    })
                : state is ListMainAccountsFailureState
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
