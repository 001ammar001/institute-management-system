import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/employees/data/data_sources/job_remote_datasource.dart';
import 'package:institute_management_system/features/employees/data/models/job_model.dart';
import 'package:institute_management_system/features/employees/domain/entites/job_entity.dart';
import 'package:institute_management_system/features/employees/domain/entites/list_entity.dart';
import 'package:institute_management_system/features/employees/domain/repositires/job_repository.dart';

class JobRepositoryImplementation extends JobRepository {
  final JobRemoteDataSource jobRemoteDataSource;

  JobRepositoryImplementation({required this.jobRemoteDataSource});

  @override
  Future<Either<Failure, Unit>> addUpdateJob(JobEntity jobEntity) async {
    final model = JobModel(
      id: jobEntity.id,
      name: jobEntity.name,
      baseSalary: jobEntity.baseSalary,
    );

    try {
      final result = await jobRemoteDataSource.addUpdateJob(model);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, JobEntity>> getJobDetails(int id) async {
    try {
      final result = await jobRemoteDataSource.getJobData(id);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ListEntity<JobEntity>>> getJobsList(
      int pageNumber) async {
    try {
      final result = await jobRemoteDataSource.getJobTitleList(pageNumber);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteJob(int id) async {
    try {
      final result = await jobRemoteDataSource.deleteJob(id);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
