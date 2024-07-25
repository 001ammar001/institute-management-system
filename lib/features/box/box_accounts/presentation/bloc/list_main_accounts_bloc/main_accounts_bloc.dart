import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/Errors/error_message_mapper.dart';
import '../../../data/models/accounts_model.dart';
import '../../../domain/usecases/fetch_main_accounts_usecase.dart';



part "main_accounts_events.dart";
part "main_accounts_states.dart";

class ListMainAccountsBloc extends Bloc<ListMainAccountsEvents, ListMainAccountsStates> {
  final FetchMainAccountsUseCase fetchMainAccountsUseCase;
  AccountModelList mainAccounts = AccountModelList();

  String failureText = 'error';

  ListMainAccountsBloc({required this.fetchMainAccountsUseCase,})
      : super(ListMainAccountsInitialState()) {
    on<MainAccountsEvents>(_getMainAccountsAll);
    on<CheckboxEvent>(_checkboxControl);
    //on<DeleteMainAccountEvent>(_deleteMainAccount);
  }

  FutureOr<void> _getMainAccountsAll(MainAccountsEvents event,
      Emitter<ListMainAccountsStates> emit) async {
    emit(ListMainAccountsLoadingState());
    final result = await fetchMainAccountsUseCase.call(
        pageNumber: event.currentPage);
    result.fold(
            (failure) =>
            emit(
              ListMainAccountsFailureState(message: mapFailureToMessage(failure)),
            ), (listMainAccount) {
              mainAccounts=listMainAccount;
      emit(ListMainAccountsSuccessState(listMainAccount));
    });
  }

  FutureOr<void> _checkboxControl(CheckboxEvent event,
      Emitter<ListMainAccountsStates> emit) async {
    emit(PageChangedState());
  }

}




