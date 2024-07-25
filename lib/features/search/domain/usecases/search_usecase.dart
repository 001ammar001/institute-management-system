import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';
import 'package:institute_management_system/features/search/domain/repositores/search_repositore.dart';

class SearchForItemUseCase {
  final SearchRepository searchRepository;

  SearchForItemUseCase({required this.searchRepository});

  Future<Either<Failure, List<SearchEntity>>> call(
      String query, String endPoint) async {
    return await searchRepository.searchForItems(query, endPoint);
  }
}
