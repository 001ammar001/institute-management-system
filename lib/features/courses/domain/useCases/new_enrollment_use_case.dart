import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/courses/data/models/enrollment_model.dart';
import 'package:institute_management_system/features/courses/domain/repositores/course_repository.dart';

class NewEnrollmentUseCase {
  final CourseRepository courseRepository;

  NewEnrollmentUseCase({required this.courseRepository});

  Future<Either<Failure, Unit>> call(EnrollmentModel enrollmentModel) async {
    return await courseRepository.newEnrollment(enrollmentModel);
  }
}
