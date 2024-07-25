part of 'role_details_bloc.dart';

sealed class RoleDetailsEvent extends Equatable {
  const RoleDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetPermissionsEvent extends RoleDetailsEvent {
  final int? id;

  const GetPermissionsEvent({this.id});
}

class GetRoleDetailEvent extends RoleDetailsEvent {
  final int id;

  const GetRoleDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class RoleFormResetEvent extends RoleDetailsEvent {}
