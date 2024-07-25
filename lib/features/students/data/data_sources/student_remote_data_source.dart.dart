import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/features/students/data/models/student_course_model.dart';
import 'package:institute_management_system/features/students/data/models/student_model.dart';
import 'package:institute_management_system/core/utils/network/end_points.dart';
import '../models/student_model_list.dart';

abstract class StudentRemoteDataSource {
  Future<Unit> addUpdateStudent(StudentModel student);
  Future<StudentModel> getStudentData(int id);
  Future<StudentModelList> getStudents({
    required int pageNumber,
    required bool getArchived,
    required String arabicNameStudent,
    required String englishNameStudent,
    required String fatherName,
    required String motherName,
    required String createDate,
    required String educationLevel,
    required String lineNumber,
  });
  Future<StudentCourseModelList> getStudentCourse(int id);
  Future<StudentModelList> getStudentsWithoutPagination();
  Future<Unit> deleteStudent(int id);
}

class StudentDioRemoteDataSource extends StudentRemoteDataSource {
  final Dio dio;
  StudentDioRemoteDataSource({required this.dio});

  @override
  Future<Unit> addUpdateStudent(StudentModel student) async {
    final response = await dio
        .post(student.id != null ? "students/${student.id}" : "students",
            data: student.toJson())
        .onError((error, stackTrace) => throw ServerException());
    if (response.statusCode == 200 || response.statusCode == 201) {
      return unit;
    } else if (response.statusCode == 422) {
      throw DataException(message: response.data["message"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<StudentModel> getStudentData(int id) async {
    final response = await dio.get("students/$id").onError((error, stackTrace) {
      throw ServerException();
    });
    if (response.statusCode == 200) {
      return StudentModel.fromJson(response.data["data"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<StudentModelList> getStudents({
    required int pageNumber,
    required bool getArchived,
    required String arabicNameStudent,
    required String englishNameStudent,
    required String fatherName,
    required String motherName,
    required String createDate,
    required String educationLevel,
    required String lineNumber,
  }) async {
    //TODO make achived filter work
    final response = await dio.get(
      STUDENTSLIST,
      queryParameters: {
        'page': pageNumber,
        'name': arabicNameStudent,
        'name_en': englishNameStudent,
        'father_name': fatherName,
        'mother_name': motherName,
        //'date': createDate,
        'education_level': educationLevel,
        'line_number': lineNumber,
        //'trashed': getArchived ? "1" : "0",
      },
    ).then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        StudentModelList st = StudentModelList.fromJson(value.data);
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
  Future<StudentCourseModelList> getStudentCourse(int id) async {
    final response = await dio
        .get("$STUDENT$id$COURSES")
        .onError((error, stackTrace) => throw ServerException());
    if (response.statusCode == 200) {
      return StudentCourseModelList.fromJson(response.data);
    } else if (response.statusCode == 422) {
      throw DataException(message: response.data.data["message"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<StudentModelList> getStudentsWithoutPagination() async {
    final response = await dio
        .get(
      STUDENTSLIST,
    )
        .then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        StudentModelList st = StudentModelList.fromJson(value.data);
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
  Future<Unit> deleteStudent(int id) async {
    final response =
        await dio.delete('$STUDENT$id').onError((error, stackTrace) {
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
}
