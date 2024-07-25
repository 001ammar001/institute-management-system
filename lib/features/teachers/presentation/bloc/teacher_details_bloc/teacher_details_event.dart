part of 'teacher_details_bloc.dart';

sealed class TeacherDetailsEvent extends Equatable {
  const TeacherDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetTeacherDetailEvent extends TeacherDetailsEvent {
  final int id;

  const GetTeacherDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}
