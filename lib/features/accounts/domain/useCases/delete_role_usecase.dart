import 'package:dartz/dartz.dart';

import '../../../../core/Errors/failures.dart';
import '../repositores/roles_repository.dart';


class DeleteRoleUseCase {
  final RoleRepository repository;

  DeleteRoleUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deleteRole(id);
  }
}