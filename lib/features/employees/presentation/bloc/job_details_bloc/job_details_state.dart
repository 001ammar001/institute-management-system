part of 'job_details_bloc.dart';

sealed class JobDetailsStates extends Equatable {
  const JobDetailsStates();

  @override
  List<Object> get props => [];
}

final class JobDataLoadedState extends JobDetailsStates {
  final JobEntity job;

  const JobDataLoadedState({required this.job});
}

final class JobDataLoadingState extends JobDetailsStates {}

final class JobDataFailureState extends JobDetailsStates {
  final String message;

  const JobDataFailureState({required this.message});
}
