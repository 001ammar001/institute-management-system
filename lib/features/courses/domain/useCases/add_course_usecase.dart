import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/courses/domain/entites/course_entity.dart';
import 'package:institute_management_system/features/courses/domain/repositores/course_repository.dart';

class AddUpdateCourseUseCase {
  final CourseRepository courseRepository;

  AddUpdateCourseUseCase({required this.courseRepository});

  Future<Either<Failure, Unit>> call(CourseEntity courseEntity) async {
    return await courseRepository.addUpdateCourse(courseEntity);
  }
}
