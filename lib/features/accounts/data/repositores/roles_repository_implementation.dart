import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/accounts/data/data_sources/roles_remote_data_source.dart';
import 'package:institute_management_system/features/accounts/data/models/role_model.dart';
import 'package:institute_management_system/features/accounts/domain/entites/permission_entity.dart';
import 'package:institute_management_system/features/accounts/domain/entites/role_entity.dart';
import 'package:institute_management_system/features/accounts/domain/repositores/roles_repository.dart';

import '../../domain/entites/role_list_entity.dart';

class RoleRepositoryImplementation extends RoleRepository {
  final RoleRemoteDataSource roleRemoteDataSource;

  RoleRepositoryImplementation({required this.roleRemoteDataSource});

  @override
  Future<Either<Failure, Unit>> addUpdateRole(RoleEntity role) async {
    final model = RoleModel(
      id: role.id,
      name: role.name,
      permissions: role.permissions,
    );
    try {
      final result = await roleRemoteDataSource.addUpdateRole(model);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<PermissionEntity>>> getPermissions() async {
    try {
      final result = await roleRemoteDataSource.getPermissions();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, RoleEntity>> getRoleDetails(int id) async {
    try {
      final result = await roleRemoteDataSource.getRoleDetails(id);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, RoleListEntity>> fetchRoles(
      {int pageNumber = 1}) async {
    try {
      dynamic result =
      await roleRemoteDataSource.getRoles(pageNumber: pageNumber);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteRole(int id) async {
    try {
      final result = await roleRemoteDataSource.deleteRole(id);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}
