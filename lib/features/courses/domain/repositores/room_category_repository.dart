import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/courses/domain/entites/room_categort_entity.dart';
import '../../data/models/room_category_model_list.dart';

abstract class RoomAndCategoryRepository {
  Future<Either<Failure, Unit>> addUpdateRoom(RoomOrCategoryEntity room);
  Future<Either<Failure, Unit>> addUpdateCategory(  RoomOrCategoryEntity category);
  Future<Either<Failure, RoomCategoryModelList>> fetchRooms({int pageNumber = 1});
  Future<Either<Failure, Unit>> deleteRoom(int id);
  Future<Either<Failure, RoomCategoryModelList>> fetchCategories({int pageNumber = 1});
  Future<Either<Failure, Unit>> deleteCategory(int id);
}
