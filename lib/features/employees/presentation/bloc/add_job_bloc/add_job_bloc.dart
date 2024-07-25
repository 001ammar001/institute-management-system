import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';
import 'package:institute_management_system/features/employees/domain/entites/job_entity.dart';
import 'package:institute_management_system/features/employees/domain/usecases/add_update_job_usecase.dart';

part 'add_job_event.dart';
part 'add_job_state.dart';

class AddJobBloc extends Bloc<AddUpdateJobEvent, AddJobStates> {
  final AddUpdateJobUseCase addUpdateJobUseCase;
  AddJobBloc({required this.addUpdateJobUseCase})
      : super(AddUpdateJobInitialState()) {
    on<AddUpdateJobEvent>((event, emit) async {
      emit(AddUpdateJobLoadingState());
      final result = await addUpdateJobUseCase(event.jobEntity);
      result.fold(
        (l) => emit(
          AddUpdateJobFailureState(message: mapFailureToMessage(l)),
        ),
        (r) => emit(AddUpdateJobSucessState()),
      );
    });
  }
}
