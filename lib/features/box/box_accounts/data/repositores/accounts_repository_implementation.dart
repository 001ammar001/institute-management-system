
import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/exceptions.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import '../../domain/repositores/accounts_repository.dart';
import '../data_sources/accounts_remote_data_source.dart.dart';
import '../models/accounts_model.dart';

class AccountRepoImp extends AccountRepository {
  final AccountRemoteDataSource accountRemoteDataSource;

  AccountRepoImp({required this.accountRemoteDataSource});

  @override
  Future<Either<Failure, AccountModelList>> fetchMainAccount( {int pageNumber = 1}) async {
    try {
      dynamic result =
      await accountRemoteDataSource.getMainAccounts(pageNumber: pageNumber);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, AccountModelList>> fetchSubAccount( {int pageNumber = 1}) async {
    try {
      dynamic result =
      await accountRemoteDataSource.getSubAccounts(pageNumber: pageNumber);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteSubAccount(int id) async {
    try {
      final result = await accountRemoteDataSource.deleteSubAccounts(id);
      return Right(result);
    } on DataException catch (e) {
      return Left(DataFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}

