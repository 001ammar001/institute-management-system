import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';
import 'package:institute_management_system/features/teachers/domain/entites/teacher_entity.dart';
import 'package:institute_management_system/features/teachers/domain/usecases/get_teachers_details.dart';

part 'teacher_details_event.dart';
part 'teacher_details_state.dart';

class TeacherDetailsBloc extends Bloc<TeacherDetailsEvent, TeacherDetailsStates> {
  final GetTeacherDetailsUseCase getTeacherDetail;
  TeacherDetailsBloc({required this.getTeacherDetail})
      : super(TeacherDataLoadingState()) {
    on<GetTeacherDetailEvent>((event, emit) async {
      emit(TeacherDataLoadingState());  
      final result = await getTeacherDetail(event.id);
      result.fold(
        (l) => emit(
          TeacherDataFailureState(message: mapFailureToMessage(l)),
        ),
        (r) => emit(TeacherDataLoadedState(teacher: r)),
      );
    });
  }
}
