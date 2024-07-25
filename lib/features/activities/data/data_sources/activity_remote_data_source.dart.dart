import 'package:dio/dio.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import '../../../../core/utils/Network/end_points.dart';
import '../models/activity_model_list.dart';


abstract class ActivityListRemoteDataSource {
  Future<ActivityModelList> getActivities({
    required int pageNumber,
    required String userName,
    required String operation,
    required String model,
});
 // Future<Unit> deleteActivity(int id);
}

class ActivityDioRemoteDataSource extends ActivityListRemoteDataSource {
  final Dio dio;
  ActivityDioRemoteDataSource({required this.dio});

  @override
  Future<ActivityModelList> getActivities({
    required int pageNumber,
    required String userName,
    required String operation,
    required String model,
}) async {
    final response = await dio.get(
      ACTIVITIESLIST,
      queryParameters: {
        'page': pageNumber,
        'name': userName,
        'operation': operation,
        'model': model,
      },
    ).then((value) {
      if (value.statusCode == 200 || value.statusCode == 201) {
        ActivityModelList st = ActivityModelList.fromJson(value.data);
        return st;
      } else if (value.data.statusCode == 422) {
        throw DataException(message: value.data.data["message"]);
      } else {
        throw ServerException();
      }
    }).onError((error, stackTrace) {
      print(error);
      throw ServerException();
    });

    return response;
  }

}
