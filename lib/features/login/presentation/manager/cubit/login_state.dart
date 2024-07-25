abstract class LoginState {}

final class LoginInitialState extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginSuccessState extends LoginState {}

final class LoginErrorState extends LoginState {
  String error;

  LoginErrorState({required this.error});
}

final class LogOutSuccessState extends LoginState {}

final class UpdateDataLoadingState extends LoginState {}

final class UpdateDataSuccessState extends LoginState {}

final class UpdateDataErrorState extends LoginState {
  String error;

  UpdateDataErrorState({required this.error});
}

final class ChangeFieldsState extends LoginState {}