import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/widgets/buttons/custom_segmented_buttons.dart';
import 'package:institute_management_system/core/widgets/buttons/yes_no_button.dart';
import 'package:institute_management_system/core/widgets/text_fields/enabled_text_field.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/widgets/text_fields/disapled_text_field.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';
import '../../data/models/filters_activities_model.dart';
import '../bloc/list_activities_bloc/list_activity_bloc.dart';

class ActivityFilterWidget extends StatefulWidget {
  final ListActivitiesBloc bloc;
  final TextEditingController valueSearchActivity;

  const ActivityFilterWidget({
    super.key,
    required this.bloc, required this.valueSearchActivity,
  });

  @override
  State<ActivityFilterWidget> createState() => _ActivityFilterWidgetState();
}

class _ActivityFilterWidgetState extends State<ActivityFilterWidget> {
  late Set operation;
  late TextEditingController userNameController;
  late TextEditingController modelController;

  @override
  void initState() {
    super.initState();
    operation = {false};
    userNameController = TextEditingController(
      text: '',
    );
    modelController = TextEditingController(
      text: '',
    );
  }

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    modelController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size media= MediaQuery.sizeOf(context);
    DrawerBloc drawerBloc = BlocProvider.of<DrawerBloc>(context);
    return Dialog(
      child: SizedBox(
        width: media.width/1.5,
        height: media.height/1.2,
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: media.width/20 , right:  media.width/20,top: 30),
                    child: _buildOperationButton(),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: media.width/6 , right:  media.width/6),
                    child: EnabledTextField(
                      controller: userNameController,
                      label: "اسم المستخدم",
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: media.width/6 , right:  media.width/6),
                    child: DisabledTextField(
                      type: DialogTypeEnum.activityFilterType,
                      controller: modelController,
                      label: "النوع",
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      YesNoButton(
                        yes: true,
                        onYesSubmited: () {
                          if(operation.first==false){
                            operation= {''};
                          }
                          widget.valueSearchActivity.text='';
                          drawerBloc.statusSaveData=true;
                          currentPageActivity=1;
                          operationActivity = operation.first;
                          userNameActivity =userNameController.text;
                          modelActivity = modelController.text;
                          FiltersActivityModel filter = FiltersActivityModel(
                              pageNumber: currentPageActivity,
                              model: modelActivity,
                              operation: operationActivity,
                              userName: userNameActivity,
                          );
                          widget.bloc.add(FilterActivitiesListEvent(
                              activitiesFilter2: filter));
                        },
                      ),
                       const YesNoButton(
                        yes: false,
                      )
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildOperationButton() {
    return Row(
      children: [
        StatefulBuilder(
          builder: (context, setState) {
            return CustomSegmentedButton(
              label: "نوع العملية :",
              selectedValue: operation,
              onSelectionChanged: (data) {
                setState(() {
                  operation = data;
                });
              },
              segments: const [
                ButtonSegment(
                  value: false,
                  label: Text(
                    "جميع العمليات",
                    softWrap: true,
                  ),
                ),
                ButtonSegment(
                  value: 'C',
                  label: Text(
                    "إنشاء",
                    softWrap: false,
                  ),
                ),
                ButtonSegment(
                  value: 'U',
                  label: Text(
                    "تعديل",
                    softWrap: false,
                  ),
                ),
                ButtonSegment(
                  value: 'D',
                  label: Text(
                    "حذف",
                    softWrap: false,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
