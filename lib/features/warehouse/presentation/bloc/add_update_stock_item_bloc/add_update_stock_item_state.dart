part of 'add_update_stock_item_bloc.dart';

sealed class AddUpdateStockItemStates extends Equatable {
  const AddUpdateStockItemStates();

  @override
  List<Object> get props => [];
}

final class AddUpdateStockItemInitial extends AddUpdateStockItemStates {}

final class StockItemAddUpdateLoadingState extends AddUpdateStockItemStates {}

final class StockItemAddUpdateSucessState extends AddUpdateStockItemStates {}

final class StockItemAddUpdateFailureState extends AddUpdateStockItemStates {
  final String message;

  const StockItemAddUpdateFailureState({required this.message});
}
