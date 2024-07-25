import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/features/accounts/data/models/role_model.dart';
import 'package:institute_management_system/features/accounts/domain/entites/permission_entity.dart';

import '../../../../core/utils/Network/end_points.dart';
import '../../../../core/utils/enums.dart';
import '../models/role_model_list.dart';

abstract class RoleRemoteDataSource {
  Future<Unit> addUpdateRole(RoleModel role);
  Future<RoleModel> getRoleDetails(int id);
  Future<List<PermissionEntity>> getPermissions();
  Future<RoleModelList> getRoles({int pageNumber = 1});
  Future<Unit> deleteRole(int id);
}

class RoleDioDataSource extends RoleRemoteDataSource {
  final Dio dio;

  RoleDioDataSource({required this.dio});

  @override
  Future<Unit> addUpdateRole(RoleModel role) async {
    final response = await dio
        .post(role.id != null ? "roles/${role.id}" : "roles",
            data: role.toJson())
        .onError((error, stackTrace) => throw ServerException());
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PermissionEntity>> getPermissions() async {
    final response = await dio.get("permissions").onError((error, stackTrace) {
      throw ServerException();
    });
    if (response.statusCode == 200) {
      final data = response.data["data"] as List;
      final results = data.map((json) => PermissionEntity.fromJson(json)).toList();
      return results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RoleModel> getRoleDetails(int id) async {
    final response = await dio.get("roles/$id").onError((error, stackTrace) {
      throw ServerException();
    });
    if (response.statusCode == 200) {
      return RoleModel.fromJson(response.data["data"],RoleApiTypeEnum.getRolesDetails);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RoleModelList> getRoles({int pageNumber = 1}) async {
    final response = await dio.get(
      ROLESLIST,
      queryParameters: {'page': pageNumber},
    ).then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        RoleModelList st = RoleModelList.fromJson(value.data);
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
  Future<Unit> deleteRole(int id) async {
    final response =
    await dio.delete('$DELETEROLE$id').onError((error, stackTrace) {
      print(error);
      throw ServerException();
    });
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
      return unit;
    } else if (response.statusCode == 422) {
      throw DataException(message: response.data["message"]);
    } else {
      throw ServerException();
    }
  }
}
