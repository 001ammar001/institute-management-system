part of "list_rooms_bloc.dart";

abstract class ListRoomsEvents extends Equatable {
  const ListRoomsEvents();

  @override
  List<Object?> get props => [];
}

class RoomsEvents extends ListRoomsEvents {
  final int currentPage;
  const RoomsEvents({required this.currentPage});
  @override
  List<Object?> get props => [currentPage];
}

class NextPageEvent extends ListRoomsEvents {}

class PreviousPageEvent extends ListRoomsEvents {}

class CheckboxEvent extends ListRoomsEvents {}

class DeleteRoomEvent extends ListRoomsEvents {
  final int indexRoom;
  const DeleteRoomEvent({required this.indexRoom});
  @override
  List<Object?> get props => [indexRoom];
}

class ControlRoomsPageEvent extends ListRoomsEvents {}
