import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/accounts/domain/entites/permission_entity.dart';
import 'package:institute_management_system/features/accounts/domain/entites/role_entity.dart';

import '../entites/role_list_entity.dart';

abstract class RoleRepository {
  Future<Either<Failure, Unit>> addUpdateRole(RoleEntity role);
  Future<Either<Failure, RoleEntity>> getRoleDetails(int id);
  Future<Either<Failure, List<PermissionEntity>>> getPermissions();
  Future<Either<Failure, RoleListEntity>> fetchRoles({int pageNumber = 1});
  Future<Either<Failure, Unit>> deleteRole(int id);
}
