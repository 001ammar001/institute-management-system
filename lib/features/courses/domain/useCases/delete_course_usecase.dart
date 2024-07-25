import 'package:dartz/dartz.dart';

import '../../../../core/Errors/failures.dart';
import '../repositores/course_repository.dart';
class DeleteCourseUseCase {
  final CourseRepository repository;

  DeleteCourseUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deleteCourse(id);
  }
}