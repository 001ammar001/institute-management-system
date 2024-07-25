import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/features/accounts/domain/useCases/edit_user_usecase.dart';
import 'package:institute_management_system/features/accounts/domain/useCases/restore_user_usecase.dart';

import '../../../../../core/Errors/error_message_mapper.dart';
import '../../../data/models/user_model_list.dart';
import '../../../domain/useCases/delete_user_usecase.dart';
import '../../../domain/useCases/fetch_users_usecase.dart';

part "list_users_events.dart";
part "list_users_states.dart";

class ListUsersBloc extends Bloc<ListUsersEvents, ListUsersStates> {
  final FetchUsersUseCase fetchUsersUseCase;
  final DeleteUserUseCase deleteUserUseCase;
  final EditUserUseCase editUserUseCase;
  final RestoreUserUseCase restoreUserUseCase;

  bool getArchived = false;
  String roleName = "";
  UserModelList users = UserModelList();
  int currentPage = 1;

  ListUsersBloc(
      {required this.fetchUsersUseCase,
      required this.deleteUserUseCase,
      required this.editUserUseCase,
      required this.restoreUserUseCase})
      : super(ListUsersLoadingState()) {
    on<GetUsersEvent>(_getUsersAll);
    on<CheckboxEvent>(_checkboxControl);
    on<DeleteUserEvent>(_deleteUser);
    on<EditUserEvent>(_editUser);
    on<RestoreUserEvent>(_restoreUser);
  }

  FutureOr<void> _getUsersAll(
      GetUsersEvent event, Emitter<ListUsersStates> emit) async {
    emit(ListUsersLoadingState());
    final result = await fetchUsersUseCase(currentPage, getArchived, roleName);
    result.fold(
        (failure) => emit(
              ListUsersFailureState(message: mapFailureToMessage(failure)),
            ), (listUser) {
      users = listUser;
      emit(ListUsersSuccessState(listUser));
    });
  }

  FutureOr<void> _editUser(
      EditUserEvent event, Emitter<ListUsersStates> emit) async {
    emit(ListUsersLoadingState());
    final result = await editUserUseCase(event.user);
    result.fold(
        (failure) => emit(
              UsersOperationFailureState(message: mapFailureToMessage(failure)),
            ), (_) {
      emit(UserEditSucessState());
    });
    add(const GetUsersEvent());
  }

  FutureOr<void> _restoreUser(
      RestoreUserEvent event, Emitter<ListUsersStates> emit) async {
    emit(ListUsersLoadingState());
    final result = await restoreUserUseCase(event.indexUser);
    result.fold(
        (failure) => emit(
              UsersOperationFailureState(message: mapFailureToMessage(failure)),
            ),
        (_) {});
    add(const GetUsersEvent());
  }

  FutureOr<void> _checkboxControl(
      CheckboxEvent event, Emitter<ListUsersStates> emit) async {
    emit(PageChangedState());
  }

  FutureOr<void> _deleteUser(
      DeleteUserEvent event, Emitter<ListUsersStates> emit) async {
    emit(ListUsersLoadingState());
    final result = await deleteUserUseCase(event.indexUser);
    result.fold(
        (failure) => emit(
              UsersOperationFailureState(message: mapFailureToMessage(failure)),
            ), (_) {
      emit(UserDeleteSucessState());
    });
    add(const GetUsersEvent());
  }
}
