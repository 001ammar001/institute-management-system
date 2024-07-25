import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/features/employees/data/models/job_model.dart';
import 'package:institute_management_system/features/employees/domain/entites/list_entity.dart';

abstract class JobRemoteDataSource {
  Future<Unit> addUpdateJob(JobModel jobModel);
  Future<Unit> deleteJob(int id);
  Future<ListEntity<JobModel>> getJobTitleList(int pageNumber);
  Future<JobModel> getJobData(int id);
}

class JobDioRemoteDataSource extends JobRemoteDataSource {
  final Dio dio;

  JobDioRemoteDataSource({required this.dio});

  @override
  Future<Unit> addUpdateJob(JobModel jobModel) async {
    final response = await dio
        .post(
      jobModel.id != null ? "job-titles/${jobModel.id}" : "job-titles",
      data: jobModel.toJson(),
    )
        .onError((error, stackTrace) {
      throw ServerException();
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      return unit;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<JobModel> getJobData(int id) async {
    final response =
        await dio.get("job-titles/$id").onError((error, stackTrace) {
      throw ServerException();
    });
    if (response.statusCode == 200) {
      return JobModel.fromJson(response.data["data"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ListEntity<JobModel>> getJobTitleList(int pageNumber) async {
    final response = await dio.get(
      "job-titles/",
      queryParameters: {"page": pageNumber},
    ).onError((error, stackTrace) {
      throw ServerException();
    });
    if (response.statusCode == 200) {
      final data = response.data["data"];
      final List<JobModel> results = data
          .map<JobModel>((jsonPostModel) => JobModel.fromJson(jsonPostModel))
          .toList();

      return ListEntity(
        maxPage: response.data["meta"]["last_page"],
        entitys: results,
      );
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteJob(int id) async {
    final response =
        await dio.delete("job-titles/$id").onError((error, stackTrace) {
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
}
