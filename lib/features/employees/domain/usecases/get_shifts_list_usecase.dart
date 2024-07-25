import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/employees/domain/entites/list_entity.dart';
import 'package:institute_management_system/features/employees/domain/entites/shift_entity.dart';
import 'package:institute_management_system/features/employees/domain/repositires/shift_repository.dart';

class GetShiftsListUseCase {
  final ShiftRepository shiftRepository;

  GetShiftsListUseCase({required this.shiftRepository});

  Future<Either<Failure, ListEntity<ShiftEntity>>> call(int pageNumber) async {
    return await shiftRepository.getShiftsList(pageNumber);
  }
}
