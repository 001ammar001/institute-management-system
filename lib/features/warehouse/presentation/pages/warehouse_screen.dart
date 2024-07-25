import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/features/warehouse/presentation/pages/add_item_warehouse.dart';
import 'package:institute_management_system/features/warehouse/presentation/pages/in_out_screen.dart';
import '../../../../core/constants.dart';
import '../../../../core/widgets/table_screen/table_list_component.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';
import '../bloc/stock_items_list_bloc/list_items_warehouse_bloc.dart';
import '../widgets/items_pages.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;

TextEditingController valueSearchWarehouse = TextEditingController();

class WareHouseScreen extends StatefulWidget {
  const WareHouseScreen({super.key});

  @override
  State<WareHouseScreen> createState() => _WareHouseScreenState();
}

class _WareHouseScreenState extends State<WareHouseScreen> {
  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    Size media = screenMedia(context);
    return BlocProvider(
      create: (context) => getit.sl<ListItemsWarehouseBloc>()
        ..add(const ItemsWarehouseEvents(currentPage: 1)),
      child: Scaffold(
        body: TableListComponent(
          label: '',
          onSubmit: (){},
          search: valueSearchWarehouse,
          function: () {
            screenStack.popScreen();
            bloc.add(ChangeWidgetEvent());
          },
          buttonsNum: 3,
          media: media,
          widgetButtons: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: MaterialButton(
                      height: 75,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.yellow,
                      onPressed: () {
                        // FocusScope.of(context).requestFocus(FocusNode());
                        // alertDialogFunction(
                        //   alertDialogSelect(context),
                        //   context,
                        //   'تحديد عنصر',
                        // );
                      },
                      child: const Text(
                        "التحديد",
                        style: TextStyle(color: Colors.black87, fontSize: 15),
                      ))),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                  flex: 1,
                  child: MaterialButton(
                      height: 75,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.yellow,
                      onPressed: () {
                        screenStack.pushScreen(
                          screen: const AddItemWarehouse(),
                          title: "إضافة مادة إلى المستودع",
                        );
                        bloc.add(ChangeWidgetEvent());
                      },
                      child: const Text(
                        "إضافة مادة",
                        style: TextStyle(color: Colors.black87, fontSize: 15),
                      ))),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                  flex: 1,
                  child: MaterialButton(
                      height: 75,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.yellow,
                      onPressed: () {
                        screenStack.pushScreen(
                          screen: const InOutPage(),
                          title: "حركة المستودع",
                        );
                        bloc.add(ChangeWidgetEvent());
                      },
                      child: const Text(
                        "إدخال / إخراج",
                        style: TextStyle(color: Colors.black87, fontSize: 15),
                      ))),
            ],
          ),
          widgetPage: WarehouseListPageState(media: media),
        ),
      ),
    );
  }
}
