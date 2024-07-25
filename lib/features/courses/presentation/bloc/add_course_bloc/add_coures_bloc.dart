import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';
import 'package:institute_management_system/features/courses/domain/entites/course_entity.dart';
import 'package:institute_management_system/features/courses/domain/useCases/add_course_usecase.dart';

part 'add_coures_event.dart';
part 'add_coures_state.dart';

class AddCourseBloc extends Bloc<AddUpdateCouresEvent, AddCourseStates> {
  final AddUpdateCourseUseCase addCourseUseCase;
  AddCourseBloc({required this.addCourseUseCase})
      : super(AddUpdateCourseInitialState()) {
    on<AddUpdateCouresEvent>((event, emit) async {
      emit(AddUpdateCourseLoadingState());
      final result = await addCourseUseCase(event.course);
      result.fold(
        (l) => emit(
          AddUpdateCourseFailureState(message: mapFailureToMessage(l)),
        ),
        (r) => emit(AddUpdateCourseSucessState()),
      );
    });
  }
}
