import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/features/drawer/presentation/bloc/drawer_bloc.dart';
import '../../../../../core/widgets/bodies_alert_dialogs/body_delete.dart';
import '../../../../../core/widgets/table_screen/icons_options.dart';
import '../../../data/models/room_category_model.dart';
import '../../../data/models/room_category_model_list.dart';
import '../../bloc/list/list_rooms_bloc/list_rooms_bloc.dart';

class ItemBuilderRoom extends StatelessWidget {
  const ItemBuilderRoom({
    super.key,
    required this.bloc,
    required this.state,
    required this.rooms,
  });

  final ListRoomsBloc bloc;
  final ListRoomsStates state;
  final RoomCategoryModelList rooms;

  @override
  Widget build(BuildContext context) {
    DrawerBloc drawerBloc = BlocProvider.of<DrawerBloc>(context);
    return Expanded(
        flex: 8,
        child: (state is ListRoomsSuccessState || state is PageChangedState)
            ? ListView.builder(
                itemCount: rooms.data?.length,
                itemBuilder: (context, index) {
                  final RoomOrCategoryModel? room = rooms.data?[index];
                  final isEven = index.isEven;
                  final backgroundColor =
                      isEven ? Colors.grey[200] : Colors.white;
                  const textColor = Colors.black;
                  return MaterialButton(
                    padding: const EdgeInsets.all(1),
                    onPressed: () { },
                    child: Container(
                      color: backgroundColor,
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text('   ${room?.id}',
                                  style: const TextStyle(color: textColor))),
                          Expanded(
                              flex: 12,
                              child: Center(
                                child: Text('${room?.name}',
                                    style: const TextStyle(color: textColor)),
                              )),

                          Expanded(
                            flex: 2,
                            child: IconsRowOptions(
                              item: room,
                              checkBox: (newValue) {
                                BlocProvider.of<ListRoomsBloc>(context)
                                    .add(CheckboxEvent());
                                room?.index = newValue!;
                                if (newValue!) {
                                  //Bloc.rooms.add(value);
                                }
                              },
                              delete: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                alertDialogGeneral(
                                  title: "هل أنت متأكد من حذف هذا العنصر",
                                  context: context,
                                  submitFunction: () {
                                    BlocProvider.of<ListRoomsBloc>(context)
                                        .add(DeleteRoomEvent(
                                            indexRoom: room!.id!));
                                    BlocProvider.of<ListRoomsBloc>(context)
                                        .add(RoomsEvents(
                                            currentPage: bloc.currentPage));
                                  },
                                );
                              },
                              edit: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
            : state is ListRoomsFailureState
                ? Center(
                    child: Text(
                      bloc.failureText,
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                :   const Center( child: CircularProgressIndicator(),  ));
  }
}
