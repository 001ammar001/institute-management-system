import 'package:dartz/dartz.dart';

import '../../../../../core/Errors/failures.dart';
import '../repositores/accounts_repository.dart';


class DeleteAccountsUseCase {
  final AccountRepository repository;

  DeleteAccountsUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deleteSubAccount(id);
  }
}