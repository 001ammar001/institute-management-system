import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/features/employees/data/models/employee_model.dart';

import '../../../../core/utils/Network/end_points.dart';
import '../models/employee_model_list.dart';

abstract class EmployeeRemoteDataSource {
  Future<Unit> addUpdateEmployee(EmployeeModelL employeeModel);
  Future<EmployeeModelL> getEmployeeData(int id);
  Future<EmployeeModelList> getEmployees({int pageNumber = 1});
  Future<Unit> deleteEmployee(int id);
}

class EmployeeDioRemoteDataSource extends EmployeeRemoteDataSource {
  final Dio dio;

  EmployeeDioRemoteDataSource({required this.dio});

  @override
  Future<Unit> addUpdateEmployee(EmployeeModelL employeeModel) async {
    final response = await dio
        .post(
      employeeModel.id != null ? "employees/${employeeModel.id}" : "employees",
      data: employeeModel.toJson(),
    )
        .onError((error, stackTrace) {
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
  Future<EmployeeModelL> getEmployeeData(int id) async {
    final response =
        await dio.get("employees/$id").onError((error, stackTrace) {
      throw ServerException();
    });
    if (response.statusCode == 200) {
      return EmployeeModelL.fromJson(response.data["data"]);
    } else if (response.statusCode == 422) {
      throw DataException(message: response.data["message"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<EmployeeModelList> getEmployees({int pageNumber = 1}) async {
    final response = await dio.get(
      EMPLOYEESLIST,
      queryParameters: {'page': pageNumber},
    ).then((value) {
      if (value.statusCode == 200) {
        EmployeeModelList st = EmployeeModelList.fromJson(value.data);
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
  Future<Unit> deleteEmployee(int id) async {
    final response =
        await dio.delete('$DELETEEMPLOYEES$id').onError((error, stackTrace) {
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
}
