import 'package:dartz/dartz.dart';
import '../../../../core/Errors/failures.dart';
import '../../data/models/user_model_list.dart';
import '../repositores/user_repository.dart';

class FetchUsersUseCase {
  final UserRepository repository;

  FetchUsersUseCase({required this.repository});

  Future<Either<Failure, UserModelList>> call(
      int pageNumber, bool getArchived, String roleName) async {
    return await repository.fetchUsers(pageNumber, getArchived, roleName);
  }
}
