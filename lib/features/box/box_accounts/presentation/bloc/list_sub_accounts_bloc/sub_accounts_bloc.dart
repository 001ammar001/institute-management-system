import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/Errors/error_message_mapper.dart';
import '../../../data/models/accounts_model.dart';
import '../../../domain/usecases/delete_accounts_usecase.dart';
import '../../../domain/usecases/fetch_sub_accounts_usecase.dart';

part "sub_accounts_events.dart";
part "sub_accounts_states.dart";

class ListSubAccountsBloc
    extends Bloc<ListSubAccountsEvents, ListSubAccountsStates> {
  final FetchSubAccountsUseCase fetchSubAccountsUseCase;
  final DeleteAccountsUseCase deleteAccountUseCase;
  AccountModelList subAccounts = AccountModelList();

  String failureText = 'error';
  int currentPage = 1;
  int stateButtonArrowForwardSubAccount = 0;
  int stateButtonArrowBackSubAccount = 0;
  int stateButtonDeleteSubAccount = 0;

  ListSubAccountsBloc(
      {required this.fetchSubAccountsUseCase,
      required this.deleteAccountUseCase})
      : super(ListSubAccountsInitialState()) {
    on<SubAccountsEvents>(_getSubAccountsAll);
    on<CheckboxEvent>(_checkboxControl);
    on<DeleteSubAccountEvent>(_deleteSubAccount);
  }

  Future<void> _getSubAccountsAll(
      SubAccountsEvents event, Emitter<ListSubAccountsStates> emit) async {
    emit(ListSubAccountsLoadingState());
    final result =
        await fetchSubAccountsUseCase.call(pageNumber: event.currentPage);
    result.fold(
        (failure) => emit(
              ListSubAccountsFailureState(
                  message: mapFailureToMessage(failure)),
            ), (subAccount) {
      subAccounts = subAccount;
      emit(ListSubAccountsSuccessState(subAccount));
    });
  }

  Future<void> _checkboxControl(
      CheckboxEvent event, Emitter<ListSubAccountsStates> emit) async {
    emit(PageChangedState());
  }

  Future<void> _deleteSubAccount(
      DeleteSubAccountEvent event, Emitter<ListSubAccountsStates> emit) async {
    emit(ListSubAccountsLoadingState());
    final result = await deleteAccountUseCase.call(event.indexSubAccount);
    result.fold(
        (failure) => emit(
              DeleteSubAccountsFailureState(
                  message: mapFailureToMessage(failure)),
            ),
        (delete) {});
  }
}
