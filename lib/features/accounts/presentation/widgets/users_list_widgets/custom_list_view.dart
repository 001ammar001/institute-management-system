import 'package:flutter/material.dart';
import 'package:institute_management_system/features/accounts/domain/entites/user_entity.dart';
import 'package:institute_management_system/features/accounts/presentation/widgets/users_list_widgets/item_builder_user_activity.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({super.key, required this.userActivity});
  final List<UserActivityInfo> userActivity;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      width: double.infinity,
      child: ListView.separated(
        itemCount: userActivity.length,
        separatorBuilder: (context, index) {
          return Container(
            height: 1,
            color: Colors.grey.shade300,
          );
        },
        itemBuilder: (context, index) {
          return ItemBuilderUserActivity(
              firstText: userActivity[index].activity,
              secondText: userActivity[index].date);
        },
      ),
    );
  }
}
