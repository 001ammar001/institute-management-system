import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/features/drawer/presentation/bloc/drawer_bloc.dart';
import '../../data/models/activity_model_list.dart';
import '../bloc/list_activities_bloc/list_activity_bloc.dart';

class ItemBuilderActivity extends StatelessWidget {
  const ItemBuilderActivity({
    super.key,
    required this.bloc,
    required this.state,
    required this.activities,
  });

  final ListActivitiesBloc bloc;
  final ListActivitiesStates state;
  final ActivityModelList activities;
  @override
  Widget build(BuildContext context) {
    DrawerBloc drawerBloc = BlocProvider.of<DrawerBloc>(context);
    return Expanded(
        flex: 8,
        child:
            (state is ListActivitiesSuccessState || state is PageChangedState)
                ? ListView.builder(
                    itemCount: activities.data?.length,
                    itemBuilder: (context, index) {
                      final Activities? activity = activities.data?[index];
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
                                child: Text('   ${index+1}',
                                    style: const TextStyle(color: textColor))),
                            Expanded(
                                flex: 6,
                                child: Center(
                                  child: Text('${activity?.desc}',
                                      style: const TextStyle(
                                          color: textColor, fontSize: 17)),
                                )),
                            Expanded(
                                flex: 6,
                                child: Center(
                                  child: Text("${activity?.createdAt}",
                                      style: const TextStyle(
                                          color: textColor, fontSize: 17)),
                                )),
                          ],
                        ),
                      );
                    })
                : state is ListActivitiesFailureState
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
