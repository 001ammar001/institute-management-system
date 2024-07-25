import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/Errors/error_message_mapper.dart';
import '../../../data/models/filters_students_model.dart';
import '../../../data/models/student_model_list.dart';
import '../../../domain/usecases/delete_student_usecase.dart';
import '../../../domain/usecases/fetch_students_usecase.dart';
import '../../../domain/usecases/fetch_student_without_pagination.dart';

part "list_students_events.dart";

part "list_students_states.dart";

int currentPageStudent = 1;
bool getArchivedStudent = false;
String arabicNameStudent = "";
String englishNameStudent = "";
String fatherName = "";
String motherName = "";
String createDate = "";
String educationLevel = "";
String lineNumber = "";

class ListStudentsBloc extends Bloc<ListStudentsEvents, ListStudentsStates> {
  final FetchStudentsUseCase fetchStudentsUseCase;
  final FetchStudentsWithoutPaginationUseCase fetchstudentsWithoutPagination;
  final DeleteStudentUseCase deleteStudentUseCase;
  StudentModelList students = StudentModelList();

  String failureText = 'error';

  int stateButtonArrowForwardStudent = 0;
  int stateButtonArrowBackStudent = 0;
  int stateButtonDeleteStudent = 0;

  ListStudentsBloc(
      {required this.fetchstudentsWithoutPagination,
      required this.fetchStudentsUseCase,
      required this.deleteStudentUseCase})
      : super(ListStudentsInitialState()) {
    on<StudentsEvents>(_getStudentsAll);
    on<StudentsRegisterEvents>(_getStudentsRegister);
    on<CheckboxEvent>(_checkboxControl);
    on<DeleteStudentEvent>(_deleteStudent);
    on<FilterStudentsListEvent>(_filterStudentsList);
  }

  FutureOr<void> _getStudentsAll(
      StudentsEvents event, Emitter<ListStudentsStates> emit) async {
    emit(ListStudentsLoadingState());
    final result = await fetchStudentsUseCase.call(
        pageNumber: 1,
        getArchived: false,
        arabicNameStudent: '',
        englishNameStudent: '',
        fatherName: '',
        motherName: '',
        createDate: '',
        educationLevel: '',
        lineNumber: '');
    result.fold(
        (failure) => emit(
              ListStudentsFailureState(message: mapFailureToMessage(failure)),
            ), (listStudent) {
      students = listStudent;
      emit(ListStudentsSuccessState(listStudent));
    });
  }

  FutureOr<void> _getStudentsRegister(
      StudentsRegisterEvents event, Emitter<ListStudentsStates> emit) async {
    emit(ListStudentsLoadingState());
    final result = await fetchStudentsUseCase.call(
        pageNumber: event.currentPage,
        getArchived: false,
        arabicNameStudent:
            (event.nameStudent != null) ? event.nameStudent! : '',
        englishNameStudent: '',
        fatherName: '',
        motherName: '',
        createDate: '',
        educationLevel: '',
        lineNumber: '');
    result.fold(
        (failure) => emit(
              ListStudentsFailureState(message: mapFailureToMessage(failure)),
            ), (listStudent) {
      students = listStudent;
      emit(ListStudentsSuccessState(listStudent));
    });
  }

  FutureOr<void> _getStudentsWithoutPagination(
      StudentEventsWithoutPagination event,
      Emitter<ListStudentsStates> emit) async {
    final result = await fetchstudentsWithoutPagination.call();
    result.fold(
        (failure) => emit(
              ListStudentsPieceFailureState(
                  message: mapFailureToMessage(failure)),
            ), (listStudent) {
      students = listStudent;
      emit(ListStudentsPieceSuccessState(listStudent));
    });
  }

  FutureOr<void> _checkboxControl(
      CheckboxEvent event, Emitter<ListStudentsStates> emit) async {
    emit(PageChangedState());
  }

  FutureOr<void> _deleteStudent(
      DeleteStudentEvent event, Emitter<ListStudentsStates> emit) async {
    emit(ListStudentsLoadingState());
    final result = await deleteStudentUseCase.call(event.indexStudent);
    result.fold(
        (failure) => emit(
              DeleteStudentsFailureState(message: mapFailureToMessage(failure)),
            ), (delete) {
      // students.data!.removeWhere((student) => student.id == event.indexStudent);
      emit(DeleteStudentsSucessState());
    });
  }

  FutureOr<void> _filterStudentsList(
      FilterStudentsListEvent event, Emitter<ListStudentsStates> emit) async {
    emit(ListStudentsLoadingState());
    final result = await fetchStudentsUseCase.call(
        pageNumber: event.studentsFilter2.pageNumber,
        getArchived: event.studentsFilter2.getArchived,
        arabicNameStudent: event.studentsFilter2.arabicNameStudent,
        englishNameStudent: event.studentsFilter2.englishNameStudent,
        fatherName: event.studentsFilter2.fatherName,
        motherName: event.studentsFilter2.motherName,
        createDate: event.studentsFilter2.createDate,
        educationLevel: event.studentsFilter2.educationLevel,
        lineNumber: event.studentsFilter2.lineNumber);
    result.fold(
        (failure) => emit(
              ListStudentsFailureState(message: mapFailureToMessage(failure)),
            ), (listStudent) {
      students = listStudent;
      emit(ListStudentsSuccessState(listStudent));
    });
  }
}
