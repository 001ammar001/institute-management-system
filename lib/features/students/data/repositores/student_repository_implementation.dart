import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/students/data/data_sources/student_remote_data_source.dart.dart';
import 'package:institute_management_system/features/students/data/models/student_course_model.dart';
import 'package:institute_management_system/features/students/data/models/student_model.dart';
import 'package:institute_management_system/features/students/domain/entites/student_entity.dart';
import 'package:institute_management_system/features/students/domain/repositores/student_repository.dart';
import '../models/student_model_list.dart';

class StudentRepositoryImplementation extends StudentRepository {
  final StudentRemoteDataSource studentRemoteDataSource;

  StudentRepositoryImplementation({required this.studentRemoteDataSource});

  @override
  Future<Either<Failure, Unit>> addUpdateStudent(StudentEnity student) async {
    final model = StudentModel(
        id: student.id,
        aName: student.aName,
        eName: student.eName,
        fArName: student.fArName,
        fEnName: student.fEnName,
        mArName: student.mArName,
        mEnName: student.mEnName,
        phoneNumber: student.phoneNumber,
        lineNumber: student.lineNumber,
        nationalNumber: student.nationalNumber,
        gender: student.gender,
        birthDate: student.birthDate,
        nationality: student.nationality,
        educationLevel: student.educationLevel);
    try {
      final result = await studentRemoteDataSource.addUpdateStudent(model);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, StudentEnity>> getStudentDetails(int id) async {
    try {
      final result = await studentRemoteDataSource.getStudentData(id);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, StudentModelList>> fetchStudents({
    required int pageNumber,
    required bool getArchived,
    required String arabicNameStudent,
    required String englishNameStudent,
    required String fatherName,
    required String motherName,
    required String createDate,
    required String educationLevel,
    required String lineNumber,
  }) async {
    try {
      dynamic result = await studentRemoteDataSource.getStudents(
          pageNumber: pageNumber,
          getArchived: getArchived,
          arabicNameStudent: arabicNameStudent,
          englishNameStudent: englishNameStudent,
          fatherName: fatherName,
          motherName: motherName,
          createDate: createDate,
          educationLevel: educationLevel,
          lineNumber: lineNumber);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, StudentModelList>>
      fetchStudentsWithoutPagination() async {
    try {
      final result =
          await studentRemoteDataSource.getStudentsWithoutPagination();
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteStudent(int id) async {
    try {
      final result = await studentRemoteDataSource.deleteStudent(id);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, StudentCourseModelList>> getStudentCourse(
      int id) async {
    try {
      final result = await studentRemoteDataSource.getStudentCourse(id);
      return right(result);
    } on DataException catch (e) {
      return left(DataFailure(message: e.message));
    } on ServerException {
      return left(ServerFailure());
    }
  }
}
