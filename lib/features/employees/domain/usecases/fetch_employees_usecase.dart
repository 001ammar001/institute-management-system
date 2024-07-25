import 'package:dartz/dartz.dart';
import '../../../../core/Errors/failures.dart';
import '../../data/models/employee_model_list.dart';
import '../repositires/employee_repository.dart';

class FetchEmployeesUseCase  {
  final EmployeeRepository repository;

  FetchEmployeesUseCase({required this.repository});

  Future<Either<Failure, EmployeeModelList>> call({int pageNumber = 1}) async {
       return await repository.fetchEmployees(pageNumber: pageNumber);
 }
}

