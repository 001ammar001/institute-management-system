import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/courses/domain/entites/room_categort_entity.dart';
import 'package:institute_management_system/features/courses/domain/repositores/room_category_repository.dart';

class AddUpdateCategoryUseCase {
  final RoomAndCategoryRepository repository;

  AddUpdateCategoryUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(RoomOrCategoryEntity category) async {
    return await repository.addUpdateCategory(category);
  }
}
