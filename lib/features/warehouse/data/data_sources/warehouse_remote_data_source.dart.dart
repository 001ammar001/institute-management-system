import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:institute_management_system/features/warehouse/data/models/stock_item_model.dart';
import 'package:institute_management_system/features/warehouse/domain/entitys/import_export_entity.dart';
import '../../../../core/Errors/exceptions.dart';
import '../../../../core/utils/Network/end_points.dart';
import '../models/warehouse_model_list.dart';

abstract class WarehouseRemoteDataSource {
  Future<WareHouseModelList> getItemsWarehouse({int pageNumber = 1});
  Future<Unit> addUpdateItem(StockItemModel itemModel);
  Future<Unit> importExportItem(ImportExportEntity itemEntity);
  Future<Unit> deleteItem(int id);
}

class WarehouseDioRemoteDataSource extends WarehouseRemoteDataSource {
  final Dio dio;
  WarehouseDioRemoteDataSource({required this.dio});

  @override
  Future<WareHouseModelList> getItemsWarehouse({int pageNumber = 1}) async {
    final response = await dio.get(
      WAREHOUSELIST,
      queryParameters: {'page': pageNumber},
    ).then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        WareHouseModelList wh = WareHouseModelList.fromJson(value.data);
        return wh;
      } else if (value.data.statusCode == 422) {
        throw DataException(message: value.data.data["message"]);
      } else {
        throw ServerException();
      }
    }).onError((error, stackTrace) {
      throw ServerException();
    });

    return response;
  }

  @override
  Future<Unit> deleteItem(int id) async {
    final response =
        await dio.delete('$DELETEITEM$id').onError((error, stackTrace) {
      throw ServerException();
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      return unit;
    } else if (response.statusCode == 422) {
      throw DataException(message: response.data["message"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addUpdateItem(StockItemModel itemModel) async {
    final response = await dio
        .post(itemModel.id != null ? "stocks/${itemModel.id}" : "stocks",
            data: itemModel.toJson())
        .onError((error, stackTrace) => throw ServerException());
    if (response.statusCode == 200 || response.statusCode == 201) {
      return unit;
    } else if (response.statusCode == 422) {
      throw DataException(message: response.data["message"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> importExportItem(ImportExportEntity itemEntity) async {
    final response = await dio
        .post(
          "stocks/import/${itemEntity.id}",
          data: itemEntity.toJson(),
        )
        .onError((error, stackTrace) => throw ServerException());
    if (response.statusCode == 200) {
      return unit;
    } else if (response.statusCode == 422) {
      throw DataException(message: response.data["message"]);
    } else {
      throw ServerException();
    }
  }
}
