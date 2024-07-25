import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/courses/domain/entites/subject_entity.dart';
import 'package:institute_management_system/features/courses/domain/repositores/subject_repository.dart';

class AddUpdateSubjectUseCase {
  final SubjectRepository repository;

  AddUpdateSubjectUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(SubjectEntity subject) async {
    return await repository.addUpdateSubjec(subject);
  }
}
