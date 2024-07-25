import 'package:calendar_view/calendar_view.dart';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/core/functions/data_extinsions.dart';
import 'package:institute_management_system/features/courses/data/models/course_model.dart';
import 'package:institute_management_system/features/courses/data/models/enrollment_model.dart';

import '../../../../core/utils/Network/end_points.dart';
import '../models/course_model_list.dart';

abstract class CourseRemoteDataSource {
  Future<Unit> addUpdateCourse(CourseModel coures);
  Future<List<CalendarEventData>> getCalendarEvents();
  Future<CourseModel> getCourseDetails(int id);
  Future<CourseModelList> getCourses({
    required int pageNumber,
    required bool getArchived,
    required String status,
    required String teacher,
    required String room,
    required String subject,
    required String startAt,
    required String endAt,
  });
  Future<Unit> deleteCourse(int id);
  Future<Unit> newEnrollment(EnrollmentModel enrollmentModel);
}

class CourseDioRemoteDataSource extends CourseRemoteDataSource {
  final Dio dio;

  CourseDioRemoteDataSource({required this.dio});

  @override
  Future<Unit> addUpdateCourse(CourseModel coures) async {
    final response = await dio
        .post(coures.id != null ? "courses/${coures.id}" : "courses",
            data: coures.toJson())
        .onError((error, stackTrace) => throw ServerException());

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Future.value(unit);
    } else if (response.statusCode == 422) {
      throw DataException(message: response.data["message"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<CalendarEventData>> getCalendarEvents() async {
    final response = await dio
        .get("courses")
        .onError((error, stackTrace) => throw ServerException());

    if (response.statusCode == 200) {
      final data = response.data["data"] as List;
      List<CalendarEventData> results = [];
      for (Map<String, dynamic> element in data) {
        final DateTime startTime =
            (element["schedule"]["starts"] as String).paraseStringToEvent();
        final DateTime endTime =
            (element["schedule"]["ends"] as String).paraseStringToEvent();

        for (String date in element["dates"]) {
          results.add(
            CalendarEventData(
              date: DateTime.parse(date),
              startTime: startTime,
              endTime: endTime,
              title: element["subject"]["name"],
              description:
                  "${element["teacher"]["name"]}-${element["room"]["name"]}",
              event: element["id"],
            ),
          );
        }
      }
      return Future.value(results);
    } else if (response.statusCode == 422) {
      throw DataException(message: response.data["message"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CourseModel> getCourseDetails(int id) async {
    final response = await dio.get("courses/$id").onError((error, stackTrace) {
      throw ServerException();
    });
    if (response.statusCode == 200) {
      return CourseModel.fromJson(response.data["data"]);
    } else {
      throw ServerException();
    }
  }

  // @override
  // Future<StudentModelList> getStudents({
  //   required int pageNumber,
  //   required bool getArchived,
  //   required String arabicNameStudent,
  //   required String englishNameStudent,
  //   required String fatherName,
  //   required String motherName,
  //   required String createDate,
  //   required String educationLevel,
  //   required String lineNumber,
  // }) async {
  //   final response = await dio.get(
  //     STUDENTSLIST,
  //     queryParameters: {
  //       'page': pageNumber,
  //       'name': arabicNameStudent,
  //       // 'english': englishNameStudent,
  //       // 'father': fatherName,
  //       // 'mother': motherName,
  //       //'date': createDate,
  //       'education_level': educationLevel,
  //       'line_number': lineNumber,
  //       //'trashed': getArchived ? "1" : "0",
  //     },
  //   ).then((value) {
  @override
  Future<CourseModelList> getCourses({
    required int pageNumber,
    required bool getArchived,
    required String status,
    required String teacher,
    required String room,
    required String subject,
    required String startAt,
    required String endAt,
  }) async {
    final response = await dio.get(
      COURSESLIST,
      queryParameters: {
        'page': pageNumber,
        'trashed': getArchived ? "1" : "0",
        'status': status,
        'teacher': teacher,
        'room': room,
        'subject': subject,
        'start_at': startAt,
        'end_at': endAt,
      },
    ).then((value) {
      if (value.statusCode == 200) {
        CourseModelList st = CourseModelList.fromJson(value.data);
        return st;
      } else if (value.data.statusCode == 422) {
        throw DataException(message: value.data.data["message"]);
      } else {
        throw ServerException();
      }
    }).onError((error, stackTrace) {
      throw ServerException();
    });

    return response;
  }

  @override
  Future<Unit> deleteCourse(int id) async {
    final response =
        await dio.delete('$DELETECOURSES$id').onError((error, stackTrace) {
      throw ServerException();
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      return unit;
    } else if (response.statusCode == 422) {
      throw DataException(message: response.data["message"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> newEnrollment(EnrollmentModel enrollmentModel) async {
    final response = await dio
        .post("enrollments/", data: enrollmentModel.toJson())
        .onError((error, stackTrace) => throw ServerException());

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Future.value(unit);
    } else if (response.statusCode == 422) {
      throw DataException(message: response.data["message"]);
    } else {
      throw ServerException();
    }
  }
}
// NoSuchMethodError: Class '_Map<String, dynamic>' has no instance getter 'statusCode'.
// Receiver: _Map len:5
// Tried calling: statusCode