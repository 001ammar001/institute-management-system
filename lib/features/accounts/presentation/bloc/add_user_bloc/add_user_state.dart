part of 'add_user_bloc.dart';

sealed class AddUserStates extends Equatable {
  const AddUserStates();

  @override
  List<Object> get props => [];
}

final class AddUserInitialState extends AddUserStates {}

final class AddUserLoadingState extends AddUserStates {}

final class AddUserFailureState extends AddUserStates {
  final String message;

  const AddUserFailureState({required this.message});
}

final class AddUserSucessState extends AddUserStates {}
