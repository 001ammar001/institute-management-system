import 'package:dartz/dartz.dart';
import '../../../../core/Errors/failures.dart';
import '../repositores/teacher_repository.dart';

class DeleteTeacherUseCase {
  final TeacherRepository repository;

  DeleteTeacherUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deleteTeacher(id);
  }
}