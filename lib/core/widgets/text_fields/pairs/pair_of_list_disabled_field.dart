import 'package:flutter/material.dart';
import 'package:institute_management_system/core/utils/enums.dart';
import 'package:institute_management_system/core/widgets/text_fields/list_disapled_text_field.dart';
import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';

void maher(){}
class PairOfListDisabledField extends StatelessWidget {
   const PairOfListDisabledField({
    super.key,
    required this.label1,
    required this.searchType1,
    required this.label2,
    required this.searchType2,
    required this.searchEnity1,
    required this.searchEnity2,
    this.add1=maher,
    this.add2=maher,
  });

  final String label1;
  final SearchEntity searchEnity1;
  final SearchTypeEnum searchType1;
  final SearchEntity searchEnity2;
  final String label2;
  final SearchTypeEnum searchType2;
  final Function add1;
  final Function add2;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: ListDisapledTextField(
                    label: label1,
                    searchEnity: searchEnity1,
                    searchType: searchType1,
                    add: add1,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: ListDisapledTextField(
                    label: label2,
                    searchType: searchType2,
                    searchEnity: searchEnity2,
                    add: add2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
