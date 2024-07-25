import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/teachers/domain/entites/teacher_entity.dart';
import 'package:institute_management_system/features/teachers/domain/repositores/teacher_repository.dart';

class GetTeacherDetailsUseCase {
  final TeacherRepository repository;

  GetTeacherDetailsUseCase({required this.repository});

  Future<Either<Failure, TeacherEntity>> call(int id) async {
    return await repository.getTeacherDetails(id);
  }






}
