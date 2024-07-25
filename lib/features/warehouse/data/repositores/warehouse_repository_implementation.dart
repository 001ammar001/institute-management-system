import 'package:dartz/dartz.dart';
import 'package:institute_management_system/features/warehouse/data/models/stock_item_model.dart';
import 'package:institute_management_system/features/warehouse/domain/entitys/import_export_entity.dart';
import 'package:institute_management_system/features/warehouse/domain/entitys/stock_item_entity.dart';

import '../../../../core/Errors/exceptions.dart';
import '../../../../core/Errors/failures.dart';
import '../../domain/repositores/warehouse_repository.dart';
import '../data_sources/warehouse_remote_data_source.dart.dart';
import '../models/warehouse_model_list.dart';

class WarehouseRepositoryImplementation extends WareHouseRepository {
  final WarehouseRemoteDataSource warehouseRemoteDataSource;

  WarehouseRepositoryImplementation({required this.warehouseRemoteDataSource});

  @override
  Future<Either<Failure, WareHouseModelList>> fetchItems(
      {int pageNumber = 1}) async {
    try {
      dynamic result = await warehouseRemoteDataSource.getItemsWarehouse(
          pageNumber: pageNumber);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteItem(int id) async {
    try {
      final result = await warehouseRemoteDataSource.deleteItem(id);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addUpdateStockItem(
      StockItemEntity itemEntity) async {
    final model = StockItemModel(
      id: itemEntity.id,
      name: itemEntity.name,
      amount: itemEntity.amount,
      source: itemEntity.source,
    );
    try {
      final result = await warehouseRemoteDataSource.addUpdateItem(model);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, Unit>> importExportItem(ImportExportEntity itemEntity) async {
    try {
      final result = await warehouseRemoteDataSource.importExportItem(itemEntity);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
