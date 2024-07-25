part of 'rooms_and_categorys_bloc.dart';

sealed class RoomsAndCategorysEvent extends Equatable {
  const RoomsAndCategorysEvent();

  @override
  List<Object> get props => [];
}

class AddOrUpdateRoomEvent extends RoomsAndCategorysEvent {
  final RoomOrCategoryEntity room;

  const AddOrUpdateRoomEvent({required this.room});
}

class AddOrUpdateCategoryEvent extends RoomsAndCategorysEvent {
  final RoomOrCategoryEntity category;

  const AddOrUpdateCategoryEvent({required this.category});
}
