import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/features/courses/domain/entites/subject_entity.dart';
import 'package:institute_management_system/features/courses/domain/useCases/subject/delete_subjects_usecase.dart';
import 'package:institute_management_system/features/courses/domain/useCases/subject/get_subjects_usecase.dart';
import 'package:institute_management_system/features/employees/domain/entites/list_entity.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';

part "subjects_list_events.dart";

part "subjects_list_states.dart";

class SubjectsListBloc extends Bloc<SubjectListEvents, SubjectsListStates> {
  final GetSubjectsUseCase getSubjectsUseCase;
  final DeleteSubjectUseCase deleteSubjectUseCase;

  int currentPage = 1;
  ListEntity<SubjectEntity> subjects = ListEntity(maxPage: 1, entitys: []);

  SubjectsListBloc(
      {required this.getSubjectsUseCase, required this.deleteSubjectUseCase})
      : super((SubjectsListLoadingState())) {
    on<GetSubjectsEvent>(_getJopsList);
    on<CheckboxEvent>(_checkboxControl);
    on<DeleteSubjectEvent>(_deleteJob);
  }

  FutureOr<void> _getJopsList(
      GetSubjectsEvent event, Emitter<SubjectsListStates> emit) async {
    emit(SubjectsListLoadingState());
    final result = await getSubjectsUseCase(currentPage);
    result.fold((failure) {
      subjects = ListEntity(maxPage: 1, entitys: []);
      emit(SubjectsListFailureState(message: mapFailureToMessage(failure)));
    }, (newJobTitles) {
      subjects = newJobTitles;
      emit(SubjectsListSuccessState());
    });
  }

  FutureOr<void> _checkboxControl(
      CheckboxEvent event, Emitter<SubjectsListStates> emit) async {
    emit(PageChangedState());
  }

  FutureOr<void> _deleteJob(
      DeleteSubjectEvent event, Emitter<SubjectsListStates> emit) async {
    emit(SubjectsListLoadingState());
    final result = await deleteSubjectUseCase(event.subjectId);
    result.fold(
        (failure) => emit(
              DeleteSubjectFailureState(message: mapFailureToMessage(failure)),
            ),
        (delete) {});
    add(GetSubjectsEvent());
  }
}
