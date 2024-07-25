part of 'add_update_stock_item_bloc.dart';

class AddUpdateStockItemEvent extends Equatable {
  final StockItemEntity stockItem;
  const AddUpdateStockItemEvent({required this.stockItem});

  @override
  List<Object> get props => [stockItem];
}
