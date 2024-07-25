import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/courses/domain/entites/course_entity.dart';
import 'package:institute_management_system/features/courses/domain/repositores/course_repository.dart';

class GetCourseDetailsUseCase {
  final CourseRepository courseRepository;

  GetCourseDetailsUseCase({required this.courseRepository});

  Future<Either<Failure, CourseEntity>> call(int id) async {
    return await courseRepository.getCourseDetails(id);
  }
}
