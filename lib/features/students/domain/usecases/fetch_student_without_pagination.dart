import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/students/data/models/student_model_list.dart';
import 'package:institute_management_system/features/students/domain/repositores/student_repository.dart';

class FetchStudentsWithoutPaginationUseCase {
  final StudentRepository repository;

  FetchStudentsWithoutPaginationUseCase({required this.repository});

  Future<Either<Failure, StudentModelList>> call() async {
    return await repository.fetchStudentsWithoutPagination();
  }
}
