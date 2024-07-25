import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';
import 'package:institute_management_system/features/courses/domain/entites/course_entity.dart';
import 'package:institute_management_system/features/courses/domain/useCases/get_course_details_usecase.dart';

part 'course_details_event.dart';
part 'course_details_state.dart';

class CourseDetailsBloc extends Bloc<CourseDetailsEvent, CourseDetailsStates> {
  final GetCourseDetailsUseCase getCourseDetails;
  CourseDetailsBloc({required this.getCourseDetails})
      : super(CouresDataLoadingState()) {
    on<GetCourseDetailEvent>((event, emit) async {
      emit(CouresDataLoadingState());
      final result = await getCourseDetails(event.id);
      result.fold(
        (l) => emit(
          CouresDataFailureState(message: mapFailureToMessage(l)),
        ),
        (r) => emit(CouresDataLoadedState(course: r)),
      );
    });
  }
}
