import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';
import 'package:institute_management_system/features/accounts/domain/entites/role_entity.dart';
import 'package:institute_management_system/features/accounts/domain/useCases/add_update_role_usecase.dart';

part 'add_role_event.dart';
part 'add_role_state.dart';

class AddRoleBloc extends Bloc<AddUpdateRoleEvent, AddRoleStates> {
  final AddUpdateRoleUseCase addUpdateRoleUseCase;
  AddRoleBloc({required this.addUpdateRoleUseCase})
      : super(AddUpdateRoleInitialState()) {
    on<AddUpdateRoleEvent>((event, emit) async {
      emit(AddUpdateRoleLoadingState());
      final result = await addUpdateRoleUseCase(event.role);
      result.fold(
        (l) => emit(
          AddUpdateRoleFailureState(message: mapFailureToMessage(l)),
        ),
        (r) => emit(AddUpdateRoleSucessState()),
      );
    });
  }
}
