import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/features/warehouse/domain/entitys/stock_item_entity.dart';
import '../../../../core/widgets/bodies_alert_dialogs/body_delete.dart';
import '../../../../core/widgets/table_screen/icons_options.dart';
import '../../data/models/warehouse_model_list.dart';
import '../bloc/stock_items_list_bloc/list_items_warehouse_bloc.dart';

class ItemBuilderWarehouse extends StatelessWidget {
  const ItemBuilderWarehouse({
    super.key,
    required this.bloc,
    required this.state,
    required this.items,
  });

  final ListItemsWarehouseBloc bloc;
  final ListItemsWarehouseStates state;
  final WareHouseModelList items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 8,
        child: (state is ListItemsWarehouseSuccessState ||
                state is PageChangedItemsWarehouseState)
            ? ListView.builder(
                itemCount: items.data?.length,
                itemBuilder: (context, index) {
                  final StockItemEntity? item = items.data?[index];
                  final isEven = index.isEven;
                  final backgroundColor =
                      isEven ? Colors.grey[200] : Colors.white;
                  const textColor = Colors.black;
                  return Container(
                    color: backgroundColor,
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text('   ${item?.id}',
                                style: const TextStyle(color: textColor))),
                        Expanded(
                            flex: 6,
                            child: Center(
                              child: Text('${item?.name}',
                                  style: const TextStyle(color: textColor)),
                            )),
                        Expanded(
                            flex: 6,
                            child: Center(
                              child: Text('${item?.amount}',
                                  style: const TextStyle(color: textColor)),
                            )),
                        Expanded(
                            flex: 6,
                            child: Center(
                              child: Text(
                                "${item?.source}",
                                style: const TextStyle(color: textColor),
                                textAlign: TextAlign.center,
                              ),
                            )),
                        Expanded(
                          flex: 2,
                          child: IconsRowOptions(
                            item: item,
                            checkBox: (newValue) {
                              BlocProvider.of<ListItemsWarehouseBloc>(context)
                                  .add(CheckboxItemsWarehouseEvent());
                              item?.index = newValue!;
                              if (newValue!) {
                                //Bloc.students.add(value);
                              }
                            },
                            delete: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              alertDialogGeneral(
                                title: "هل أنت متأكد من حذف هذا العنصر",
                                context: context,
                                submitFunction: () {
                                  BlocProvider.of<ListItemsWarehouseBloc>(
                                          context)
                                      .add(DeleteItemsWarehouseEvent(
                                          indexItemsWarehouse: item!.id!));
                                  BlocProvider.of<ListItemsWarehouseBloc>(
                                          context)
                                      .add(ItemsWarehouseEvents(
                                          currentPage: bloc.currentPageItem));
                                },
                              );
                            },
                            edit: () {},
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : state is ListItemsWarehouseFailureState
                ? Center(
                    child: Text(
                      bloc.failureText,
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ));
  }
}
