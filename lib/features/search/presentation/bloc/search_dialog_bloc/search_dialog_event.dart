part of 'search_dialog_bloc.dart';

abstract class SearchEvents extends Equatable {}

class SearchForEntitysEvents extends SearchEvents {
  final String query;
  final String type;

  SearchForEntitysEvents({required this.query, required this.type});

  @override
  List<Object?> get props => [query];
}

class InitialSearchEvents extends SearchEvents {
  final String type;
  InitialSearchEvents({required this.type});

  @override
  List<Object?> get props => [type];
}
