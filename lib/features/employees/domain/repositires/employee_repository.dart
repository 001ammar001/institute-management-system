import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/employees/domain/entites/employee_entity.dart';

import '../../data/models/employee_model_list.dart';

abstract class EmployeeRepository {
  Future<Either<Failure, Unit>> addUpdateEmployee(EmployeeEntity employeeEntity);

  Future<Either<Failure, EmployeeEntity>> getEmployeeData(int id);

  Future<Either<Failure, EmployeeModelList>> fetchEmployees(
      {int pageNumber = 1});

  Future<Either<Failure, Unit>> deleteEmployee(int id);
}
