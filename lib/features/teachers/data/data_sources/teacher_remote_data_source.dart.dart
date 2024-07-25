import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/features/teachers/data/models/teacher_model.dart';

import '../../../../core/utils/Network/end_points.dart';
import '../models/teacher_model_list.dart';

abstract class TeacherRemoteDataSource {
  Future<Unit> addUpdateTeacher(TeacherModel teacher);
  Future<TeacherModel> getTeacherDetails(int id);
  Future<TeacherModelList> getTeachers({
    required int pageNumber,
    required bool getArchived,
    required String name,
    required String phoneNumber,
});
  Future<Unit> deleteTeacher(int id);
}

class TeacherDioRemoteDataSource extends TeacherRemoteDataSource {
  final Dio dio;

  TeacherDioRemoteDataSource({required this.dio});

  @override
  Future<Unit> addUpdateTeacher(TeacherModel teacher) async {
    final response = await dio
        .post(teacher.id != null ? "teachers/${teacher.id}" : "teachers",
            data: teacher.toJson())
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
  Future<TeacherModel> getTeacherDetails(int id) async {
    final response = await dio.get("teachers/$id").onError((error, stackTrace) {
      throw ServerException();
    });
    if (response.statusCode == 200) {
      return TeacherModel.fromJson(response.data["data"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TeacherModelList> getTeachers({
    required int pageNumber,
    required bool getArchived,
    required String name,
    required String phoneNumber,
}) async {
    final response = await dio.get(
      TEACHERSLIST,
      queryParameters: {
        'page': pageNumber,
        'name': name,
        'phone_number': phoneNumber,
        //'trashed': getArchived ? "1" : "0",
      },
    ).then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        TeacherModelList st = TeacherModelList.fromJson(value.data);
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
  Future<Unit> deleteTeacher(int id) async {
    final response = await dio.delete(
        '$DELETETEACHER$id').onError((error, stackTrace) {
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
