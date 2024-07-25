import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/employees/domain/repositires/shift_repository.dart';

class DeleteShiftUseCase {
  final ShiftRepository shiftRepository;

  DeleteShiftUseCase({required this.shiftRepository});

  Future<Either<Failure, Unit>> call(int id) async {
    return await shiftRepository.deleteShift(id);
  }
}
