import 'package:dartz/dartz.dart';
import '../../../../core/Errors/failures.dart';
import '../../data/models/student_model_list.dart';
import '../repositores/student_repository.dart';

class FetchStudentsUseCase {
  final StudentRepository repository;

  FetchStudentsUseCase({required this.repository});

  Future<Either<Failure, StudentModelList>> call({
    required int pageNumber,
    required bool getArchived,
    required String arabicNameStudent,
    required String englishNameStudent,
    required String fatherName,
    required String motherName,
    required String createDate,
    required String educationLevel,
    required String lineNumber,
  }) async {
    return await repository.fetchStudents(
      pageNumber: pageNumber,
      getArchived: getArchived,
      arabicNameStudent: arabicNameStudent,
      englishNameStudent: englishNameStudent,
      fatherName: fatherName,
      motherName: motherName,
      createDate: createDate,
      educationLevel: educationLevel,
      lineNumber: lineNumber
    );
  }
}
