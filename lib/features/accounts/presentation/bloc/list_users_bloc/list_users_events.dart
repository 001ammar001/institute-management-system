part of "list_users_bloc.dart";

abstract class ListUsersEvents extends Equatable {
  const ListUsersEvents();

  @override
  List<Object?> get props => [];
}

class GetUsersEvent extends ListUsersEvents {
  const GetUsersEvent();
  @override
  List<Object?> get props => [];
}

class CheckboxEvent extends ListUsersEvents {}

class DeleteUserEvent extends ListUsersEvents {
  final int indexUser;
  const DeleteUserEvent({required this.indexUser});
  @override
  List<Object?> get props => [indexUser];
}

class EditUserEvent extends ListUsersEvents {
  final User user;
  const EditUserEvent({required this.user});
  @override
  List<Object?> get props => [user];
}

class RestoreUserEvent extends ListUsersEvents {
  final int indexUser;
  const RestoreUserEvent({required this.indexUser});
  @override
  List<Object?> get props => [indexUser];
}