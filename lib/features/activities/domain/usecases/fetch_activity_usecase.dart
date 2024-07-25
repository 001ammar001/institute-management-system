import 'package:dartz/dartz.dart';
import '../../../../core/Errors/failures.dart';
import '../../data/models/activity_model_list.dart';
import '../repositores/activity_repository.dart';



class FetchActivitiesUseCase  {
  final ActivityListRepository repository;

  FetchActivitiesUseCase({required this.repository});

  Future<Either<Failure, ActivityModelList>> call({
    required int pageNumber,
    required String userName,
    required String operation,
    required String model,
}) async {
       return await repository.fetchActivities(
           pageNumber: pageNumber,
           userName: userName,
           operation: operation,
           model: model,
       );
 }
}

