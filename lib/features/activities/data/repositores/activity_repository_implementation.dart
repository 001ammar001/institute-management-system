
import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import '../../domain/repositores/activity_repository.dart';
import '../data_sources/activity_remote_data_source.dart.dart';
import '../models/activity_model_list.dart';

class ActivityListRepositoryImplementation extends ActivityListRepository {
  final ActivityListRemoteDataSource activityRemoteDataSource;

  ActivityListRepositoryImplementation({required this.activityRemoteDataSource});

  @override
  Future<Either<Failure, ActivityModelList>> fetchActivities(
      {
        required int pageNumber,
        required String userName,
        required String operation,
        required String model,
      }) async {
    try {
      dynamic result =
      await activityRemoteDataSource.getActivities(
        pageNumber: pageNumber,
        userName: userName,
        operation: operation,
        model: model,
      );
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }


}

