import 'package:dartz/dartz.dart';
import 'package:institute_management_system/features/warehouse/domain/entitys/import_export_entity.dart';
import 'package:institute_management_system/features/warehouse/domain/entitys/stock_item_entity.dart';
import '../../../../core/Errors/failures.dart';
import '../../data/models/warehouse_model_list.dart';

abstract class WareHouseRepository {
  Future<Either<Failure, WareHouseModelList>> fetchItems({int pageNumber = 1});
  Future<Either<Failure, Unit>> addUpdateStockItem(StockItemEntity itemEntity);
  Future<Either<Failure, Unit>> importExportItem(ImportExportEntity itemEntity);
  Future<Either<Failure, Unit>> deleteItem(int id);
}
