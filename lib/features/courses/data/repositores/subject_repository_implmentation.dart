import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/courses/data/data_sources/subject_remote_data_source.dart';
import 'package:institute_management_system/features/courses/data/models/subject_model.dart';
import 'package:institute_management_system/features/courses/domain/entites/subject_entity.dart';
import 'package:institute_management_system/features/courses/domain/repositores/subject_repository.dart';
import 'package:institute_management_system/features/employees/domain/entites/list_entity.dart';

class SubjectRepositoryImplementation extends SubjectRepository {
  final SubjectRemoteDataSource subjectRemoteDataSource;

  SubjectRepositoryImplementation({required this.subjectRemoteDataSource});

  @override
  Future<Either<Failure, Unit>> addUpdateSubjec(SubjectEntity subject) async {
    final model = SubjectModel(
        id: subject.id, subject: subject.subject, category: subject.category);
    try {
      final result = await subjectRemoteDataSource.addUpdateSubject(model);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteSubject(int id) async {
    try {
      final result = await subjectRemoteDataSource.deleteSubject(id);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ListEntity<SubjectEntity>>> getSubjectList(
      int pageNumber) async {
    try {
      final result = await subjectRemoteDataSource.getSubjects(pageNumber);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
