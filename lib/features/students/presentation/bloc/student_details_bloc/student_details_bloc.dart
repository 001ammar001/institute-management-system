import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';
import 'package:institute_management_system/features/students/domain/entites/student_entity.dart';
import 'package:institute_management_system/features/students/domain/usecases/get_student_details_usecase.dart';

part 'student_details_event.dart';
part 'student_details_state.dart';

class StudentDetailsBloc
    extends Bloc<StudentDetailsEvent, StudentDetailsStates> {
  final GetStudentDetailsUseCase getStudentDetail;
  StudentDetailsBloc({required this.getStudentDetail})
      : super(StudentDataLoadingState()) {
    on<GetStudentDetailEvent>((event, emit) async {
      emit(StudentDataLoadingState());
      final result = await getStudentDetail(event.id);
      result.fold(
        (l) => emit(
          StudentDataFailureState(message: mapFailureToMessage(l)),
        ),
        (r) => emit(StudentDataLoadedState(student: r)),
      );
    });
  }
}
