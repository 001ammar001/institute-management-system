part of "list_items_warehouse_bloc.dart";

abstract class ListItemsWarehouseStates  {

}

class ListItemsWarehouseInitialState extends ListItemsWarehouseStates {}

class PageChangedItemsWarehouseState extends ListItemsWarehouseStates {}

class DeleteItemsWarehouseState extends ListItemsWarehouseStates {}

class ChangeCounterItemsWarehouseState extends ListItemsWarehouseStates {}

final class ListItemsWarehouseSuccessState extends ListItemsWarehouseStates {
  final WareHouseModelList items;
  ListItemsWarehouseSuccessState(this.items);
}

final class ListItemsWarehouseLoadingState extends ListItemsWarehouseStates {}

class ListItemsWarehouseFailureState extends ListItemsWarehouseStates {
  final String message;

   ListItemsWarehouseFailureState({required this.message});
}

class DeleteItemsWarehouseFailureState extends ListItemsWarehouseStates {
  final String message;

  DeleteItemsWarehouseFailureState({required this.message});
}




