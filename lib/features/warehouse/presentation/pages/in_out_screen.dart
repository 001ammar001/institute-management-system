import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/constants.dart';
import 'package:institute_management_system/core/functions/response_dialogs.dart';
import 'package:institute_management_system/core/utils/enums.dart';
import 'package:institute_management_system/core/widgets/buttons/custom_segmented_buttons.dart';
import 'package:institute_management_system/core/widgets/text_fields/list_disapled_text_field.dart';
import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';
import 'package:institute_management_system/features/warehouse/domain/entitys/import_export_entity.dart';
import 'package:institute_management_system/features/warehouse/presentation/bloc/import_export_item_bloc/import_export_item_bloc.dart';
import '../../../../core/widgets/buttons/submit_button.dart';
import '../../../../core/widgets/text_fields/enabled_text_field.dart';
import '../../../../core/widgets/title_back_button.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;

class InOutPage extends StatefulWidget {
  const InOutPage({super.key});

  @override
  State<StatefulWidget> createState() => _InOutPage();
}

class _InOutPage extends State<InOutPage> {
  final SearchEntity item = SearchEntity();
  late TextEditingController amountController;
  late GlobalKey<FormState> formKey;
  Set operation = {"I"};

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    item.dispose();
    amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TitleWhitBackButton(
              text: 'إدخال / إخراج',
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
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          _buildOperationButton(),
                        ],
                      ),
                      ListDisapledTextField(
                        label: "اسم المادة",
                        searchEnity: item,
                        searchType: SearchTypeEnum.item,
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
                      BlocProvider(
                        create: (context) => getit.sl<ImportExportItemBloc>(),
                        child: BlocConsumer<ImportExportItemBloc,
                            ImportExportItemStates>(
                          listener: (context, state) {
                            if (state is ImportExportItemSucessState) {
                              setState(() {
                                amountController.clear();
                                operation = {"I"};
                                item.reset();
                              });
                              showSucessSnackBar(context);
                            } else if (state is ImportExportItemFailureState) {
                              showErrorSnackBar(context, state.message);
                            }
                          },
                          builder: (context, state) {
                            return SubmitButton(
                              isLoading: state is ImportExportItemLoadingState,
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  int amount = int.parse(amountController.text);
                                  if (operation.first == "O") amount *= -1;
                                  final entity = ImportExportEntity(
                                    id: item.id,
                                    amount: amount,
                                  );
                                  BlocProvider.of<ImportExportItemBloc>(context)
                                      .add(ImportExportItemEvent(
                                          importExportEntity: entity));
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
      ),
    );
  }

  StatefulBuilder _buildOperationButton() {
    return StatefulBuilder(
      builder: (context, setState) {
        return CustomSegmentedButton(
          label: "العملية:",
          selectedValue: operation,
          onSelectionChanged: (data) {
            setState(() {
              operation = data;
            });
          },
          segments: const [
            ButtonSegment(
              value: "I",
              label: Text(
                "إدخال",
                softWrap: false,
              ),
            ),
            ButtonSegment(
              value: "O",
              label: Text(
                "إخراج",
                softWrap: false,
              ),
            ),
          ],
        );
      },
    );
  }
}
