part of 'user_details_bloc.dart';

sealed class UserDetailsEvent extends Equatable {
  const UserDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetUserDetailsEvent extends UserDetailsEvent {
  final int id;
  const GetUserDetailsEvent({required this.id});
  @override
  List<Object> get props => [id];
}
