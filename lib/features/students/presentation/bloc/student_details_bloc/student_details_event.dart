part of 'student_details_bloc.dart';

sealed class StudentDetailsEvent extends Equatable {
  const StudentDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetStudentDetailEvent extends StudentDetailsEvent {
  final int id;

  const GetStudentDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}
