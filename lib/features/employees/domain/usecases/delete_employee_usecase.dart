import 'package:dartz/dartz.dart';

import '../../../../core/Errors/failures.dart';
import '../repositires/employee_repository.dart';

class DeleteEmployeeUseCase {
  final EmployeeRepository repository;

  DeleteEmployeeUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deleteEmployee(id);
  }
}