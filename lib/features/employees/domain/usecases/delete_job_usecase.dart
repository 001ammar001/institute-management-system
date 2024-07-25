import 'package:dartz/dartz.dart';
import 'package:institute_management_system/features/employees/domain/repositires/job_repository.dart';
import '../../../../core/Errors/failures.dart';

class DeleteJobTitleUseCase {
  final JobRepository jobRepository;

  DeleteJobTitleUseCase({required this.jobRepository});

  Future<Either<Failure, Unit>> call(int id) async {
    return await jobRepository.deleteJob(id);
  }
}
