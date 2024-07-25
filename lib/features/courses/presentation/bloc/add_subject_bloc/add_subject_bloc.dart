import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';
import 'package:institute_management_system/features/courses/domain/entites/subject_entity.dart';
import 'package:institute_management_system/features/courses/domain/useCases/subject/add_update_subject_usecase.dart';

part 'add_subject_event.dart';
part 'add_subject_state.dart';

class SubjectAddBloc extends Bloc<AddUpdateSubjectEvent, SubjectAddStates> {
  final AddUpdateSubjectUseCase addUpdateSubject;
  SubjectAddBloc({required this.addUpdateSubject})
      : super(SubjectAddInitial()) {
    on<AddUpdateSubjectEvent>((event, emit) async {
      emit(SubjectAddUpdateLoadingState());
      final result = await addUpdateSubject(event.subject);
      result.fold(
        (l) => emit(
          SubjectAddUpdateFailureState(message: mapFailureToMessage(l)),
        ),
        (r) => emit(SubjectAddUpdateSucessState()),
      );
    });
  }
}
