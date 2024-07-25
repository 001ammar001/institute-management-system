import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/features/courses/data/models/subject_model.dart';
import 'package:institute_management_system/features/employees/domain/entites/list_entity.dart';

abstract class SubjectRemoteDataSource {
  Future<Unit> addUpdateSubject(SubjectModel subject);
  Future<ListEntity<SubjectModel>> getSubjects(int pageNumber);
  Future<Unit> deleteSubject(int id);
}

class SubjectDioDataSource extends SubjectRemoteDataSource {
  final Dio dio;

  SubjectDioDataSource({required this.dio});

  @override
  Future<Unit> addUpdateSubject(SubjectModel subject) async {
    final response = await dio
        .post(subject.id != null ? "subjects/${subject.id}" : "subjects",
            data: subject.toJson())
        .onError((error, stackTrace) => throw ServerException());

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteSubject(int id) async {
    final response =
        await dio.delete("subjects/$id").onError((error, stackTrace) {
      throw ServerException();
    });
    if (response.statusCode == 200 || response.statusCode == 204) {
      return unit;
    } else if (response.statusCode == 422) {
      throw DataException(message: response.data["message"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ListEntity<SubjectModel>> getSubjects(int pageNumber) async {
    final response = await dio.get(
      "subjects/",
      queryParameters: {"page": pageNumber},
    ).onError((error, stackTrace) {
      throw ServerException();
    });
    if (response.statusCode == 200) {
      final data = response.data["data"];
      final List<SubjectModel> results = data
          .map<SubjectModel>(
              (jsonPostModel) => SubjectModel.fromJson(jsonPostModel))
          .toList();
      return ListEntity(
        maxPage: response.data["meta"]["last_page"],
        entitys: results,
      );
    } else {
      throw ServerException();
    }
  }
}
