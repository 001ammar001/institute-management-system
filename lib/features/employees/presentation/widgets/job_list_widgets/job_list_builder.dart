import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/constants.dart';
import 'package:institute_management_system/core/functions/response_dialogs.dart';
import 'package:institute_management_system/core/widgets/bodies_alert_dialogs/body_delete.dart';
import 'package:institute_management_system/core/widgets/buttons/resend_button.dart';
import 'package:institute_management_system/core/widgets/table_screen/icons_options.dart';
import 'package:institute_management_system/features/drawer/presentation/bloc/drawer_bloc.dart';
import 'package:institute_management_system/features/employees/presentation/bloc/jobs_title_list_bloc/job_title_list_bloc.dart';
import 'package:institute_management_system/features/employees/presentation/pages/add_job_page.dart';

class JobListItemBuilder extends StatelessWidget {
  const JobListItemBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    DrawerBloc drawerBloc = BlocProvider.of<DrawerBloc>(context);
    final jobBloc = BlocProvider.of<JobTitleListBloc>(context);
    return BlocConsumer<JobTitleListBloc, JobTitleListStates>(
        listener: (context, state) {
      if (state is DeleteJobTitleFailureState) {
        showErrorSnackBar(context, state.message);
      }
    }, builder: (context, state) {
      return Expanded(
          flex: 8,
          child: state is JobTitleListSuccessState || state is PageChangedState
              ? ListView.builder(
                  itemCount: jobBloc.jobs.entitys.length,
                  itemBuilder: (context, index) {
                    final job = jobBloc.jobs.entitys[index];
                    return GestureDetector(
                      onTap: () {
                        screenStack.pushScreen(
                            screen: AddJobPage(job: job),
                            title: "تفاصيل الدور");
                        drawerBloc.add(ChangeWidgetEvent());
                      },
                      child: Container(
                        color: index.isEven ? Colors.grey[200] : Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${job.id}',
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                job.name,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                '${job.baseSalary}',
                              ),
                            ),
                            Expanded(
                              child: IconsRowOptions(
                                item: jobBloc.jobs.selecetdEntitys[index],
                                checkBox: (newValue) {
                                  jobBloc.jobs.selecetdEntitys[index] =
                                      newValue!;
                                  jobBloc.add(CheckboxEvent());
                                },
                                delete: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  alertDialogGeneral(
                                    title: "هل أنت متأكد من حذف هذا العنصر",
                                    context: context,
                                    submitFunction: () {
                                      jobBloc.add(DeleteJobTitleEvent(
                                          jobTitleId: job.id!));
                                    },
                                  );
                                },
                                edit: () {
                                  screenStack.pushScreen(
                                      screen: AddJobPage(job: job),
                                      title: "تفاصيل الدور");
                                  drawerBloc.add(ChangeWidgetEvent());
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              : state is JobTitleListFailureState
                  ? ReseendButton(
                      onPressed: () {
                        BlocProvider.of<JobTitleListBloc>(context)
                            .add(GetJobTitlteEvent());
                      },
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ));
    });
  }
}
