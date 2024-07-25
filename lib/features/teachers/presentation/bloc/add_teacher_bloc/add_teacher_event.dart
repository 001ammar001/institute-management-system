part of 'add_teacher_bloc.dart';

class AddUpdateTeacherEvent extends Equatable {
  final TeacherEntity teacher;
  const AddUpdateTeacherEvent({required this.teacher});

  @override
  List<Object> get props => [teacher];
}
