import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';
import 'package:institute_management_system/features/search/domain/usecases/search_usecase.dart';
import 'package:rxdart/rxdart.dart';

part 'search_dialog_event.dart';
part 'search_dialog_states.dart';

class SearchBloc extends Bloc<SearchEvents, SearchDialogStates> {
  final SearchForItemUseCase searchForItemUseCase;

  SearchBloc({required this.searchForItemUseCase})
      : super(SearchLoadingState()) {
    EventTransformer<Event> debounceSequential<Event>() {
      return (events, mapper) =>
          events.debounceTime(const Duration(seconds: 1)).asyncExpand(mapper);
    }

    on<SearchForEntitysEvents>(
      (event, emit) async {
        emit(SearchLoadingState());
        final resultsOrError =
            await searchForItemUseCase(event.query, event.type);
        resultsOrError.fold(
          (l) => emit(SearchFailureState()),
          (r) => emit(SearchSucessState(results: r)),
        );
      },
      transformer: debounceSequential(),
    );
    on<InitialSearchEvents>(
      (event, emit) async {
        emit(SearchLoadingState());
        final resultsOrError = await searchForItemUseCase("", event.type);
        resultsOrError.fold(
          (l) => emit(SearchFailureState()),
          (r) => emit(SearchSucessState(results: r)),
        );
      },
    );
  }
}
