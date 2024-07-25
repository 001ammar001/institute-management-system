import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/Errors/error_message_mapper.dart';
import '../../../../data/models/room_category_model_list.dart';
import '../../../../domain/useCases/room/delete_room_usecase.dart';
import '../../../../domain/useCases/room/fetch_rooms_usecase.dart';


part "list_rooms_events.dart";

part "list_rooms_states.dart";

class ListRoomsBloc extends Bloc<ListRoomsEvents, ListRoomsStates> {
  final FetchRoomsUseCase fetchRoomsUseCase;
  final DeleteRoomUseCase deleteRoomUseCase;
  RoomCategoryModelList rooms = RoomCategoryModelList();

  String failureText = 'error';
  int currentPage = 1;
  int stateButtonArrowForwardRoom = 0;
  int stateButtonArrowBackRoom = 0;
  int stateButtonDeleteRoom = 0;

  ListRoomsBloc(
      {required this.fetchRoomsUseCase, required this.deleteRoomUseCase})
      : super(ListRoomsInitialState()) {
    on<RoomsEvents>(_getRoomsAll);
    on<CheckboxEvent>(_checkboxControl);
    on<DeleteRoomEvent>(_deleteRoom);
  }

  FutureOr<void> _getRoomsAll(
      RoomsEvents event, Emitter<ListRoomsStates> emit) async {
    emit(ListRoomsLoadingState());
    final result =
        await fetchRoomsUseCase.call(pageNumber: event.currentPage);
    result.fold(
        (failure) => emit(
              ListRoomsFailureState(message: mapFailureToMessage(failure)),
            ), (listRoom) {
      rooms = listRoom;
      emit(ListRoomsSuccessState(listRoom));
    });
  }

  FutureOr<void> _checkboxControl(
      CheckboxEvent event, Emitter<ListRoomsStates> emit) async {
    emit(PageChangedState());
  }

  FutureOr<void> _deleteRoom(
      DeleteRoomEvent event, Emitter<ListRoomsStates> emit) async {
    emit(ListRoomsLoadingState());
    final result = await deleteRoomUseCase.call(event.indexRoom);
    result.fold(
        (failure) => emit(
              DeleteRoomsFailureState(message: mapFailureToMessage(failure)),
            ), (delete) {
      emit(DeleteRoomsSuccessState());
    });
  }
}
