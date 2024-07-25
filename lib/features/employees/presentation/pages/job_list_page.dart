import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/features/employees/presentation/bloc/jobs_title_list_bloc/job_title_list_bloc.dart';
import 'package:institute_management_system/features/employees/presentation/pages/add_job_page.dart';
import 'package:institute_management_system/features/employees/presentation/widgets/job_list_widgets/job_list_body.dart';
import '../../../../core/constants.dart';
import '../../../../core/widgets/table_screen/table_list_buttons_appbar.dart';
import '../../../../core/widgets/table_screen/table_list_component.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;

//TODO: we still nead to add search;
TextEditingController valueSearchJop = TextEditingController();

class JobTitleListPage extends StatelessWidget {
  const JobTitleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    Size media = screenMedia(context);
    return BlocProvider(
      create: (context) =>
          getit.sl<JobTitleListBloc>()..add(GetJobTitlteEvent()),
      child: TableListComponent(
        label: '',
        onSubmit: (){},
        search: valueSearchJop,
        function: () {
          screenStack.popScreen();
          bloc.add(ChangeWidgetEvent());
        },
        buttonsNum: 1,
        media: media,
        widgetButtons: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            TableListButtonsAppBar(
              text: 'إضافة مسمى وظيفي',
              function: () {
                screenStack.pushScreen(
                    screen: const AddJobPage(), title: "إضافة مسمى وظيفي");
                bloc.add(ChangeWidgetEvent());
              },
            )
          ],
        ),
        widgetPage: JobListBody(media: media),
      ),
    );
  }
}
