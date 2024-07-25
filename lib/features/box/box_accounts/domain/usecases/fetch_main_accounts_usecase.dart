import 'package:dartz/dartz.dart';
import '../../../../../core/Errors/failures.dart';
import '../../data/models/accounts_model.dart';
import '../repositores/accounts_repository.dart';



class FetchMainAccountsUseCase  {
  final AccountRepository repository;

  FetchMainAccountsUseCase({required this.repository});

  Future<Either<Failure, AccountModelList>> call({int pageNumber = 1}) async {
       return await repository.fetchMainAccount(pageNumber: pageNumber);
 }
}

