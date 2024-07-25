import 'package:flutter/material.dart';
import 'package:institute_management_system/core/utils/enums.dart';
import 'package:institute_management_system/core/widgets/buttons/ckeck_close_button.dart';
import 'package:institute_management_system/core/widgets/buttons/submit_button.dart';
import 'package:institute_management_system/core/widgets/text_fields/enabled_text_field.dart';
import 'package:institute_management_system/core/widgets/text_fields/list_disapled_text_field.dart';
import 'package:institute_management_system/features/courses/domain/entites/procurement_item.dart';
import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';

class ProcurementListDialog extends StatefulWidget {
  final List<ProcurementItemEntity> procurementItems;
  const ProcurementListDialog({
    super.key,
    required this.procurementItems,
  });

  @override
  State<ProcurementListDialog> createState() => ProcurementListDialogState();
}

class ProcurementListDialogState extends State<ProcurementListDialog> {
  final List<SearchEntity> items = [];
  final List<TextEditingController> quantitys = [];
  final List<bool> forStudent = [];

  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    if (widget.procurementItems.isNotEmpty) {
      for (var element in widget.procurementItems) {
        items.add(element.item);
        quantitys.add(TextEditingController(text: element.quantity.toString()));
        forStudent.add(element.forStudent);
      }
    } else {
      items.add(SearchEntity());
      quantitys.add(TextEditingController());
      forStudent.add(false);
    }
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    for (var controller in quantitys) {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Form(
                key: formKey,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) => buildProcurementItem(index),
                ),
              ),
            ),
            Row(
              children: [
                SubmitButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      List<ProcurementItemEntity> procurementEnteties = [];
                      for (var i = 0; i < items.length; i++) {
                        procurementEnteties.add(ProcurementItemEntity(
                          item: items[i],
                          forStudent: forStudent[i],
                          quantity: int.parse(quantitys[i].text),
                        ));
                      }
                      Navigator.pop(context, procurementEnteties);
                    }
                  },
                ),
                const Spacer(),
                SizedBox(
                  height: 40,
                  width: MediaQuery.sizeOf(context).width * .175,
                  child: MaterialButton(
                    color: Colors.yellow,
                    onPressed: () {
                      setState(() {
                        items.add(SearchEntity());
                        quantitys.add(TextEditingController());
                        forStudent.add(false);
                      });
                    },
                    child: const Text("إضافة مادة جديدة"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Padding buildProcurementItem(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (items.length > 1) {
                setState(() {
                  items.removeAt(index);
                  quantitys.removeAt(index);
                  forStudent.removeAt(index);
                });
              }
            },
            style: IconButton.styleFrom(
              iconSize: 30,
            ),
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 5,
            child: ListDisapledTextField(
              label: "المادة${index + 1}",
              searchType: SearchTypeEnum.category,
              searchEnity: items[index],
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 3,
            child: EnabledTextField(
              controller: quantitys[index],
              label: "الكمية",
            ),
          ),
          const Spacer(),
          const Text(
            "لكل طالب",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 20),
          StatefulBuilder(
            builder: (context, setState) {
              return CrossCheckButton(
                value: forStudent[index],
                onChanged: (value) {
                  setState(
                    () {
                      forStudent[index] = value;
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
