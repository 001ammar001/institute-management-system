import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/Errors/error_message_mapper.dart';
import '../../../../data/models/room_category_model_list.dart';
import '../../../../domain/useCases/category/delete_category_usecase.dart';
import '../../../../domain/useCases/category/fetch_categories_usecase.dart';


part "list_categories_events.dart";

part "list_categories_states.dart";

class ListCategoriesBloc extends Bloc<ListCategoriesEvents, ListCategoriesStates> {
  final FetchCategoriesUseCase fetchCategoriesUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;
  RoomCategoryModelList categories = RoomCategoryModelList();

  String failureText = 'error';
  int currentPage = 1;
  int stateButtonArrowForwardCategory = 0;
  int stateButtonArrowBackCategory = 0;
  int stateButtonDeleteCategory = 0;

  ListCategoriesBloc(
      {required this.fetchCategoriesUseCase, required this.deleteCategoryUseCase})
      : super(ListCategoriesInitialState()) {
    on<CategoriesEvents>(_getCategoriesAll);
    on<CheckboxEvent>(_checkboxControl);
    on<DeleteCategoryEvent>(_deleteCategory);
  }

  FutureOr<void> _getCategoriesAll(
      CategoriesEvents event, Emitter<ListCategoriesStates> emit) async {
    emit(ListCategoriesLoadingState());
    final result =
        await fetchCategoriesUseCase.call(pageNumber: event.currentPage);
    result.fold(
        (failure) => emit(
              ListCategoriesFailureState(message: mapFailureToMessage(failure)),
            ), (listCategory) {
      categories = listCategory;
      emit(ListCategoriesSuccessState(listCategory));
    });
  }

  FutureOr<void> _checkboxControl(
      CheckboxEvent event, Emitter<ListCategoriesStates> emit) async {
    emit(PageChangedState());
  }

  FutureOr<void> _deleteCategory(
      DeleteCategoryEvent event, Emitter<ListCategoriesStates> emit) async {
    emit(ListCategoriesLoadingState());
    final result = await deleteCategoryUseCase.call(event.indexCategory);
    result.fold(
        (failure) => emit(
              DeleteCategoriesFailureState(message: mapFailureToMessage(failure)),
            ), (delete) {
      emit(DeleteCategoriesSuccessState());
    });
  }
}
