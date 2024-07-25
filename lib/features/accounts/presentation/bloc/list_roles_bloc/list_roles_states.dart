part of "list_role_bloc.dart";

abstract class ListRolesStates  {

}

class ListRolesInitialState extends ListRolesStates {}

class PageChangedState extends ListRolesStates {}

class DeleteRolesState extends ListRolesStates {}

class ChangeCounterState extends ListRolesStates {}

final class ListRolesSuccessState extends ListRolesStates {
  final RoleListEntity roles;
  ListRolesSuccessState(this.roles);
}

final class ListRolesLoadingState extends ListRolesStates {}

class ListRolesFailureState extends ListRolesStates {
  final String message;

   ListRolesFailureState({required this.message});
}

class DeleteRolesFailureState extends ListRolesStates {
  final String message;

  DeleteRolesFailureState({required this.message});
}




