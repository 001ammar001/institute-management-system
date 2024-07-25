import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';
import 'package:institute_management_system/features/warehouse/domain/entitys/stock_item_entity.dart';
import 'package:institute_management_system/features/warehouse/domain/usecases/add_update_stock_item_usecase.dart';

part 'add_update_stock_item_event.dart';
part 'add_update_stock_item_state.dart';

class AddStockItemBloc
    extends Bloc<AddUpdateStockItemEvent, AddUpdateStockItemStates> {
  final AddUpdateStockItemUseCase addUpdateStockItem;

  AddStockItemBloc({required this.addUpdateStockItem})
      : super(AddUpdateStockItemInitial()) {
    on<AddUpdateStockItemEvent>((event, emit) async {
      emit(StockItemAddUpdateLoadingState());
      final result = await addUpdateStockItem(event.stockItem);
      result.fold(
        (l) => emit(
          StockItemAddUpdateFailureState(message: mapFailureToMessage(l)),
        ),
        (r) => emit(StockItemAddUpdateSucessState()),
      );
    });
  }
}
