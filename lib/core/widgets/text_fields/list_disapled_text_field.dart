import 'package:flutter/material.dart';
import 'package:institute_management_system/core/functions/show_dialogs_and_assign_value.dart';
import 'package:institute_management_system/core/utils/enums.dart';
import 'package:institute_management_system/core/widgets/errors/validation_error.dart';
import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';

void add2(){}
class ListDisapledTextField extends StatelessWidget {
  const ListDisapledTextField({
    super.key,
    required this.label,
    required this.searchType,
    required this.searchEnity,
    this.required = true,  this.add=add2,
  });

  final bool required;
  final String label;
  final SearchTypeEnum searchType;
  final SearchEntity searchEnity;
  final Function add;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (value) {
        if (searchEnity.name.isEmpty && required) {
          return "هذا الحقل مطلوب";
        }
        return null;
      },
      builder: (formFieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$label:"),
            Stack(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  height: 56,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: BorderSide(
                          color: formFieldState.hasError
                              ? Colors.red
                              : Colors.grey.shade600,
                        ),
                      ),
                    ),
                    onPressed: () {
                      listSearchTab(
                        context,
                        searchEnity,
                        searchType,
                        add
                      );
                    },
                    child: ListenableBuilder(
                      listenable: searchEnity,
                      builder: (context, child) {
                        return Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            searchEnity.name == ""
                                ? "اختر $label"
                                : searchEnity.name,
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                if (!required)
                  Positioned(
                    top: 8,
                    left: 10,
                    child: IconButton(
                      onPressed: () {
                        if (searchEnity.id != 0) {
                          searchEnity.reset();
                        }
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  )
              ],
            ),
            if (formFieldState.hasError)
              ValidationErrorMessage(formFieldState: formFieldState)
          ],
        );
      },
    );
  }
}
