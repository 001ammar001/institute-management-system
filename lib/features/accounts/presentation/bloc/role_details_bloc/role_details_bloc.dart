import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';
import 'package:institute_management_system/features/accounts/domain/entites/permission_entity.dart';
import 'package:institute_management_system/features/accounts/domain/entites/role_entity.dart';
import 'package:institute_management_system/features/accounts/domain/useCases/get_permissions_usecase.dart';
import 'package:institute_management_system/features/accounts/domain/useCases/get_role_details_usecase.dart';

part 'role_details_event.dart';
part 'role_details_state.dart';

class RoleDetailsBloc extends Bloc<RoleDetailsEvent, RoleDetailsState> {
  final GetRoleDetailsUseCase getRoleDetails;
  final GetPermissionsUseCase getPermissions;

  RoleDetailsBloc({
    required this.getRoleDetails,
    required this.getPermissions,
  }) : super(RoleDetailsState()) {
    on<GetRoleDetailEvent>((event, emit) async {
      final result = await getRoleDetails(event.id);
      result.fold(
        (l) => emit(
          RoleDetailsState(
            status: RoleStatus.failure,
            message: mapFailureToMessage(l),
          ),
        ),
        (r) {
          emit(state.copyWith(role_: r, status_: RoleStatus.loaded));
        },
      );
    });

    on<GetPermissionsEvent>((event, emit) async {
      emit(RoleDetailsState());
      final result = await getPermissions();

      result.fold(
        (l) {
          emit(RoleDetailsState(
            status: RoleStatus.failure,
            message: mapFailureToMessage(l),
          ));
        },
        (r) {
          if (event.id != null) {
            emit(RoleDetailsState(permissions: r));
            add(GetRoleDetailEvent(id: event.id!));
          } else {
            emit(RoleDetailsState(
                role: RoleEntity(), permissions: r, status: RoleStatus.loaded));
          }
        },
      );
    });

    on<RoleFormResetEvent>((event, emit) async {
      emit(state.copyWith(role_: RoleEntity()));
    });
  }
}
