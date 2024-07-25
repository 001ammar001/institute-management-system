part of 'add_role_bloc.dart';

sealed class AddRoleStates extends Equatable {
  const AddRoleStates();

  @override
  List<Object> get props => [];
}

final class AddUpdateRoleInitialState extends AddRoleStates {}

final class AddUpdateRoleLoadingState extends AddRoleStates {}

final class AddUpdateRoleFailureState extends AddRoleStates {
  final String message;

  const AddUpdateRoleFailureState({required this.message});
}

final class AddUpdateRoleSucessState extends AddRoleStates {}
