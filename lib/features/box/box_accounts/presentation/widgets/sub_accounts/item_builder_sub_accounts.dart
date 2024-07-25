import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/features/drawer/presentation/bloc/drawer_bloc.dart';
import '../../../../../../core/widgets/bodies_alert_dialogs/body_delete.dart';
import '../../../../../../core/widgets/table_screen/icons_options.dart';
import '../../../data/models/accounts_model.dart';
import '../../bloc/list_sub_accounts_bloc/sub_accounts_bloc.dart';

class ItemBuilderSubAccount extends StatelessWidget {
  const ItemBuilderSubAccount({
    super.key,
    required this.bloc,
    required this.state,
    required this.subAccounts,
  });

  final ListSubAccountsBloc bloc;
  final ListSubAccountsStates state;
  final AccountModelList subAccounts;
  @override
  Widget build(BuildContext context) {
    DrawerBloc drawerBloc = BlocProvider.of<DrawerBloc>(context);
    return Expanded(
        flex: 8,
        child:
            (state is ListSubAccountsSuccessState || state is PageChangedState)
                ? ListView.builder(
                    itemCount: subAccounts.data?.length,
                    itemBuilder: (context, index) {
                      final BoxAccount? subAccount = subAccounts.data?[index];
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
                                child: Text('   ${subAccount?.id}',
                                    style: const TextStyle(color: textColor))),
                            Expanded(
                                flex: 6,
                                child: Center(
                                  child: Text('${subAccount?.name}',
                                      style: const TextStyle(
                                          color: textColor, fontSize: 17)),
                                )),
                            Expanded(
                              flex: 1,
                              child: IconsRowOptions(
                                item: subAccount,
                                checkBox: (newValue) {
                                  BlocProvider.of<ListSubAccountsBloc>(context)
                                      .add(CheckboxEvent());
                                  subAccount?.index = newValue!;
                                  if (newValue!) {
                                    //Bloc.subAccounts.add(value);
                                  }
                                },
                                delete: () {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  alertDialogGeneral(
                                    title: "هل أنت متأكد من حذف هذا العنصر",
                                    context: context,
                                    submitFunction: () {
                                      BlocProvider.of<ListSubAccountsBloc>(context).add(
                                          DeleteSubAccountEvent(indexSubAccount: subAccount!.id!));
                                      BlocProvider.of<ListSubAccountsBloc>(context).add(
                                          SubAccountsEvents(
                                              currentPage: bloc.currentPage));
                                    },
                                  );
                                },
                                edit: () {},
                              ),
                            ),
                          ],
                        ),
                      );
                    })
                : state is ListSubAccountsFailureState
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
