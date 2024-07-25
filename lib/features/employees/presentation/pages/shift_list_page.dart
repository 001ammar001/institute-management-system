import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/features/employees/presentation/bloc/shifts_list_bloc/shits_list_bloc.dart';
import 'package:institute_management_system/features/employees/presentation/pages/add_shift_page.dart';
import 'package:institute_management_system/features/employees/presentation/widgets/shift_list_widgets/shift_list_body.dart';
import '../../../../core/constants.dart';
import '../../../../core/widgets/table_screen/table_list_buttons_appbar.dart';
import '../../../../core/widgets/table_screen/table_list_component.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;

//TODO: we still nead to add search;
TextEditingController valueSearchShift = TextEditingController();

class ShiftListPage extends StatelessWidget {
  const ShiftListPage({super.key});

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    Size media = screenMedia(context);
    return BlocProvider(
      create: (context) => getit.sl<ShiftListBloc>()..add(GetShiftsEvent()),
      child: TableListComponent(
        label: '',
        onSubmit: (){},
        search: valueSearchShift,
        function: () {
          screenStack.popScreen();
          bloc.add(ChangeWidgetEvent());
        },
        buttonsNum: 1,
        media: media,
        widgetButtons: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            TableListButtonsAppBar(
              text: 'إضافة وردية',
              function: () {
                screenStack.pushScreen(
                    screen: const AddShiftPage(), title: "إضافة وردية");
                bloc.add(ChangeWidgetEvent());
              },
            )
          ],
        ),
        widgetPage: ShiftListBody(media: media),
      ),
    );
  }
}
