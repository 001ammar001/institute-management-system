import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/courses/domain/entites/subject_entity.dart';
import 'package:institute_management_system/features/employees/domain/entites/list_entity.dart';

abstract class SubjectRepository {
  Future<Either<Failure, Unit>> addUpdateSubjec(SubjectEntity subject);
  Future<Either<Failure, ListEntity<SubjectEntity>>> getSubjectList(int pageNumber);
  Future<Either<Failure, Unit>> deleteSubject(int id);
}
