part of "list_users_bloc.dart";

abstract class ListUsersStates {}

class PageChangedState extends ListUsersStates {}

final class ListUsersSuccessState extends ListUsersStates {
  final UserModelList users;
  ListUsersSuccessState(this.users);
}

final class ListUsersLoadingState extends ListUsersStates {}

class ListUsersFailureState extends ListUsersStates {
  final String message;

  ListUsersFailureState({required this.message});
}

class UserDeleteSucessState extends ListUsersStates {}

class UserEditSucessState extends ListUsersStates {}

class UsersOperationFailureState extends ListUsersStates {
  final String message;

  UsersOperationFailureState({required this.message});
}
