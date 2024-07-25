import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/courses/data/data_sources/room_category_remote_datasource.dart';
import 'package:institute_management_system/features/courses/data/models/room_category_model.dart';
import 'package:institute_management_system/features/courses/domain/entites/room_categort_entity.dart';
import 'package:institute_management_system/features/courses/domain/repositores/room_category_repository.dart';

import '../models/room_category_model_list.dart';

class RoomAndCategoryRepositoryImplementation
    extends RoomAndCategoryRepository {
  final RoomCategoryDataSource searchRemoteDataSource;

  RoomAndCategoryRepositoryImplementation(
      {required this.searchRemoteDataSource});

  @override
  Future<Either<Failure, Unit>> addUpdateCategory(
      RoomOrCategoryEntity category) async {
    final model = RoomOrCategoryModel(id: category.id, name: category.name);
    try {
      final result = await searchRemoteDataSource.addUpdateCategory(model);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addUpdateRoom(RoomOrCategoryEntity room) async {
    final model = RoomOrCategoryModel(id: room.id, name: room.name);
    try {
      final result = await searchRemoteDataSource.addUpdateRoom(model);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, RoomCategoryModelList>> fetchRooms( {int pageNumber = 1})
  async {
    try {
      dynamic result =
      await searchRemoteDataSource.getRooms(pageNumber: pageNumber);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteRoom(int id) async {
    try {
      final result = await searchRemoteDataSource.deleteRoom(id);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, RoomCategoryModelList>> fetchCategories( {int pageNumber = 1})
  async {
    try {
      dynamic result =
      await searchRemoteDataSource.getCategories(pageNumber: pageNumber);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCategory(int id) async {
    try {
      final result = await searchRemoteDataSource.deleteCategory(id);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}
