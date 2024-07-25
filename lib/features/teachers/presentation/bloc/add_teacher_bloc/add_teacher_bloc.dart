import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';
import 'package:institute_management_system/features/teachers/domain/entites/teacher_entity.dart';
import 'package:institute_management_system/features/teachers/domain/usecases/add_update_teacher_usecase.dart';

part 'add_teacher_event.dart';
part 'add_teacher_state.dart';

class AddTeacherBloc extends Bloc<AddUpdateTeacherEvent, AddTeacherStates> {
  final AddUpdateTeacherUseCase addUpdateTeacher;
  AddTeacherBloc({required this.addUpdateTeacher})
      : super(AddTeacherInitial()) {
    on<AddUpdateTeacherEvent>((event, emit) async {
      emit(TeacherAddUpdateLoadingState());
      final result = await addUpdateTeacher(event.teacher);
      result.fold(
        (l) => emit(
          TeacherAddUpdateFailureState(message: mapFailureToMessage(l)),
        ),
        (r) => emit(TeacherAddUpdateSucessState()),
      );
    });
  }
}
