import 'package:dartz/dartz.dart';
import 'package:institute_management_system/features/employees/domain/entites/job_entity.dart';
import 'package:institute_management_system/features/employees/domain/entites/list_entity.dart';
import 'package:institute_management_system/features/employees/domain/repositires/job_repository.dart';
import '../../../../core/Errors/failures.dart';

class GetJobTitleListUseCase {
  final JobRepository jobRepository;

  GetJobTitleListUseCase({required this.jobRepository});

  Future<Either<Failure, ListEntity<JobEntity>>> call(int pageNumber) async {
    return await jobRepository.getJobsList(pageNumber);
  }
}
