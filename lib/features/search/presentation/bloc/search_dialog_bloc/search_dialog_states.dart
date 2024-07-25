part of 'search_dialog_bloc.dart';

sealed class SearchDialogStates extends Equatable {
  const SearchDialogStates();

  @override
  List<Object> get props => [];
}

final class SearchLoadingState extends SearchDialogStates {}

final class SearchFailureState extends SearchDialogStates {}

final class SearchSucessState extends SearchDialogStates {
  final List<SearchEntity> results;
  const SearchSucessState({required this.results});

  @override
  List<Object> get props => [results];
}
