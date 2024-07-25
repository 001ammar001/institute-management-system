import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/employees/data/data_sources/employee_remote_datasource.dart';
import 'package:institute_management_system/features/employees/data/models/employee_model.dart';
import 'package:institute_management_system/features/employees/domain/entites/employee_entity.dart';
import 'package:institute_management_system/features/employees/domain/repositires/employee_repository.dart';

import '../models/employee_model_list.dart';

class EmployeeRepositoryImplementation extends EmployeeRepository {
  final EmployeeRemoteDataSource employeeRemoteDataSource;

  EmployeeRepositoryImplementation({required this.employeeRemoteDataSource});

  @override
  Future<Either<Failure, Unit>> addUpdateEmployee(
      EmployeeEntity employeeEntity) async {
    final model = EmployeeModelL(
        id: employeeEntity.id,
        name: employeeEntity.name,
        birthDate: employeeEntity.birthDate,
        credentials: employeeEntity.credentials,
        job: employeeEntity.job,
        phoneNumber: employeeEntity.phoneNumber,
        shift: employeeEntity.shift,
        user: employeeEntity.user);

    try {
      final result = await employeeRemoteDataSource.addUpdateEmployee(model);
      return Right(result);
    } on DataException catch (error) {
      return Left(DataFailure(message: error.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, EmployeeEntity>> getEmployeeData(int id) async {
    try {
      final result = await employeeRemoteDataSource.getEmployeeData(id);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, EmployeeModelList>> fetchEmployees(
      {int pageNumber = 1}) async {
    try {
      dynamic result =
          await employeeRemoteDataSource.getEmployees(pageNumber: pageNumber);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteEmployee(int id) async {
    try {
      final result = await employeeRemoteDataSource.deleteEmployee(id);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
