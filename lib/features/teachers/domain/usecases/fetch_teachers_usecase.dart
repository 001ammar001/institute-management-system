import 'package:dartz/dartz.dart';
import '../../../../core/Errors/failures.dart';
import '../../data/models/teacher_model_list.dart';
import '../repositores/teacher_repository.dart';

class FetchTeachersUseCase  {
  final TeacherRepository repository;

  FetchTeachersUseCase({required this.repository});

  Future<Either<Failure, TeacherModelList>> call({
    required int pageNumber,
    required bool getArchived,
    required String name,
    required String phoneNumber,
}) async {
       return await repository.fetchTeachers(
         pageNumber: pageNumber,
         getArchived: getArchived,
         name: name,
         phoneNumber: phoneNumber,
       );
 }
}

