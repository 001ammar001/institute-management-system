import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<SearchEntity>>> searchForItems(
    String query,
    String endPoint,
  );
}
