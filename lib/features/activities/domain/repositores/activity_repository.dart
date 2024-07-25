import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';

import '../../data/models/activity_model_list.dart';



abstract class ActivityListRepository {

  Future<Either<Failure, ActivityModelList>> fetchActivities({
    required int pageNumber,
    required String userName,
    required String operation,
    required String model,
  });

}