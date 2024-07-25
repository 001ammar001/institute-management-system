import 'package:dartz/dartz.dart';
import 'package:institute_management_system/features/warehouse/domain/entitys/stock_item_entity.dart';

import '../../../../core/Errors/failures.dart';
import '../repositores/warehouse_repository.dart';

class AddUpdateStockItemUseCase {
  final WareHouseRepository repository;

  AddUpdateStockItemUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(StockItemEntity itemEntity) async {
    return await repository.addUpdateStockItem(itemEntity);
  }
}
