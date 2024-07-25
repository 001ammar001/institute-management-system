part of "sub_accounts_bloc.dart";

abstract class ListSubAccountsEvents extends Equatable {
  const ListSubAccountsEvents();

  @override
  List<Object?> get props => [];
}

class SubAccountsEvents extends ListSubAccountsEvents {
  final int currentPage;
  const SubAccountsEvents({required this.currentPage});
  @override
  List<Object?> get props => [currentPage];
}

class NextPageEvent extends ListSubAccountsEvents {}

class PreviousPageEvent extends ListSubAccountsEvents {}

class CheckboxEvent extends ListSubAccountsEvents {}

class DeleteSubAccountEvent extends ListSubAccountsEvents {
  final int indexSubAccount;
  const DeleteSubAccountEvent({required this.indexSubAccount});
  @override
  List<Object?> get props => [indexSubAccount];
}

class ControlSubAccountsPageEvent extends ListSubAccountsEvents {}
