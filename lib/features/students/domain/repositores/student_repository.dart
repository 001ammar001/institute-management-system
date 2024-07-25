import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/students/data/models/student_course_model.dart';
import 'package:institute_management_system/features/students/data/models/student_model_list.dart';
import 'package:institute_management_system/features/students/domain/entites/student_entity.dart';

abstract class StudentRepository {
  Future<Either<Failure, Unit>> addUpdateStudent(StudentEnity student);

  Future<Either<Failure, StudentEnity>> getStudentDetails(int id);

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
  });
  Future<Either<Failure, StudentCourseModelList>> getStudentCourse(int id);
  Future<Either<Failure, StudentModelList>> fetchStudentsWithoutPagination();
  Future<Either<Failure, Unit>> deleteStudent(int id);
}
