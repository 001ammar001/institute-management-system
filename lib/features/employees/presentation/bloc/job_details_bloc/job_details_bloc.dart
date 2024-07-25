import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';
import 'package:institute_management_system/features/employees/domain/entites/job_entity.dart';
import 'package:institute_management_system/features/employees/domain/usecases/get_job_details_usecase.dart';

part 'job_details_event.dart';
part 'job_details_state.dart';

class JobDetailsBloc extends Bloc<JobDetailsEvent, JobDetailsStates> {
  final GetJobDataUseCase getJobData;
  JobDetailsBloc({required this.getJobData}) : super(JobDataLoadingState()) {
    on<GetJobDetailEvent>((event, emit) async {
      emit(JobDataLoadingState());
      final result = await getJobData(event.id);
      result.fold(
        (l) => emit(
          JobDataFailureState(message: mapFailureToMessage(l)),
        ),
        (r) => emit(JobDataLoadedState(job: r)),
      );
    });
  }
}
