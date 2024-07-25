import 'package:dartz/dartz.dart';

import '../../../../../core/Errors/failures.dart';
import '../../repositores/room_category_repository.dart';

class DeleteCategoryUseCase {
  final RoomAndCategoryRepository repository;

  DeleteCategoryUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deleteCategory(id);
  }
}