import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/features/courses/data/models/room_category_model.dart';

import '../../../../core/utils/network/end_points.dart';
import '../models/room_category_model_list.dart';

abstract class RoomCategoryDataSource {
  Future<Unit> addUpdateRoom(RoomOrCategoryModel room);
  Future<Unit> addUpdateCategory(RoomOrCategoryModel category);
  Future<RoomCategoryModelList> getRooms({int pageNumber = 1});
  Future<Unit> deleteRoom(int id);
  Future<RoomCategoryModelList> getCategories({int pageNumber = 1});
  Future<Unit> deleteCategory(int id);
}

class RoomCategoryDioDataSource extends RoomCategoryDataSource {
  final Dio dio;

  RoomCategoryDioDataSource({required this.dio});

  @override
  Future<Unit> addUpdateCategory(RoomOrCategoryModel category) async {
    final response = await dio
        .post(category.id != null ? "categories/${category.id}" : "categories",
            data: category.toCategoryJson())
        .onError((error, stackTrace) => throw ServerException());
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addUpdateRoom(RoomOrCategoryModel room) async {
    final response = await dio
        .post(room.id != null ? "rooms/${room.id}" : "rooms",
            data: room.toRoomJson())
        .onError((error, stackTrace) => throw ServerException());
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RoomCategoryModelList> getRooms({int pageNumber = 1}) async {
    final response = await dio.get(
      ROOMSLIST,
      queryParameters: {'page': pageNumber},
    ).then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        RoomCategoryModelList st = RoomCategoryModelList.fromJson(value.data);
        return st;
      } else if (value.data.statusCode == 422) {
        throw DataException(message: value.data.data["message"]);
      } else {
        throw ServerException();
      }
    }).onError((error, stackTrace) {
      print(error);
      throw ServerException();
    });

    return response;
  }

  @override
  Future<Unit> deleteRoom(int id) async {
    final response =
    await dio.delete('$DELETEROOM$id').onError((error, stackTrace) {
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
  Future<RoomCategoryModelList> getCategories({int pageNumber = 1}) async {
    final response = await dio.get(
      CATEGORIESLIST,
      queryParameters: {'page': pageNumber},
    ).then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        print(value.data);
        RoomCategoryModelList st = RoomCategoryModelList.fromJson(value.data);
        return st;
      } else if (value.data.statusCode == 422) {
        throw DataException(message: value.data.data["message"]);
      } else {
        throw ServerException();
      }
    }).onError((error, stackTrace) {
      print(error);
      throw ServerException();
    });

    return response;
  }

  @override
  Future<Unit> deleteCategory(int id) async {
    final response =
    await dio.delete('$DELETECATEGORY$id').onError((error, stackTrace) {
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

}
