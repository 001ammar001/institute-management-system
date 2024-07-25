import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';
import 'package:institute_management_system/features/students/data/models/student_course_model.dart';
import 'package:institute_management_system/features/students/domain/usecases/get_student_courses_use_case.dart';

part 'student_course_event.dart';
part 'student_course_state.dart';

class StudentCourseBloc extends Bloc<StudentCourseEvent, StudentCourseState> {
  final GetStudentCourseUseCase studentCourseUseCase;
  StudentCourseBloc({required this.studentCourseUseCase})
      : super(StudentCourseInitial()) {
    on<GetStudentCourse>(getStudentCourse);
  }
  FutureOr<void> getStudentCourse(
      GetStudentCourse event, Emitter<StudentCourseState> emit) async {
    final result = await studentCourseUseCase.call(id: event.id);
    result.fold((l) => emit(StudentCourseFailure(mapFailureToMessage(l))),
        (studentcourses) => emit(StudentCourseSuccess(studentcourses)));
  }
}
