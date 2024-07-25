import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/accounts/domain/entites/permission_entity.dart';
import 'package:institute_management_system/features/accounts/domain/repositores/roles_repository.dart';

class GetPermissionsUseCase {
  final RoleRepository roleRepository;

  GetPermissionsUseCase({required this.roleRepository});

  Future<Either<Failure, List<PermissionEntity>>> call() async {
    return await roleRepository.getPermissions();
  }
}
