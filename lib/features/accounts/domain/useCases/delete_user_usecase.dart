import 'package:dartz/dartz.dart';

import '../../../../core/Errors/failures.dart';
import '../repositores/user_repository.dart';

class DeleteUserUseCase {
  final UserRepository repository;

  DeleteUserUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deleteUser(id);
  }
}
