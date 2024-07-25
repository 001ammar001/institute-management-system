import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/features/employees/data/models/shift_model.dart';
import 'package:institute_management_system/features/employees/domain/entites/list_entity.dart';

abstract class ShiftRemoteDataSource {
  Future<Unit> addUpdateShift(ShiftModel shiftModel);
  Future<ShiftModel> getShiftDetails(int id);
  Future<ListEntity<ShiftModel>> getJobTitleList(int pageNumber);
  Future<Unit> deleteShift(int id);
}

class ShiftDioRemoteDataSource extends ShiftRemoteDataSource {
  final Dio dio;

  ShiftDioRemoteDataSource({required this.dio});

  @override
  Future<Unit> addUpdateShift(ShiftModel shiftModel) async {
    final response = await dio
        .post(
      shiftModel.id != null ? "shifts/${shiftModel.id}" : "shifts",
      data: shiftModel.toJson(),
    )
        .onError((error, stackTrace) {
      throw ServerException();
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      return unit;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ShiftModel> getShiftDetails(int id) async {
    final response = await dio.get("shifts/$id").onError((error, stackTrace) {
      throw ServerException();
    });
    if (response.statusCode == 200) {
      return ShiftModel.fromJson(response.data["data"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteShift(int id) async {
    final response =
        await dio.delete("shifts/$id").onError((error, stackTrace) {
      throw ServerException();
    });
    if (response.statusCode == 200 || response.statusCode == 204) {
      return unit;
    } else if (response.statusCode == 422) {
      throw DataException(message: response.data["message"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ListEntity<ShiftModel>> getJobTitleList(int pageNumber) async {
    final response = await dio.get(
      "shifts/",
      queryParameters: {"page": pageNumber},
    ).onError((error, stackTrace) {
      throw ServerException();
    });
    if (response.statusCode == 200) {
      final data = response.data["data"];
      final List<ShiftModel> results = data
          .map<ShiftModel>(
              (jsonPostModel) => ShiftModel.fromJson(jsonPostModel))
          .toList();

      return ListEntity(
        maxPage: response.data["meta"]["last_page"],
        entitys: results,
      );
    } else {
      throw ServerException();
    }
  }
}
