import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/Errors/error_message_mapper.dart';
import '../../../data/models/filters_teachers_model.dart';
import '../../../data/models/teacher_model_list.dart';
import '../../../domain/usecases/delete_teacher_usecase.dart';
import '../../../domain/usecases/fetch_teachers_usecase.dart';

part "list_teachers_events.dart";

part "list_teachers_states.dart";


int currentPageTeacher = 1;
bool getArchivedTeacher = false;
String nameTeacher = "";
String phoneNumberTeacher = "";


class ListTeachersBloc extends Bloc<ListTeachersEvents, ListTeachersStates> {
  final FetchTeachersUseCase fetchTeachersUseCase;
  final DeleteTeacherUseCase deleteTeacherUseCase;
  TeacherModelList teachers = TeacherModelList();

  String failureText = 'error';
  int currentPage = 1;
  int stateButtonArrowForwardTeacher = 0;
  int stateButtonArrowBackTeacher = 0;
  int stateButtonDeleteTeacher = 0;

  ListTeachersBloc(
      {required this.fetchTeachersUseCase, required this.deleteTeacherUseCase})
      : super(ListTeachersInitialState()) {
    on<TeachersEvents>(_getTeachersAll);
    on<CheckboxEvent>(_checkboxControl);
    on<DeleteTeacherEvent>(_deleteTeacher);
    on<FilterTeachersListEvent>(_filterTeachersList);
  }

  FutureOr<void> _getTeachersAll(
      TeachersEvents event, Emitter<ListTeachersStates> emit) async {
    emit(ListTeachersLoadingState());
    final result =
        await fetchTeachersUseCase.call(
          pageNumber: 1,
          getArchived: false,
          name: '',
          phoneNumber: '',
        );
    result.fold(
        (failure) => emit(
              ListTeachersFailureState(message: mapFailureToMessage(failure)),
            ), (listTeacher) {
      teachers = listTeacher;
      emit(ListTeachersSuccessState(listTeacher));
    });
  }

  FutureOr<void> _checkboxControl(
      CheckboxEvent event, Emitter<ListTeachersStates> emit) async {
    emit(PageChangedState());
  }

  FutureOr<void> _deleteTeacher(
      DeleteTeacherEvent event, Emitter<ListTeachersStates> emit) async {
    emit(ListTeachersLoadingState());
    final result = await deleteTeacherUseCase.call(event.indexTeacher);
    result.fold(
        (failure) => emit(
              DeleteTeachersFailureState(message: mapFailureToMessage(failure)),
            ), (delete) {
      // teachers.data!.removeWhere((teacher) => teacher.id == event.indexTeacher);
      emit(DeleteTeachersSuccessState());
    });
  }

  FutureOr<void> _filterTeachersList(
      FilterTeachersListEvent event, Emitter<ListTeachersStates> emit) async {
    emit(ListTeachersLoadingState());
    final result =
    await fetchTeachersUseCase.call(
      pageNumber: currentPageTeacher,
      getArchived: getArchivedTeacher,
      name: nameTeacher,
      phoneNumber: phoneNumberTeacher
    );
    result.fold(
            (failure) => emit(
          ListTeachersFailureState(message: mapFailureToMessage(failure)),
        ), (listTeacher) {
      teachers = listTeacher;
      emit(ListTeachersSuccessState(listTeacher));
    });

  }

}
