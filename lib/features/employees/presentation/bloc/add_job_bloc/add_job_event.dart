part of 'add_job_bloc.dart';

class AddUpdateJobEvent extends Equatable {
  final JobEntity jobEntity;

  const AddUpdateJobEvent({required this.jobEntity});

  @override
  List<Object> get props => [jobEntity];
}
