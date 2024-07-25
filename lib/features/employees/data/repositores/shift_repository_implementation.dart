import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/employees/data/data_sources/shift_remote_datasource.dart';
import 'package:institute_management_system/features/employees/data/models/shift_model.dart';
import 'package:institute_management_system/features/employees/domain/entites/list_entity.dart';
import 'package:institute_management_system/features/employees/domain/entites/shift_entity.dart';
import 'package:institute_management_system/features/employees/domain/repositires/shift_repository.dart';

class ShiftRepositoryImplementation extends ShiftRepository {
  final ShiftRemoteDataSource shiftRemoteDataSource;

  ShiftRepositoryImplementation({required this.shiftRemoteDataSource});

  @override
  Future<Either<Failure, Unit>> addShift(ShiftEntity shiftEntity) async {
    final model = ShiftModel(
        id: shiftEntity.id,
        name: shiftEntity.name,
        startTime: shiftEntity.startTime,
        endTime: shiftEntity.endTime,
        days: shiftEntity.days);

    try {
      final result = await shiftRemoteDataSource.addUpdateShift(model);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ShiftEntity>> getShiftDetails(int id) async {
    try {
      final result = await shiftRemoteDataSource.getShiftDetails(id);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteShift(int id) async {
    try {
      final result = await shiftRemoteDataSource.deleteShift(id);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ListEntity<ShiftEntity>>> getShiftsList(
      int pageNumber) async {
    try {
      final result = await shiftRemoteDataSource.getJobTitleList(pageNumber);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
