import 'package:calendar_view/calendar_view.dart';
import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/courses/data/data_sources/course_remote_datasource.dart';
import 'package:institute_management_system/features/courses/data/models/course_model.dart';
import 'package:institute_management_system/features/courses/data/models/enrollment_model.dart';
import 'package:institute_management_system/features/courses/domain/entites/course_entity.dart';
import 'package:institute_management_system/features/courses/domain/repositores/course_repository.dart';

import '../models/course_model_list.dart';

class CourseRepositoryImplementation extends CourseRepository {
  final CourseRemoteDataSource courseRemoteDataSource;

  CourseRepositoryImplementation({required this.courseRemoteDataSource});

  @override
  Future<Either<Failure, Unit>> addUpdateCourse(
      CourseEntity courseEntity) async {
    final model = CourseModel(
        teacher: courseEntity.teacher,
        subject: courseEntity.subject,
        room: courseEntity.room,
        minStudent: courseEntity.minStudent,
        startDate: courseEntity.startDate,
        endDate: courseEntity.endDate,
        startTime: courseEntity.startTime,
        endTime: courseEntity.endTime,
        priceToStudent: courseEntity.priceToStudent,
        teacherSalary: courseEntity.teacherSalary,
        days: courseEntity.days,
        selectedSalartType: courseEntity.selectedSalartType,
        courseStatus: courseEntity.courseStatus);
    try {
      final result = await courseRemoteDataSource.addUpdateCourse(model);

      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<CalendarEventData>>> getCalendarEvents() async {
    try {
      final result = await courseRemoteDataSource.getCalendarEvents();
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CourseEntity>> getCourseDetails(int id) async {
    try {
      final result = await courseRemoteDataSource.getCourseDetails(id);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CourseModelList>> fetchCourses({
    required int pageNumber,
    required bool getArchived,
    required String status,
    required String teacher,
    required String room,
    required String subject,
    required String startAt,
    required String endAt,
  }) async {
    try {
      dynamic result = await courseRemoteDataSource.getCourses(
        pageNumber: pageNumber,
        getArchived: getArchived,
        status: status,
        teacher: teacher,
        room: room,
        subject: subject,
        startAt: startAt,
        endAt: endAt,
      );
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCourse(int id) async {
    try {
      final result = await courseRemoteDataSource.deleteCourse(id);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> newEnrollment(
      EnrollmentModel enrollmentModel) async {
    try {
      final result =
          await courseRemoteDataSource.newEnrollment(enrollmentModel);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
