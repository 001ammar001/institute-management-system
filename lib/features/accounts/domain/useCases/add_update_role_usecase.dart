import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/accounts/domain/entites/role_entity.dart';
import 'package:institute_management_system/features/accounts/domain/repositores/roles_repository.dart';

class AddUpdateRoleUseCase {
  final RoleRepository roleRepository;

  AddUpdateRoleUseCase({required this.roleRepository});

  Future<Either<Failure, Unit>> call(RoleEntity roleEntity) async {
    return await roleRepository.addUpdateRole(roleEntity);
  }
}
