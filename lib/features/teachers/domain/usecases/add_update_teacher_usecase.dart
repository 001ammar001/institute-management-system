import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/teachers/domain/entites/teacher_entity.dart';
import 'package:institute_management_system/features/teachers/domain/repositores/teacher_repository.dart';

class AddUpdateTeacherUseCase {
  final TeacherRepository repository;

  AddUpdateTeacherUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(TeacherEntity teacher) async {
    return await repository.addUpdateTeacher(teacher);
  }
}