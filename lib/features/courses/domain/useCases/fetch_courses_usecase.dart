import 'package:dartz/dartz.dart';
import '../../../../core/Errors/failures.dart';
import '../../data/models/course_model_list.dart';
import '../repositores/course_repository.dart';

class FetchCoursesUseCase {
  final CourseRepository repository;

  FetchCoursesUseCase({required this.repository});

  Future<Either<Failure, CourseModelList>> call({
    required int pageNumber,
    required bool getArchived,
    required String status,
    required String teacher,
    required String room,
    required String subject,
    required String startAt,
    required String endAt,
  }) async {
    return await repository.fetchCourses(
      pageNumber: pageNumber,
      getArchived: getArchived,
      status: status,
      teacher: teacher,
      room: room,
      subject: subject,
      startAt: startAt,
      endAt: endAt,
    );
  }
}
