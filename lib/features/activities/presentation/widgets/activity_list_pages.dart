import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/features/activities/presentation/bloc/list_activities_bloc/list_activity_bloc.dart';
import '../../../../core/functions/response_dialogs.dart';
import '../../../../core/widgets/table_screen/buttons_pages_row.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';
import '../../data/models/filters_activities_model.dart';
import 'header_list_activities.dart';
import 'item_builder_activity.dart';

class ActivityListPageState extends StatelessWidget {
  final Size media;

  const ActivityListPageState({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    ListActivitiesBloc bloc = BlocProvider.of<ListActivitiesBloc>(context);
    DrawerBloc drawerBloc = BlocProvider.of<DrawerBloc>(context);
    return BlocConsumer<ListActivitiesBloc, ListActivitiesStates>(
        listener: (context, state) {
          if( drawerBloc.statusSaveData==false){
            currentPageActivity=1;
            userNameActivity = "";
            operationActivity = "";
            modelActivity = "";
          }
      if (state is ListActivitiesSuccessState) {
        bloc.stateButtonArrowForwardActivity = 0;
        bloc.stateButtonArrowBackActivity = 0 ;
        bloc.stateButtonDeleteActivity=0;
      } else if (state is ListActivitiesFailureState) {
        bloc.failureText = state.message;
      }else if (state is DeleteActivitiesFailureState) {
        showErrorSnackBar(context, state.message);
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Column(
          children: [
            HeaderListActivities(media: media),
            ItemBuilderActivity(
              bloc: bloc,
              state: state,
              activities: bloc.activities,
            ),
            ButtonsPagesRow(
              pageNumber: currentPageActivity,
              onPresBack: () {
                  if (bloc.stateButtonArrowBackActivity == 0) {
                    if (currentPageActivity > 1) {
                      drawerBloc.statusSaveData=true;
                      currentPageActivity--;
                      FiltersActivityModel filter = FiltersActivityModel(
                          pageNumber: currentPageActivity,
                          userName: userNameActivity,
                          operation: operationActivity,
                          model: modelActivity
                      );
                      BlocProvider.of<ListActivitiesBloc>(context)
                          .add(FilterActivitiesListEvent(activitiesFilter2: filter));
                    }
                    bloc.stateButtonArrowBackActivity++;
                  }
              },
              onPresForward: () {
                if (bloc.stateButtonArrowForwardActivity == 0) {
                  if (bloc.activities.meta!.currentPage! <
                      bloc.activities.meta!.lastPage!) {
                    drawerBloc.statusSaveData=true;
                    currentPageActivity++;
                    FiltersActivityModel filter = FiltersActivityModel(
                        pageNumber: currentPageActivity,
                        userName: userNameActivity,
                        operation: operationActivity,
                        model: modelActivity
                    );
                    BlocProvider.of<ListActivitiesBloc>(context)
                        .add(FilterActivitiesListEvent(activitiesFilter2: filter));
                  }
                  bloc.stateButtonArrowForwardActivity++;
                }
              },
            ),
          ],
        ),
      );
    });
  }
}
