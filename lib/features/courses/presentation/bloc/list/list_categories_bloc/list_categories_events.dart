part of "list_categories_bloc.dart";

abstract class ListCategoriesEvents extends Equatable {
  const ListCategoriesEvents();

  @override
  List<Object?> get props => [];
}

class CategoriesEvents extends ListCategoriesEvents {
  final int currentPage;
  const CategoriesEvents({required this.currentPage});
  @override
  List<Object?> get props => [currentPage];
}

class NextPageEvent extends ListCategoriesEvents {}

class PreviousPageEvent extends ListCategoriesEvents {}

class CheckboxEvent extends ListCategoriesEvents {}

class DeleteCategoryEvent extends ListCategoriesEvents {
  final int indexCategory;
  const DeleteCategoryEvent({required this.indexCategory});
  @override
  List<Object?> get props => [indexCategory];
}

class ControlCategoriesPageEvent extends ListCategoriesEvents {}
