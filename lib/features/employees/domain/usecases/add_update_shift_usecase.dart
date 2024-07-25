import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/employees/domain/entites/shift_entity.dart';
import 'package:institute_management_system/features/employees/domain/repositires/shift_repository.dart';

class AddUpdateShiftUseCase {
  final ShiftRepository shiftRepository;

  AddUpdateShiftUseCase({required this.shiftRepository});

  Future<Either<Failure, Unit>> call(ShiftEntity shiftEntity) async {
    return await shiftRepository.addShift(shiftEntity);
  }
}
