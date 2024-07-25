import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/employees/domain/entites/shift_entity.dart';
import 'package:institute_management_system/features/employees/domain/repositires/shift_repository.dart';

class GetShiftDataUseCase {
  final ShiftRepository shiftRepository;

  GetShiftDataUseCase({required this.shiftRepository});

  Future<Either<Failure, ShiftEntity>> call(int id) async {
    return await shiftRepository.getShiftDetails(id);
  }
}
