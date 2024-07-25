import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';
import 'package:institute_management_system/features/courses/data/models/enrollment_model.dart';
import 'package:institute_management_system/features/courses/domain/useCases/new_enrollment_use_case.dart';

part 'enrollment_event.dart';
part 'enrollment_state.dart';

class EnrollmentBloc extends Bloc<EnrollmentEvent, EnrollmentState> {
  final NewEnrollmentUseCase newEnrollmentUseCase;
  EnrollmentBloc({required this.newEnrollmentUseCase})
      : super(EnrollmentInitial()) {
    on<AddEnrollment>((event, emit) async {
      emit(AddingEnrollmentLoading());
      var result = await newEnrollmentUseCase(event.enrollmentModel);
      print(event.enrollmentModel.courseId);
      print(event.enrollmentModel.studentId);
      print(event.enrollmentModel.initialPayment);
      print(event.enrollmentModel.withCertificate);
      result.fold(
          (l) => emit(AddingEnrollmentFailure(message: mapFailureToMessage(l))),
          (r) => emit(AddingEnrollmentSucess()));
    });
  }
}
