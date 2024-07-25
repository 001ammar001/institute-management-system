part of 'job_details_bloc.dart';

sealed class JobDetailsEvent extends Equatable {
  const JobDetailsEvent();

  @override
  List<Object> get props => [];
}


class GetJobDetailEvent extends JobDetailsEvent {
  final int id;

  const GetJobDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}