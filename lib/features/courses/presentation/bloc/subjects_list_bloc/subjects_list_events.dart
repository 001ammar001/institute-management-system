part of "subjects_list_bloc.dart";

abstract class SubjectListEvents extends Equatable {
  const SubjectListEvents();

  @override
  List<Object?> get props => [];
}

class GetSubjectsEvent extends SubjectListEvents {}

class CheckboxEvent extends SubjectListEvents {}

class DeleteSubjectEvent extends SubjectListEvents {
  final int subjectId;
  const DeleteSubjectEvent({required this.subjectId});
  @override
  List<Object?> get props => [subjectId];
}
