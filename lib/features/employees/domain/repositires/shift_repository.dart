import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/employees/domain/entites/list_entity.dart';
import 'package:institute_management_system/features/employees/domain/entites/shift_entity.dart';

abstract class ShiftRepository {
  Future<Either<Failure, Unit>> addShift(ShiftEntity shiftEntity);
  Future<Either<Failure, ListEntity<ShiftEntity>>> getShiftsList(
      int pageNumber);
  Future<Either<Failure, ShiftEntity>> getShiftDetails(int id);
  Future<Either<Failure, Unit>> deleteShift(int id);
}
