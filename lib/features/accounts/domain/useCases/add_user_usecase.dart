import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/accounts/domain/entites/user_entity.dart';
import 'package:institute_management_system/features/accounts/domain/repositores/user_repository.dart';

class AddUserUseCase {
  final UserRepository repositrory;

  AddUserUseCase({required this.repositrory});

  Future<Either<Failure, Unit>> call(UserEntity userEntity) async {
    return await repositrory.addUser(userEntity);
  }
}
