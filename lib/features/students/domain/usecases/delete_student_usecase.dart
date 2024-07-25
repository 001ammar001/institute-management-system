import 'package:dartz/dartz.dart';

import '../../../../core/Errors/failures.dart';
import '../repositores/student_repository.dart';

class DeleteStudentUseCase {
  final StudentRepository repository;

  DeleteStudentUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deleteStudent(id);
  }
}