import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/Errors/error_message_mapper.dart';
import '../../../data/models/activity_model_list.dart';
import '../../../data/models/filters_activities_model.dart';
import '../../../domain/usecases/fetch_activity_usecase.dart';


part "list_activities_events.dart";
part "list_activities_states.dart";

int currentPageActivity = 1;
String userNameActivity = "";
String operationActivity = "";
String modelActivity = "";


class ListActivitiesBloc extends Bloc<ListActivitiesEvents, ListActivitiesStates> {
  final FetchActivitiesUseCase fetchActivitiesUseCase;
  ActivityModelList activities = ActivityModelList();

  String failureText = 'error';
  int currentPage = 1;
  int stateButtonArrowForwardActivity = 0;
  int stateButtonArrowBackActivity = 0;
  int stateButtonDeleteActivity = 0;

  ListActivitiesBloc({required this.fetchActivitiesUseCase,})
      : super(ListActivitiesInitialState()) {
    on<ActivitiesEvents>(_getActivitiesAll);
    on<CheckboxEvent>(_checkboxControl);
    on<FilterActivitiesListEvent>(_filterActivitiesList);
  }

  FutureOr<void> _getActivitiesAll(ActivitiesEvents event,
      Emitter<ListActivitiesStates> emit) async {
    emit(ListActivitiesLoadingState());
    final result = await fetchActivitiesUseCase.call(
            pageNumber: 1,
            userName: '',
            operation: '',
            model: '',
    );
    result.fold(
            (failure) =>
            emit(
              ListActivitiesFailureState(message: mapFailureToMessage(failure)),
            ), (listActivity) {
              activities=listActivity;
      emit(ListActivitiesSuccessState(listActivity));
    });
  }

  FutureOr<void> _checkboxControl(CheckboxEvent event,
      Emitter<ListActivitiesStates> emit) async {
    emit(PageChangedState());
  }

  FutureOr<void> _filterActivitiesList(FilterActivitiesListEvent event,
      Emitter<ListActivitiesStates> emit) async {
    emit(ListActivitiesLoadingState());
    final result = await fetchActivitiesUseCase.call(
      pageNumber: event.activitiesFilter2.pageNumber,
      userName: event.activitiesFilter2.userName,
      operation: event.activitiesFilter2.operation,
      model: event.activitiesFilter2.model,
    );
    result.fold(
            (failure) =>
            emit(
              ListActivitiesFailureState(message: mapFailureToMessage(failure)),
            ), (listActivity) {
      activities=listActivity;
      emit(ListActivitiesSuccessState(listActivity));
    });
  }

}





