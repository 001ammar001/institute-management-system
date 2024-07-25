import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/Errors/error_message_mapper.dart';
import '../../../../data/models/course_model_list.dart';
import '../../../../data/models/filters_courses_model.dart';
import '../../../../domain/useCases/delete_course_usecase.dart';
import '../../../../domain/useCases/fetch_courses_usecase.dart';

part "list_courses_events.dart";

part "list_courses_states.dart";

int currentPageCourse = 1;
bool getArchivedCourse = false;
String statusCourse = "";
String teacher = "";
String room = "";
String subject = "";
String startAt = "";
String endAt = "";

class ListCoursesBloc extends Bloc<ListCoursesEvents, ListCoursesStates> {
  final FetchCoursesUseCase fetchCoursesUseCase;
  final DeleteCourseUseCase deleteCourseUseCase;
  CourseModelList courses = CourseModelList();

  String failureText = 'error';
  int currentPage = 1;
  int stateButtonArrowForwardCourse = 0;
  int stateButtonArrowBackCourse = 0;
  int stateButtonDeleteCourse = 0;

  ListCoursesBloc(
      {required this.fetchCoursesUseCase, required this.deleteCourseUseCase})
      : super(ListCoursesInitialState()) {
    on<CoursesEvents>(_getCoursesAll);
    on<CheckboxEvent>(_checkboxControl);
    on<DeleteCourseEvent>(_deleteCourse);
    on<FilterCoursesListEvent>(_filterCoursesList);
  }

  FutureOr<void> _getCoursesAll(
      CoursesEvents event, Emitter<ListCoursesStates> emit) async {
    emit(ListCoursesLoadingState());
    final result = await fetchCoursesUseCase.call(
      pageNumber: 1,
      getArchived: false,
      status: '',
      teacher: '',
      room: '',
      subject: '',
      startAt: '',
      endAt: '',
    );
    result.fold(
        (failure) => emit(
              ListCoursesFailureState(message: mapFailureToMessage(failure)),
            ), (listCourse) {
      courses = listCourse;
      emit(ListCoursesSuccessState(listCourse));
    });
  }

  FutureOr<void> _checkboxControl(
      CheckboxEvent event, Emitter<ListCoursesStates> emit) async {
    emit(PageChangedState());
  }

  FutureOr<void> _deleteCourse(
      DeleteCourseEvent event, Emitter<ListCoursesStates> emit) async {
    emit(ListCoursesLoadingState());
    final result = await deleteCourseUseCase.call(event.indexCourse);
    result.fold(
        (failure) => emit(
              DeleteCoursesFailureState(message: mapFailureToMessage(failure)),
            ), (delete) {
      emit(DeleteCoursesSuccessState());
    });
  }

  FutureOr<void> _filterCoursesList(
      FilterCoursesListEvent event, Emitter<ListCoursesStates> emit) async {
    emit(ListCoursesLoadingState());
    print(event.coursesFilter2.pageNumber);
    final result = await fetchCoursesUseCase.call(
      pageNumber: event.coursesFilter2.pageNumber,
      getArchived: event.coursesFilter2.getArchived,
      status: event.coursesFilter2.status,
      teacher: event.coursesFilter2.teacher,
      room: event.coursesFilter2.room,
      subject: event.coursesFilter2.subject,
      startAt: event.coursesFilter2.startAt,
      endAt: event.coursesFilter2.endAt,
    );
    result.fold(
        (failure) => emit(
              ListCoursesFailureState(message: mapFailureToMessage(failure)),
            ), (listCourse) {
      courses = listCourse;
      emit(ListCoursesSuccessState(listCourse));
    });
  }
}
