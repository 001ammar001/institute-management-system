part of 'add_role_bloc.dart';

class AddUpdateRoleEvent extends Equatable {
  final RoleEntity role;
  const AddUpdateRoleEvent({required this.role});

  @override
  List<Object> get props => [];
}

