import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/courses/domain/repositores/subject_repository.dart';

class DeleteSubjectUseCase {
  final SubjectRepository repository;

  DeleteSubjectUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deleteSubject(id);
  }
}
