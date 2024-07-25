part of "sub_accounts_bloc.dart";

abstract class ListSubAccountsStates  {

}

class ListSubAccountsInitialState extends ListSubAccountsStates {}

class PageChangedState extends ListSubAccountsStates {}

class DeleteSubAccountsState extends ListSubAccountsStates {}

class ChangeCounterState extends ListSubAccountsStates {}

final class ListSubAccountsSuccessState extends ListSubAccountsStates {
  final AccountModelList subAccounts;
  ListSubAccountsSuccessState(this.subAccounts);
}

final class ListSubAccountsLoadingState extends ListSubAccountsStates {}

class ListSubAccountsFailureState extends ListSubAccountsStates {
  final String message;

   ListSubAccountsFailureState({required this.message});
}

class DeleteSubAccountsFailureState extends ListSubAccountsStates {
  final String message;

  DeleteSubAccountsFailureState({required this.message});
}




