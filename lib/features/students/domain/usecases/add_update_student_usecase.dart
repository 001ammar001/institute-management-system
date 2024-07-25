import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/students/domain/entites/student_entity.dart';
import 'package:institute_management_system/features/students/domain/repositores/student_repository.dart';

class AddUpdateStudentUseCase {
  final StudentRepository repository;

  AddUpdateStudentUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(StudentEnity student) async {
    return await repository.addUpdateStudent(student);
  }
}
