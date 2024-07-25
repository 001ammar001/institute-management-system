import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';
import 'package:institute_management_system/features/accounts/domain/entites/user_entity.dart';
import 'package:institute_management_system/features/accounts/domain/useCases/user_details_usecase.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final UserDetailsUseCase userDetailsUseCase;
  UserDetailsBloc({required this.userDetailsUseCase})
      : super(UserDetailsInitial()) {
    on<GetUserDetailsEvent>((event, emit) async {
      emit(UserDetailsLoadingState());
      final result = await userDetailsUseCase(event.id);
      result.fold(
          (failure) => {
                emit(UserDetailFailureState(
                    message: mapFailureToMessage(failure)))
              },
          (userinfo) =>
              {emit(UserDetailsLoadedState(userDetailsEntity: userinfo))});
    });
  }
}
