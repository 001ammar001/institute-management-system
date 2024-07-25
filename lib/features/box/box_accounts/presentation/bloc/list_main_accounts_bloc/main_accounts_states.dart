part of "main_accounts_bloc.dart";

abstract class ListMainAccountsStates  {

}

class ListMainAccountsInitialState extends ListMainAccountsStates {}

class PageChangedState extends ListMainAccountsStates {}

class DeleteMainAccountsState extends ListMainAccountsStates {}

class ChangeCounterState extends ListMainAccountsStates {}

final class ListMainAccountsSuccessState extends ListMainAccountsStates {
  final AccountModelList mainAccounts;
  ListMainAccountsSuccessState(this.mainAccounts);
}

final class ListMainAccountsLoadingState extends ListMainAccountsStates {}

class ListMainAccountsFailureState extends ListMainAccountsStates {
  final String message;

   ListMainAccountsFailureState({required this.message});
}

class DeleteMainAccountsFailureState extends ListMainAccountsStates {
  final String message;

  DeleteMainAccountsFailureState({required this.message});
}




