import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/employees/domain/entites/employee_entity.dart';
import 'package:institute_management_system/features/employees/domain/repositires/employee_repository.dart';

class AddUpdateEmployeeUseCase {
  final EmployeeRepository employeeRepository;

  AddUpdateEmployeeUseCase({required this.employeeRepository});

  Future<Either<Failure, Unit>> call(EmployeeEntity employeeEntity) async {
    return await employeeRepository.addUpdateEmployee(employeeEntity);
  }
}
