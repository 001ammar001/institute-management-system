import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';

import '../../data/models/accounts_model.dart';



abstract class AccountRepository {

  Future<Either<Failure, AccountModelList>> fetchMainAccount({int pageNumber = 1});

  Future<Either<Failure, AccountModelList>> fetchSubAccount({int pageNumber = 1});

  Future<Either<Failure, Unit>> deleteSubAccount(int id);

}

