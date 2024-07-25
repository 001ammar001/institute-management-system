import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/Errors/error_message_mapper.dart';
import 'package:institute_management_system/features/courses/domain/entites/room_categort_entity.dart';
import 'package:institute_management_system/features/courses/domain/useCases/category/add_update_category_usecase.dart';
import 'package:institute_management_system/features/courses/domain/useCases/room/add_update_room_usecase.dart';

part 'rooms_and_categorys_event.dart';
part 'rooms_and_categorys_state.dart';

class RoomsAndCategorysBloc
    extends Bloc<RoomsAndCategorysEvent, RoomsAndCategorysState> {
  final AddUpdateRoomUseCase addUpdateRoom;
  final AddUpdateCategoryUseCase addUpdateCategory;

  RoomsAndCategorysBloc({
    required this.addUpdateRoom,
    required this.addUpdateCategory,
  }) : super(RoomsAndCategorysInitialState()) {
    on<AddOrUpdateRoomEvent>((event, emit) async {
      emit(RoomsAndCategorysLoadingState());
      final result = await addUpdateRoom(event.room);
      result.fold(
        (l) => emit(
            RoomsAndCategorysFailureState(message: mapFailureToMessage(l))),
        (r) => emit(RoomsAndCategorysSucessState()),
      );
    });
    on<AddOrUpdateCategoryEvent>((event, emit) async {
      emit(RoomsAndCategorysLoadingState());
      final result = await addUpdateCategory(event.category);
      result.fold(
        (l) => emit(
            RoomsAndCategorysFailureState(message: mapFailureToMessage(l))),
        (r) => emit(RoomsAndCategorysSucessState()),
      );
    });
  }
}
