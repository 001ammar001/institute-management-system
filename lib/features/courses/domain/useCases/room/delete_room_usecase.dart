import 'package:dartz/dartz.dart';

import '../../../../../core/Errors/failures.dart';
import '../../repositores/room_category_repository.dart';

class DeleteRoomUseCase {
  final RoomAndCategoryRepository repository;

  DeleteRoomUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deleteRoom(id);
  }
}