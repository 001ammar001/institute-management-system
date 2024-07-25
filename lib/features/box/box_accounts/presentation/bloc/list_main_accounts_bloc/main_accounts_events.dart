part of "main_accounts_bloc.dart";

abstract class ListMainAccountsEvents extends Equatable {
  const ListMainAccountsEvents();

  @override
  List<Object?> get props => [];
}

class MainAccountsEvents extends ListMainAccountsEvents {
  final int currentPage;
  const MainAccountsEvents({required this.currentPage});
  @override
  List<Object?> get props => [currentPage];
}

class NextPageEvent extends ListMainAccountsEvents {}

class PreviousPageEvent extends ListMainAccountsEvents {}

class CheckboxEvent extends ListMainAccountsEvents {}

class DeleteMainAccountEvent extends ListMainAccountsEvents {
  final int indexMainAccount;
  const DeleteMainAccountEvent({required this.indexMainAccount});
  @override
  List<Object?> get props => [indexMainAccount];
}

class ControlMainAccountsPageEvent extends ListMainAccountsEvents {}
