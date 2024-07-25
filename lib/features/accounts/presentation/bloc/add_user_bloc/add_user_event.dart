part of 'add_user_bloc.dart';

class AddUserEvent extends Equatable {
  final UserEntity user;
  const AddUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}
