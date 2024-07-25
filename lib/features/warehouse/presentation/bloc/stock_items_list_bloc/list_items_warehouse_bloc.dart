
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/Errors/error_message_mapper.dart';
import '../../../data/models/warehouse_model_list.dart';
import '../../../domain/usecases/delete_item_usecase.dart';
import '../../../domain/usecases/fetch_items_warehouse_usecase.dart';

part "list_items_warehouse_events.dart";

part "list_items_warehouse_states.dart";

class ListItemsWarehouseBloc extends Bloc<ListItemsWarehouseEvents, ListItemsWarehouseStates> {
  final FetchItemsUseCase fetchItemsWarehouseUseCase;
  final DeleteItemUseCase deleteItemsWarehouseUseCase;
  WareHouseModelList items = WareHouseModelList();

  String failureText = 'error';
  int currentPageItem = 1;
  int stateButtonArrowForwardItems = 0;
  int stateButtonArrowBackItems = 0;
  int stateButtonDeleteItem = 0;

  ListItemsWarehouseBloc({required this.fetchItemsWarehouseUseCase, required this.deleteItemsWarehouseUseCase})
      : super(ListItemsWarehouseInitialState()) {
    on<ItemsWarehouseEvents>(_getItemsWarehouseAll);
    on<CheckboxItemsWarehouseEvent>(_checkboxControl);
    on<DeleteItemsWarehouseEvent>(_deleteItemsWarehouse);
  }

  FutureOr<void> _getItemsWarehouseAll(ItemsWarehouseEvents event,
      Emitter<ListItemsWarehouseStates> emit) async {
    emit(ListItemsWarehouseLoadingState());
    final result = await fetchItemsWarehouseUseCase.call(
        pageNumber: event.currentPage);
    result.fold(
            (failure) =>
            emit(
              ListItemsWarehouseFailureState(message: mapFailureToMessage(failure)),
            ), (listItemsWarehouse) {
              items=listItemsWarehouse;
      emit(ListItemsWarehouseSuccessState(listItemsWarehouse));
    });
  }

  FutureOr<void> _checkboxControl(CheckboxItemsWarehouseEvent event,
      Emitter<ListItemsWarehouseStates> emit) async {
    emit(PageChangedItemsWarehouseState());
  }

  FutureOr<void> _deleteItemsWarehouse(DeleteItemsWarehouseEvent event,
      Emitter<ListItemsWarehouseStates> emit) async {
    emit(ListItemsWarehouseLoadingState());
    final result = await deleteItemsWarehouseUseCase.call(event.indexItemsWarehouse);
    result.fold(
            (failure) =>
            emit(
              DeleteItemsWarehouseFailureState(message: mapFailureToMessage(failure)),
            ), (delete) {

      items.data!.removeWhere((item) => item.id == event.indexItemsWarehouse);
    });
  }
}




