import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/functions/response_dialogs.dart';
import '../../../../core/widgets/table_screen/buttons_pages_row.dart';
import '../bloc/stock_items_list_bloc/list_items_warehouse_bloc.dart';
import 'header_list_warehouse.dart';
import 'item_builder_warehouse.dart';

class WarehouseListPageState extends StatelessWidget {
  final Size media;

  const WarehouseListPageState({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    ListItemsWarehouseBloc bloc =
        BlocProvider.of<ListItemsWarehouseBloc>(context);
    return BlocConsumer<ListItemsWarehouseBloc, ListItemsWarehouseStates>(
        listener: (context, state) {
      if (state is ListItemsWarehouseSuccessState) {
        bloc.stateButtonArrowForwardItems = 0;
        bloc.stateButtonArrowBackItems = 0;
        bloc.stateButtonDeleteItem = 0;
      } else if (state is ListItemsWarehouseFailureState) {
        bloc.failureText = state.message;
      } else if (state is DeleteItemsWarehouseFailureState) {
        showErrorSnackBar(context, state.message);
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Column(
          children: [
            HeaderListWarehouse(
              media: media,
            ),
            ItemBuilderWarehouse(
              bloc: bloc,
              state: state,
              items: bloc.items,
            ),
            ButtonsPagesRow(
              pageNumber: bloc.currentPageItem,
              onPresBack: () {
                if (bloc.stateButtonArrowBackItems == 0) {
                  if (bloc.currentPageItem > 1) {
                    bloc.currentPageItem--;
                    bloc.add(ItemsWarehouseEvents(
                        currentPage: bloc.currentPageItem));
                  }
                  bloc.stateButtonArrowBackItems++;
                }
              },
              onPresForward: () {
                if (bloc.stateButtonArrowForwardItems == 0) {
                  if (bloc.items.meta!.currentPage! <
                      bloc.items.meta!.lastPage!) {
                    bloc.currentPageItem++;
                    bloc.add(ItemsWarehouseEvents(
                        currentPage: bloc.currentPageItem));
                  }
                  bloc.stateButtonArrowForwardItems++;
                }
              },
            ),
          ],
        ),
      );
    });
  }
}
