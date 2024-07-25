import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';
import 'package:institute_management_system/features/students/domain/entites/student_entity.dart';
import 'package:institute_management_system/features/students/domain/usecases/add_update_student_usecase.dart';

part 'add_student_event.dart';
part 'add_student_state.dart';

class AddStudentBloc extends Bloc<AddUpdateStudentEvent, AddStudentStates> {
  final AddUpdateStudentUseCase addUpdateStudent;
  AddStudentBloc({required this.addUpdateStudent})
      : super(AddStudentInitial()) {
    on<AddUpdateStudentEvent>((event, emit) async {
      emit(StudentAddUpdateLoadingState());
      final result = await addUpdateStudent(event.student);
      result.fold(
        (l) => emit(
          StudentAddUpdateFailureState(message: mapFailureToMessage(l)),
        ),
        (r) => emit(StudentAddUpdateSucessState()),
      );
    });
  }
}
