import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/functions/response_dialogs.dart';
import '../../../../../core/widgets/table_screen/buttons_pages_row.dart';
import '../../bloc/list/list_rooms_bloc/list_rooms_bloc.dart';
import 'header_list_rooms.dart';
import 'item_builder_room.dart';

class RoomListPageState extends StatelessWidget {
  final Size media;

  const RoomListPageState({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    ListRoomsBloc bloc = BlocProvider.of<ListRoomsBloc>(context);
    return BlocConsumer<ListRoomsBloc, ListRoomsStates>(
        listener: (context, state) {
      if (state is ListRoomsSuccessState) {
        bloc.stateButtonArrowForwardRoom = 0;
        bloc.stateButtonArrowBackRoom = 0 ;
        bloc.stateButtonDeleteRoom=0;
      } else if (state is ListRoomsFailureState) {
        bloc.failureText = state.message;
      }else if (state is DeleteRoomsFailureState) {
        showErrorSnackBar(context, state.message);
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Column(
          children: [
            HeaderListRooms(media: media),
            ItemBuilderRoom(
              bloc: bloc,
              state: state,
              rooms: bloc.rooms,
            ),
            ButtonsPagesRow(
              pageNumber: bloc.currentPage,
              onPresBack: () {
                  if (bloc.stateButtonArrowBackRoom == 0) {
                    if (bloc.currentPage > 1) {
                      bloc.currentPage--;
                      BlocProvider.of<ListRoomsBloc>(context)
                          .add(RoomsEvents(currentPage: bloc.currentPage));
                    }
                    bloc.stateButtonArrowBackRoom++;
                  }
              },
              onPresForward: () {
                if (bloc.stateButtonArrowForwardRoom == 0) {
                  if (bloc.rooms.meta!.currentPage! <
                      bloc.rooms.meta!.lastPage!) {
                    bloc.currentPage++;
                    BlocProvider.of<ListRoomsBloc>(context)
                        .add(RoomsEvents(currentPage: bloc.currentPage));
                  }
                  bloc.stateButtonArrowForwardRoom++;
                }
              },
            ),
          ],
        ),
      );
    });
  }
}
