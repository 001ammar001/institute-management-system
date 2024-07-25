import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/employees/domain/entites/job_entity.dart';
import 'package:institute_management_system/features/employees/domain/entites/list_entity.dart';

abstract class JobRepository {
  Future<Either<Failure, Unit>> addUpdateJob(JobEntity jobEntity);
  Future<Either<Failure, ListEntity<JobEntity>>> getJobsList(int pageNumber);
  Future<Either<Failure, JobEntity>> getJobDetails(int id);
  Future<Either<Failure, Unit>> deleteJob(int id);
}
