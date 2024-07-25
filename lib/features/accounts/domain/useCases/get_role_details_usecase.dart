import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/accounts/domain/entites/role_entity.dart';
import 'package:institute_management_system/features/accounts/domain/repositores/roles_repository.dart';

class GetRoleDetailsUseCase {
  final RoleRepository roleRepository;

  GetRoleDetailsUseCase({required this.roleRepository});

  Future<Either<Failure, RoleEntity>> call(int id) async {
    return await roleRepository.getRoleDetails(id);
  }
}
