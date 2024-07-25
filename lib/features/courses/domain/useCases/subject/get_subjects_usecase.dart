import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/courses/domain/entites/subject_entity.dart';
import 'package:institute_management_system/features/courses/domain/repositores/subject_repository.dart';
import 'package:institute_management_system/features/employees/domain/entites/list_entity.dart';

class GetSubjectsUseCase {
  final SubjectRepository repository;

  GetSubjectsUseCase({required this.repository});

  Future<Either<Failure, ListEntity<SubjectEntity>>> call(
      int pageNumbre) async {
    return await repository.getSubjectList(pageNumbre);
  }
}
