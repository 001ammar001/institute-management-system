import 'package:calendar_view/calendar_view.dart';
import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/courses/data/models/enrollment_model.dart';
import 'package:institute_management_system/features/courses/domain/entites/course_entity.dart';
import '../../data/models/course_model_list.dart';

abstract class CourseRepository {
  Future<Either<Failure, Unit>> addUpdateCourse(CourseEntity courseEntity);
  Future<Either<Failure, List<CalendarEventData>>> getCalendarEvents();
  Future<Either<Failure, CourseEntity>> getCourseDetails(int id);
  Future<Either<Failure, CourseModelList>> fetchCourses({
    required int pageNumber,
    required bool getArchived,
    required String status,
    required String teacher,
    required String room,
    required String subject,
    required String startAt,
    required String endAt,
  });
  Future<Either<Failure, Unit>> deleteCourse(int id);
  Future<Either<Failure, Unit>> newEnrollment(EnrollmentModel enrollmentModel);
}
