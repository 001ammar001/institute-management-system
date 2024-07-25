import 'package:dartz/dartz.dart';

import '../../../../core/Errors/failures.dart';
import '../../data/models/warehouse_model_list.dart';
import '../repositores/warehouse_repository.dart';

class FetchItemsUseCase  {
  final WareHouseRepository repository;

  FetchItemsUseCase({required this.repository});

  Future<Either<Failure, WareHouseModelList>> call({int pageNumber = 1}) async {
       return await repository.fetchItems(pageNumber: pageNumber);
 }
}

