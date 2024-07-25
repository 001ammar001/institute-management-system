import 'package:dartz/dartz.dart';
import '../../../../core/Errors/failures.dart';
import '../entites/role_list_entity.dart';
import '../repositores/roles_repository.dart';

class FetchRolesUseCase  {
  final RoleRepository repository;

  FetchRolesUseCase({required this.repository});

  Future<Either<Failure, RoleListEntity>> call({int pageNumber = 1}) async {
       return await repository.fetchRoles(pageNumber: pageNumber);
 }
}

