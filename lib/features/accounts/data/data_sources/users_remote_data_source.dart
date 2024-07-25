import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/core/utils/Network/end_points.dart';
import 'package:institute_management_system/features/accounts/data/models/user_model.dart';
import 'package:institute_management_system/features/accounts/data/models/user_model_list.dart';

abstract class UserRemoteDataSource {
  Future<Unit> addUser(UserModel user);
  Future<UserModelList> getUsers(
      int pageNumber, bool getArchived, String roleName);
  Future<UserDetailsModel> getUserDetails(int id);
  Future<Unit> editUser(User user);
  Future<Unit> deleteUser(int id);
  Future<Unit> restoreUser(int id);
}

class UserDioDataSource extends UserRemoteDataSource {
  final Dio dio;

  UserDioDataSource({required this.dio});

  @override
  Future<Unit> addUser(UserModel user) async {
    final response = await dio
        .post(user.id != null ? "users/${user.id}" : "users",
            data: user.toJson())
        .onError((error, stackTrace) => throw ServerException());
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Future.value(unit);
    } else if (response.statusCode == 422) {
      throw DataException(message: response.data["message"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModelList> getUsers(
      int pageNumber, bool getArchived, String roleName) async {
    final response = await dio.get(
      USERSLIST,
      queryParameters: {
        'page': pageNumber,
        'trashed': getArchived ? "1" : "0",
        'role': roleName,
      },
    ).then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        UserModelList st = UserModelList.fromJson(value.data);
        return st;
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
  Future<UserDetailsModel> getUserDetails(int id) async {
    final response = await dio.get("users/$id").onError((error, stackTrace) {
      throw ServerException();
    });
    if (response.statusCode == 200) {
      return UserDetailsModel.fromJson(response.data["data"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteUser(int id) async {
    final response =
        await dio.delete('$DELETEUSER$id').onError((error, stackTrace) {
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
  Future<Unit> editUser(User user) async {
    final response = await dio.post("users/${user.id}", data: {
      "role_id": user.role!.id,
      "employee_id": user.employee?.id != 0 ? user.employee?.id : null
    }).onError((error, stackTrace) => throw ServerException());
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Future.value(unit);
    } else if (response.statusCode == 422) {
      throw DataException(message: response.data["message"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> restoreUser(int id) async {
    final response = await dio
        .post("users/$id/restore")
        .onError((error, stackTrace) => throw ServerException());
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Future.value(unit);
    } else if (response.statusCode == 422) {
      throw DataException(message: response.data["message"]);
    } else {
      throw ServerException();
    }
  }
}
