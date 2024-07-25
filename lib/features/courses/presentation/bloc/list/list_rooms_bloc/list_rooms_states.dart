part of "list_rooms_bloc.dart";

abstract class ListRoomsStates  {}

class ListRoomsInitialState extends ListRoomsStates {}

class PageChangedState extends ListRoomsStates {}

class DeleteRoomState extends ListRoomsStates {}

class ChangeCounterState extends ListRoomsStates {}

final class ListRoomsSuccessState extends ListRoomsStates {
  final RoomCategoryModelList rooms;
  ListRoomsSuccessState(this.rooms);
}

final class ListRoomsLoadingState extends ListRoomsStates {}

class ListRoomsFailureState extends ListRoomsStates {
  final String message;

  ListRoomsFailureState({required this.message});
}

class DeleteRoomsFailureState extends ListRoomsStates {
  final String message;

  DeleteRoomsFailureState({required this.message});
}

class DeleteRoomsSuccessState extends ListRoomsStates {}
