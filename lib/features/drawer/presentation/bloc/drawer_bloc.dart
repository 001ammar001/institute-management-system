import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants.dart';
import '../../../activities/data/models/filters_activities_model.dart';
import '../../../courses/data/models/filters_courses_model.dart';
import '../../../students/data/models/filters_students_model.dart';
import '../../../teachers/data/models/filters_teachers_model.dart';

part "drawer_events.dart";

part "drawer_states.dart";

class DrawerBloc extends Bloc<DrawerEvents, DrawerState> {
  late bool statusSaveData = false;

  DrawerBloc()
      : super(DrawerState(
          page: screenStack.currentScreen,
          text: screenStack.currentTitle,
        )) {
    on<ChangeWidgetEvent>((event, emit) {
      emit(DrawerState(
        page: screenStack.currentScreen,
        text: screenStack.currentTitle,
      ));
    });
  }

  FiltersStudentModel studentsFilter = FiltersStudentModel(
      pageNumber: 1,
      arabicNameStudent: '',
      englishNameStudent: '',
      fatherName: '',
      motherName: '',
      createDate: '',
      educationLevel: '',
      lineNumber: '',
      getArchived: false);
  FiltersCourseModel coursesFilter = FiltersCourseModel(
    pageNumber: 1,
    getArchived: false,
    status: '',
    teacher: '',
    room: '',
    subject: '',
    startAt: '',
    endAt: '',
  );
  FiltersActivityModel activitiesFilter = FiltersActivityModel(
    pageNumber: 1,
    userName: '',
    operation: '',
    model: '',
  );
  FiltersTeacherModel teachersFilter = FiltersTeacherModel(
    pageNumber: 1,
    getArchived: false,
    name: '',
    phoneNumber: '',
  );
}
