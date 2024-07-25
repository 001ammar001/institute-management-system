import 'package:calendar_view/calendar_view.dart';
import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/courses/domain/repositores/course_repository.dart';

class GetCalendarEventsUseCase {
  final CourseRepository courseRepository;

  GetCalendarEventsUseCase({required this.courseRepository});

  Future<Either<Failure, List<CalendarEventData>>> call() async {
    return await courseRepository.getCalendarEvents();
  }
}
