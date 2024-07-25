import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/accounts/data/data_sources/users_remote_data_source.dart';
import 'package:institute_management_system/features/accounts/data/models/user_model.dart';
import 'package:institute_management_system/features/accounts/data/models/user_model_list.dart';
import 'package:institute_management_system/features/accounts/domain/entites/user_entity.dart';
import 'package:institute_management_system/features/accounts/domain/repositores/user_repository.dart';

class UserRepositoryImplementation extends UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImplementation({required this.userRemoteDataSource});

  @override
  Future<Either<Failure, Unit>> addUser(UserEntity user) async {
    final model = UserModel(
        username: user.username,
        password: user.password,
        employee: user.employee,
        role: user.role);
    try {
      final result = await userRemoteDataSource.addUser(model);
      return Right(result);
    } on DataException catch (error) {
      return Left(DataFailure(message: error.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserModelList>> fetchUsers(
      int pageNumber, bool getArchived, String roleName) async {
    try {
      dynamic result = await userRemoteDataSource.getUsers(
          pageNumber, getArchived, roleName);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserDetailsModel>> getUserDetails(int id) async {
    try {
      dynamic result = await userRemoteDataSource.getUserDetails(id);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteUser(int id) async {
    try {
      final result = await userRemoteDataSource.deleteUser(id);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> editUser(User user) async {
    try {
      final result = await userRemoteDataSource.editUser(user);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> restoreUser(int id) async {
    try {
      final result = await userRemoteDataSource.restoreUser(id);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
