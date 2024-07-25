import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/constants.dart';
import 'package:institute_management_system/core/functions/response_dialogs.dart';
import 'package:institute_management_system/features/warehouse/domain/entitys/stock_item_entity.dart';
import 'package:institute_management_system/features/warehouse/presentation/bloc/add_update_stock_item_bloc/add_update_stock_item_bloc.dart';
import '../../../../core/widgets/buttons/submit_button.dart';
import '../../../../core/widgets/text_fields/enabled_text_field.dart';
import '../../../../core/widgets/title_back_button.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;

class AddItemWarehouse extends StatefulWidget {
  final StockItemEntity? stockItemEntity;
  const AddItemWarehouse({super.key, this.stockItemEntity});

  @override
  State<StatefulWidget> createState() => _AddItemWarehouse();
}

class _AddItemWarehouse extends State<AddItemWarehouse> {
  late TextEditingController itemNameController;
  late TextEditingController sourceController;
  late TextEditingController amountController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  @override
  void dispose() {
    super.dispose();
    _disposeControllers();
  }

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TitleWhitBackButton(
            text: widget.stockItemEntity != null
                ? 'تعديل عنصر مستودع'
                : 'إضافة عنصر إلى المستودع',
            function: () {
              screenStack.popScreen();
              bloc.add(ChangeWidgetEvent());
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 200, right: 200, bottom: 40, top: 20),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    EnabledTextField(
                      label: "اسم المادة",
                      controller: itemNameController,
                    ),
                    EnabledTextField(
                      label: "الكمية",
                      controller: amountController,
                      validator: (value) {
                        if (value != null &&
                            value.isNotEmpty &&
                            int.tryParse(value) != null &&
                            int.parse(value) != 0) {
                          return null;
                        }
                        return "يجب على الكمية ان تكون رقما صحيحا لا يساوي الصفر";
                      },
                    ),
                    EnabledTextField(
                      label: "المصدر",
                      controller: sourceController,
                    ),
                    BlocProvider(
                      create: (context) => getit.sl<AddStockItemBloc>(),
                      child: BlocConsumer<AddStockItemBloc,
                          AddUpdateStockItemStates>(
                        listener: (context, state) {
                          if (state is StockItemAddUpdateSucessState) {
                            if (widget.stockItemEntity == null) {
                              formKey.currentState!.reset();
                            }
                            showSucessSnackBar(context);
                          } else if (state is StockItemAddUpdateFailureState) {
                            showErrorSnackBar(context, state.message);
                          }
                        },
                        builder: (context, state) {
                          return SubmitButton(
                            isLoading: state is StockItemAddUpdateLoadingState,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                final entity = StockItemEntity(
                                  id: widget.stockItemEntity?.id,
                                  name: itemNameController.text,
                                  source: sourceController.text,
                                  amount: int.parse(amountController.text),
                                );
                                BlocProvider.of<AddStockItemBloc>(context).add(
                                    AddUpdateStockItemEvent(stockItem: entity));
                              }
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _initControllers() {
    itemNameController =
        TextEditingController(text: widget.stockItemEntity?.name);
    sourceController =
        TextEditingController(text: widget.stockItemEntity?.source);
    amountController =
        TextEditingController(text: widget.stockItemEntity?.amount.toString());
    formKey = GlobalKey<FormState>();
  }

  void _disposeControllers() {
    itemNameController.dispose();
    sourceController.dispose();
    amountController.dispose();
  }
}
