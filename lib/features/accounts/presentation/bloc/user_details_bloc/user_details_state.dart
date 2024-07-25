part of 'user_details_bloc.dart';

sealed class UserDetailsState extends Equatable {
  const UserDetailsState();

  @override
  List<Object> get props => [];
}

final class UserDetailsInitial extends UserDetailsState {}

final class UserDetailsLoadedState extends UserDetailsState {
  final UserDetailsEntity userDetailsEntity;
  const UserDetailsLoadedState({required this.userDetailsEntity});
}

final class UserDetailsLoadingState extends UserDetailsState {}

final class UserDetailFailureState extends UserDetailsState {
  final String message;
  const UserDetailFailureState({required this.message});
}
