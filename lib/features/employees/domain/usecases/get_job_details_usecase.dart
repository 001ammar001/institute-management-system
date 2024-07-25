import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/employees/domain/entites/job_entity.dart';
import 'package:institute_management_system/features/employees/domain/repositires/job_repository.dart';

class GetJobDataUseCase {
  final JobRepository jobRepository;

  GetJobDataUseCase({required this.jobRepository});

  Future<Either<Failure, JobEntity>> call(int id) async {
    return await jobRepository.getJobDetails(id);
  }
}
