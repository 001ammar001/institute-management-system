import 'package:dartz/dartz.dart';
import 'package:institute_management_system/features/accounts/data/models/user_model_list.dart';

import '../../../../core/Errors/failures.dart';
import '../repositores/user_repository.dart';

class EditUserUseCase {
  final UserRepository repository;

  EditUserUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(User user) async {
    return await repository.editUser(user);
  }
}
