import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import '../../../../../core/utils/Network/end_points.dart';
import '../models/accounts_model.dart';


abstract class AccountRemoteDataSource {
  Future<AccountModelList> getMainAccounts({int pageNumber = 1});
  Future<AccountModelList> getSubAccounts({int pageNumber = 1});
  Future<Unit> deleteSubAccounts(int id);
}

class AccountDioRemoteDataSource extends AccountRemoteDataSource {
  final Dio dio;
  AccountDioRemoteDataSource({required this.dio});

  @override
  Future<AccountModelList> getMainAccounts({int pageNumber = 1}) async {
    final response = await dio.get(
      MAINACCOUNTSLIST,
      queryParameters: {'page': pageNumber},
    ).then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        AccountModelList st = AccountModelList.fromJson(value.data);
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
  Future<AccountModelList> getSubAccounts({int pageNumber = 1}) async {
    final response = await dio.get(
      SUBACCOUNTSLIST,
      queryParameters: {'page': pageNumber},
    ).then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        AccountModelList st = AccountModelList.fromJson(value.data);
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
  Future<Unit> deleteSubAccounts(int id) async {
    final response =
    await dio.delete('$DELETESUBACCOUNT$id').onError((error, stackTrace) {
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
