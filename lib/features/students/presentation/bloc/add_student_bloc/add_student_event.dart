part of 'add_student_bloc.dart';

class AddUpdateStudentEvent extends Equatable {
  final StudentEnity student;
  const AddUpdateStudentEvent({required this.student});

  @override
  List<Object> get props => [student];
}
