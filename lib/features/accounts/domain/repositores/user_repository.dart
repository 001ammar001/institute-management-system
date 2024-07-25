import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/accounts/data/models/user_model.dart';
import 'package:institute_management_system/features/accounts/data/models/user_model_list.dart';
import 'package:institute_management_system/features/accounts/domain/entites/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, Unit>> addUser(UserEntity user);
  Future<Either<Failure, UserModelList>> fetchUsers(
    int pageNumber,
    bool getArchived,
    String roleName,
  );
  Future<Either<Failure, UserDetailsModel>> getUserDetails(int id);
  Future<Either<Failure, Unit>> editUser(User user);
  Future<Either<Failure, Unit>> deleteUser(int id);
  Future<Either<Failure, Unit>> restoreUser(int id);
}
