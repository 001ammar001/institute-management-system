import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants.dart';
import '../../../../core/widgets/table_screen/table_list_buttons_appbar.dart';
import '../../../../core/widgets/table_screen/table_list_component.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';
import '../../data/models/filters_activities_model.dart';
import '../bloc/list_activities_bloc/list_activity_bloc.dart';
import '../widgets/activity_filter_widget.dart';
import '../widgets/activity_list_pages.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;

class ShowActivitiesScreen extends StatefulWidget {
  const ShowActivitiesScreen({super.key});

  @override
  State<ShowActivitiesScreen> createState() => _ShowActivitiesScreenState();
}

class _ShowActivitiesScreenState extends State<ShowActivitiesScreen> {
  late TextEditingController valueSearchActivity;

  @override
  void initState() {
    super.initState();
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    valueSearchActivity = TextEditingController(text: bloc.statusSaveData? userNameActivity : '' );
  }

  @override
  void dispose() {
    super.dispose();
    valueSearchActivity.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    Size media = screenMedia(context);
    return BlocProvider(
      create: (context) {
        if (bloc.statusSaveData == false) {
          return getit.sl<ListActivitiesBloc>()
            ..add(const ActivitiesEvents(
              currentPage: 1,
            ));
        } else {
          return getit.sl<ListActivitiesBloc>()
            ..add(FilterActivitiesListEvent(
                activitiesFilter2: bloc.activitiesFilter));
        }
      },
      child: Scaffold(body: BlocBuilder<ListActivitiesBloc, ListActivitiesStates>(
          builder: (context, state) {
        return TableListComponent(
          label: 'اسم المستخدم',
          onSubmit: () {
            bloc.statusSaveData=true;
            currentPageActivity=1;
            userNameActivity = valueSearchActivity.text ;
            operationActivity = "";
            modelActivity = "";
            ListActivitiesBloc blocActivities = BlocProvider.of<ListActivitiesBloc>(context);
            FiltersActivityModel filter = FiltersActivityModel(
                pageNumber: 1,
                userName: valueSearchActivity.text,
                operation: '',
                model: '',
            );
            blocActivities.add(FilterActivitiesListEvent(activitiesFilter2: filter));
          },
          search: valueSearchActivity,
          function: () {
            bloc.statusSaveData = false;
            screenStack.popScreen();
            bloc.add(ChangeWidgetEvent());
          },
          buttonsNum: 2,
          media: media,
          widgetButtons: Row(
            children: [
              TableListButtonsAppBar(
                function: () {
                  if (state is! ListActivitiesLoadingState) {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return ActivityFilterWidget(
                          bloc: BlocProvider.of<ListActivitiesBloc>(context),
                          valueSearchActivity: valueSearchActivity,
                        );
                      },
                    );
                  }
                },
                text: 'الفلاتر',
              ),
            ],
          ),
          widgetPage: ActivityListPageState(media: media),
        );
      })),
    );
  }
}
