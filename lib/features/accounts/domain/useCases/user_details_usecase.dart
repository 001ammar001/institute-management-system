import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/accounts/data/models/user_model.dart';
import 'package:institute_management_system/features/accounts/domain/repositores/user_repository.dart';

class UserDetailsUseCase {
  final UserRepository repositrory;

  UserDetailsUseCase({required this.repositrory});

  Future<Either<Failure, UserDetailsModel>> call(int id) async {
    return await repositrory.getUserDetails(id);
  }
}
