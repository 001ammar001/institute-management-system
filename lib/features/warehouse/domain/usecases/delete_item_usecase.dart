
import 'package:dartz/dartz.dart';

import '../../../../core/Errors/failures.dart';
import '../repositores/warehouse_repository.dart';

class DeleteItemUseCase {
  final WareHouseRepository repository;

  DeleteItemUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deleteItem(id);
  }
}