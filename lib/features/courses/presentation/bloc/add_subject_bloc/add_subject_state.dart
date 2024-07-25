part of 'add_subject_bloc.dart';

sealed class SubjectAddStates extends Equatable {
  const SubjectAddStates();

  @override
  List<Object> get props => [];
}

final class SubjectAddInitial extends SubjectAddStates {}

final class SubjectAddUpdateLoadingState extends SubjectAddStates {}

final class SubjectAddUpdateSucessState extends SubjectAddStates {}

final class SubjectAddUpdateFailureState extends SubjectAddStates {
  final String message;

  const SubjectAddUpdateFailureState({required this.message});
}
