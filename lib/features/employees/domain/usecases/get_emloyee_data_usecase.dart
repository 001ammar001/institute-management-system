import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/employees/domain/entites/employee_entity.dart';
import 'package:institute_management_system/features/employees/domain/repositires/employee_repository.dart';

class GetEmployeeDataUseCase {
  final EmployeeRepository employeeRepository;

  GetEmployeeDataUseCase({required this.employeeRepository});

  Future<Either<Failure, EmployeeEntity>> call(int id) async {
    return await employeeRepository.getEmployeeData(id);
  }
}
