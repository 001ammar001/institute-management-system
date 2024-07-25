import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/students/domain/entites/student_entity.dart';
import 'package:institute_management_system/features/students/domain/repositores/student_repository.dart';

class GetStudentDetailsUseCase {
  final StudentRepository repository;

  GetStudentDetailsUseCase({required this.repository});

  Future<Either<Failure, StudentEnity>> call(int id) async {
    return await repository.getStudentDetails(id);
  }
}
