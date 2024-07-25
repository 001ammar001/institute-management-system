import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/teachers/data/data_sources/teacher_remote_data_source.dart.dart';
import 'package:institute_management_system/features/teachers/data/models/teacher_model.dart';
import 'package:institute_management_system/features/teachers/domain/entites/teacher_entity.dart';
import 'package:institute_management_system/features/teachers/domain/repositores/teacher_repository.dart';

import '../models/teacher_model_list.dart';

class TeacherRepositoryImplementation extends TeacherRepository {
  final TeacherRemoteDataSource teacherRemoteDataSource;

  TeacherRepositoryImplementation({required this.teacherRemoteDataSource});

  @override
  Future<Either<Failure, Unit>> addUpdateTeacher(TeacherEntity teacher) async {
    final model = TeacherModel(
        id: teacher.id,
        name: teacher.name,
        phoneNumber: teacher.phoneNumber,
        birthDate: teacher.birthDate,
        credentials: teacher.credentials);
    try {
      final result = await teacherRemoteDataSource.addUpdateTeacher(model);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, TeacherEntity>> getTeacherDetails(int id) async {
    try {
      final result = await teacherRemoteDataSource.getTeacherDetails(id);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, TeacherModelList>> fetchTeachers(
      {
        required int pageNumber,
        required bool getArchived,
        required String name,
        required String phoneNumber,
}) async {
    try {
      dynamic result =
      await teacherRemoteDataSource.getTeachers(
          pageNumber: pageNumber,
          getArchived: getArchived,
          name: name,
          phoneNumber: phoneNumber,
      );
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTeacher(int id) async {
    try {
      final result = await teacherRemoteDataSource.deleteTeacher(id);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}
