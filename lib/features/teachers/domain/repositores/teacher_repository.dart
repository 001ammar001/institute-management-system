import 'package:dartz/dartz.dart';
import 'package:institute_management_system/core/Errors/failures.dart';
import 'package:institute_management_system/features/teachers/domain/entites/teacher_entity.dart';
import '../../data/models/teacher_model_list.dart';

abstract class TeacherRepository {
  Future<Either<Failure, Unit>> addUpdateTeacher(TeacherEntity teacher);
  Future<Either<Failure, TeacherEntity>> getTeacherDetails(int id);
  Future<Either<Failure, TeacherModelList>> fetchTeachers({
    required int pageNumber,
    required bool getArchived,
    required String name,
    required String phoneNumber,
});
  Future<Either<Failure, Unit>> deleteTeacher(int id);

}
