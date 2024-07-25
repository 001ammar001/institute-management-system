part of "list_role_bloc.dart";

abstract class ListRolesEvents extends Equatable {
  const ListRolesEvents();

  @override
  List<Object?> get props => [];
}

class RolesEvents extends ListRolesEvents {
  final int currentPage;
  const RolesEvents({required this.currentPage});
  @override
  List<Object?> get props => [currentPage];
}

class NextPageEvent extends ListRolesEvents {}

class PreviousPageEvent extends ListRolesEvents {}

class CheckboxEvent extends ListRolesEvents {}

class DeleteRoleEvent extends ListRolesEvents {
  final int indexRole;
  const DeleteRoleEvent({required this.indexRole});
  @override
  List<Object?> get props => [indexRole];
}

class ControlRolesPageEvent extends ListRolesEvents {}
