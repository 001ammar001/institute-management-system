import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/features/employees/domain/entites/job_entity.dart';
import 'package:institute_management_system/features/employees/domain/entites/list_entity.dart';
import 'package:institute_management_system/features/employees/domain/usecases/delete_job_usecase.dart';
import 'package:institute_management_system/features/employees/domain/usecases/get_jobs_list_usecase.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';

part "job_title_list_events.dart";

part "job_title_list_states.dart";

class JobTitleListBloc extends Bloc<JobTitleListEvents, JobTitleListStates> {
  final GetJobTitleListUseCase getJobTitleList;
  final DeleteJobTitleUseCase deleteJobTitle;

  int currentPage = 1;
  ListEntity<JobEntity> jobs = ListEntity(maxPage: 1, entitys: []);

  JobTitleListBloc(
      {required this.getJobTitleList, required this.deleteJobTitle})
      : super((JobTitlteListLoadingState())) {
    on<GetJobTitlteEvent>(_getJopsList);
    on<CheckboxEvent>(_checkboxControl);
    on<DeleteJobTitleEvent>(_deleteJob);
  }

  FutureOr<void> _getJopsList(
      GetJobTitlteEvent event, Emitter<JobTitleListStates> emit) async {
    emit(JobTitlteListLoadingState());
    final result = await getJobTitleList(currentPage);
    result.fold((failure) {
      jobs = ListEntity(maxPage: 1, entitys: []);
      emit(JobTitleListFailureState(message: mapFailureToMessage(failure)));
    }, (newJobTitles) {
      jobs = newJobTitles;
      emit(JobTitleListSuccessState());
    });
  }

  FutureOr<void> _checkboxControl(
      CheckboxEvent event, Emitter<JobTitleListStates> emit) async {
    emit(PageChangedState());
  }

  FutureOr<void> _deleteJob(
      DeleteJobTitleEvent event, Emitter<JobTitleListStates> emit) async {
    emit(JobTitlteListLoadingState());
    final result = await deleteJobTitle(event.jobTitleId);
    result.fold(
        (failure) => emit(
              DeleteJobTitleFailureState(message: mapFailureToMessage(failure)),
            ),
        (delete) {});
    add(GetJobTitlteEvent());
  }
}
