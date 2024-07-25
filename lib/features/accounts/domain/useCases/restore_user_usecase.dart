import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/accounts/domain/repositores/user_repository.dart';

class RestoreUserUseCase {
  final UserRepository repositrory;

  RestoreUserUseCase({required this.repositrory});

  Future<Either<Failure, Unit>> call(int id) async {
    return await repositrory.restoreUser(id);
  }
}
