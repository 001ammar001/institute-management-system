import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/employees/domain/entites/job_entity.dart';
import 'package:institute_management_system/features/employees/domain/repositires/job_repository.dart';

class AddUpdateJobUseCase {
  final JobRepository jobRepository;

  AddUpdateJobUseCase({required this.jobRepository});

  Future<Either<Failure, Unit>> call(JobEntity jobEntity) async {
    return await jobRepository.addUpdateJob(jobEntity);
  }
}
