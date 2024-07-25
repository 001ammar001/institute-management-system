part of "list_categories_bloc.dart";

abstract class ListCategoriesStates  {}

class ListCategoriesInitialState extends ListCategoriesStates {}

class PageChangedState extends ListCategoriesStates {}

class DeleteCategoryState extends ListCategoriesStates {}

class ChangeCounterState extends ListCategoriesStates {}

final class ListCategoriesSuccessState extends ListCategoriesStates {
  final RoomCategoryModelList categories;
  ListCategoriesSuccessState(this.categories);
}

final class ListCategoriesLoadingState extends ListCategoriesStates {}

class ListCategoriesFailureState extends ListCategoriesStates {
  final String message;

  ListCategoriesFailureState({required this.message});
}

class DeleteCategoriesFailureState extends ListCategoriesStates {
  final String message;

  DeleteCategoriesFailureState({required this.message});
}

class DeleteCategoriesSuccessState extends ListCategoriesStates {}
