import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';
import 'package:institute_management_system/features/accounts/domain/entites/user_entity.dart';
import 'package:institute_management_system/features/accounts/domain/useCases/add_user_usecase.dart';

part 'add_user_event.dart';
part 'add_user_state.dart';

class AddUserBloc extends Bloc<AddUserEvent, AddUserStates> {
  final AddUserUseCase addUserUseCase;
  AddUserBloc({required this.addUserUseCase}) : super(AddUserInitialState()) {
    on<AddUserEvent>((event, emit) async {
      emit(AddUserLoadingState());
      final result = await addUserUseCase(event.user);
      result.fold(
        (l) => emit(
          AddUserFailureState(message: mapFailureToMessage(l)),
        ),
        (r) => emit(AddUserSucessState()),
      );
    });
  }
}
