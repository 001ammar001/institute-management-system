part of 'add_job_bloc.dart';

sealed class AddJobStates extends Equatable {
  const AddJobStates();

  @override
  List<Object> get props => [];
}

final class AddUpdateJobInitialState extends AddJobStates {}

final class AddUpdateJobLoadingState extends AddJobStates {}

final class AddUpdateJobFailureState extends AddJobStates {
  final String message;

  const AddUpdateJobFailureState({required this.message});
}

final class AddUpdateJobSucessState extends AddJobStates {}
