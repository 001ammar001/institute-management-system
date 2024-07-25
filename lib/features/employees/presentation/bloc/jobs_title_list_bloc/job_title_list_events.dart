part of "job_title_list_bloc.dart";

abstract class JobTitleListEvents extends Equatable {
  const JobTitleListEvents();

  @override
  List<Object?> get props => [];
}

class GetJobTitlteEvent extends JobTitleListEvents {}

class CheckboxEvent extends JobTitleListEvents {}

class DeleteJobTitleEvent extends JobTitleListEvents {
  final int jobTitleId;
  const DeleteJobTitleEvent({required this.jobTitleId});
  @override
  List<Object?> get props => [jobTitleId];
}
