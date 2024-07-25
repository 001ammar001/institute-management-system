import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/students/data/models/student_course_model.dart';
import 'package:institute_management_system/features/students/domain/repositores/student_repository.dart';

class GetStudentCourseUseCase {
  final StudentRepository studentRepository;
  GetStudentCourseUseCase({required this.studentRepository});
  Future<Either<Failure, StudentCourseModelList>> call(
      {required int id}) async {
    return await studentRepository.getStudentCourse(id);
  }
}
