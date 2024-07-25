import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../../core/widgets/table_screen/table_list_buttons_appbar.dart';
import '../../../../../core/widgets/table_screen/table_list_component.dart';
import '../../../../drawer/presentation/bloc/drawer_bloc.dart';
import '../../bloc/list/list_rooms_bloc/list_rooms_bloc.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;

import '../../widgets/room_list_widgets/room_list_pages.dart';
import '../add_room_category_page.dart';

TextEditingController valueSearchRoom = TextEditingController();

class ShowRoomsScreen extends StatelessWidget {
  const ShowRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    Size media = screenMedia(context);
    return BlocProvider(
      create: (context) =>
          getit.sl<ListRoomsBloc>()..add(const RoomsEvents(currentPage: 1)),
      child: Scaffold(
        body: TableListComponent(
          label: '',
          onSubmit: (){},
          search: valueSearchRoom,
          function: () {
            screenStack.popScreen();
            bloc.add(ChangeWidgetEvent());
          },
          buttonsNum: 2,
          media: media,
          widgetButtons: Row(
            children: [
              TableListButtonsAppBar(
                function: () {},
                text: 'الفلاتر',
              ),
              const SizedBox(
                width: 20,
              ),
              TableListButtonsAppBar(
                function: () {
                  screenStack.pushScreen(
                      screen: const AddRoomOrCategoryPage(
                          type: SearchTypeEnum.room),
                      title: "إضافة غرفة");
                  bloc.add(ChangeWidgetEvent());
                },
                text: 'إضافة غرفة',
              ),

            ],
          ),
          widgetPage: RoomListPageState(media: media),
        ),
      ),
    );
  }
}
