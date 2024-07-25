import 'package:dartz/dartz.dart';

import '../../../../../core/Errors/failures.dart';
import '../../../data/models/room_category_model_list.dart';
import '../../repositores/room_category_repository.dart';

class FetchRoomsUseCase  {
  final RoomAndCategoryRepository repository;

  FetchRoomsUseCase({required this.repository});

  Future<Either<Failure, RoomCategoryModelList>> call({int pageNumber = 1}) async {
       return await repository.fetchRooms(pageNumber: pageNumber);
 }
}

