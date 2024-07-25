import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/search/data/data_sources/search_remote_datasource.dart';
import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';
import 'package:institute_management_system/features/search/domain/repositores/search_repositore.dart';

class SearchRepositoryImplementation extends SearchRepository {
  final SearchRemoteDataSource searchRemoteDataSource;

  SearchRepositoryImplementation({required this.searchRemoteDataSource});

  @override
  Future<Either<Failure, List<SearchEntity>>> searchForItems(
      String query, String endPoint) async {
    try {
      final result =
          await searchRemoteDataSource.searchForItems(query, endPoint);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
