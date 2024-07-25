import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/Errors/error_message_mapper.dart';
import '../../../domain/entites/role_list_entity.dart';
import '../../../domain/useCases/delete_role_usecase.dart';
import '../../../domain/useCases/fetch_role_usecase.dart';

part "list_roles_events.dart";
part "list_roles_states.dart";

class ListRolesBloc extends Bloc<ListRolesEvents, ListRolesStates> {
  final FetchRolesUseCase fetchRolesUseCase;
  final DeleteRoleUseCase deleteRoleUseCase;
  RoleListEntity roles = RoleListEntity();

  String failureText = 'error';
  int currentPage = 1;
  int stateButtonArrowForwardRole = 0;
  int stateButtonArrowBackRole = 0;
  int stateButtonDeleteRole = 0;

  ListRolesBloc(
      {required this.fetchRolesUseCase, required this.deleteRoleUseCase})
      : super(ListRolesInitialState()) {
    on<RolesEvents>(_getRolesAll);
    on<CheckboxEvent>(_checkboxControl);
    on<DeleteRoleEvent>(_deleteRole);
  }

  Future<void> _getRolesAll(
      RolesEvents event, Emitter<ListRolesStates> emit) async {
    emit(ListRolesLoadingState());
    final result = await fetchRolesUseCase.call(pageNumber: event.currentPage);
    result.fold(
        (failure) => emit(
              ListRolesFailureState(message: mapFailureToMessage(failure)),
            ), (role) {
      roles = role;
      emit(ListRolesSuccessState(role));
    });
  }

  Future<void> _checkboxControl(
      CheckboxEvent event, Emitter<ListRolesStates> emit) async {
    emit(PageChangedState());
  }

  Future<void> _deleteRole(
      DeleteRoleEvent event, Emitter<ListRolesStates> emit) async {
    emit(ListRolesLoadingState());
    final result = await deleteRoleUseCase.call(event.indexRole);
    result.fold(
        (failure) => emit(
              DeleteRolesFailureState(message: mapFailureToMessage(failure)),
            ), (delete) {
      roles.roles!.removeWhere((role) => role.id == event.indexRole);
    });
  }
}
