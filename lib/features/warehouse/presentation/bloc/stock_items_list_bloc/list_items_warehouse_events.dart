part of "list_items_warehouse_bloc.dart";

abstract class ListItemsWarehouseEvents extends Equatable {
  const ListItemsWarehouseEvents();

  @override
  List<Object?> get props => [];
}

class ItemsWarehouseEvents extends ListItemsWarehouseEvents {
  final int currentPage;
  const ItemsWarehouseEvents({required this.currentPage});
  @override
  List<Object?> get props => [currentPage];
}

class NextPageItemsWarehouseEvent extends ListItemsWarehouseEvents {}

class PreviousItemsWarehousePageEvent extends ListItemsWarehouseEvents {}

class CheckboxItemsWarehouseEvent extends ListItemsWarehouseEvents {}

class DeleteItemsWarehouseEvent extends ListItemsWarehouseEvents {
  final int indexItemsWarehouse;
  const DeleteItemsWarehouseEvent({required this.indexItemsWarehouse});
  @override
  List<Object?> get props => [indexItemsWarehouse];
}

class ControlItemsWarehousePageEvent extends ListItemsWarehouseEvents {}
