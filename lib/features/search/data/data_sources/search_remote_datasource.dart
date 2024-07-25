import 'package:dio/dio.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';

abstract class SearchRemoteDataSource {
  Future<List<SearchEntity>> searchForItems(String query, String endPoint);
}

class SearchDioRemoteDataSource extends SearchRemoteDataSource {
  final Dio dio;

  SearchDioRemoteDataSource({required this.dio});

  @override
  Future<List<SearchEntity>> searchForItems(
    String query,
    String endPoint,
  ) async {
    final response = await dio.get(
      endPoint,
      queryParameters: {
        "name": query,
      },
    ).onError((error, stackTrace) => throw ServerException());
    if (response.statusCode == 200) {
      final data = response.data["data"];
      final List<SearchEntity> results = data
          .map<SearchEntity>(
              (jsonPostModel) => SearchEntity.fromJson(jsonPostModel))
          .toList();
      return results;
    } else {
      throw ServerException();
    }
  }
}
