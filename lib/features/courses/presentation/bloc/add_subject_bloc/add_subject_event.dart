part of 'add_subject_bloc.dart';

final class AddUpdateSubjectEvent extends Equatable {
  final SubjectEntity subject;

  const AddUpdateSubjectEvent({required this.subject});

  @override
  List<Object> get props => [subject];
}
