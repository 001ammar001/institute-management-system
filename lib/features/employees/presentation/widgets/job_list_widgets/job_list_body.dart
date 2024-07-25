import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/widgets/table_screen/buttons_pages_row.dart';
import 'package:institute_management_system/features/employees/presentation/bloc/jobs_title_list_bloc/job_title_list_bloc.dart';
import 'package:institute_management_system/features/employees/presentation/widgets/job_list_widgets/job_list_builder.dart';
import 'package:institute_management_system/features/employees/presentation/widgets/job_list_widgets/job_list_table_header.dart';

class JobListBody extends StatelessWidget {
  final Size media;

  const JobListBody({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    JobTitleListBloc bloc = BlocProvider.of<JobTitleListBloc>(context);
    return Column(
      children: [
        JobListTableHeader(media: media),
        const JobListItemBuilder(),
        BlocBuilder<JobTitleListBloc, JobTitleListStates>(
          builder: (context, state) {
            return ButtonsPagesRow(
              pageNumber: bloc.currentPage,
              onPresBack: () {
                if (bloc.state is! JobTitlteListLoadingState) {
                  if (bloc.currentPage > 1) {
                    bloc.currentPage--;
                    bloc.add(GetJobTitlteEvent());
                  }
                }
              },
              onPresForward: () {
                if (bloc.state is! JobTitlteListLoadingState) {
                  if (bloc.currentPage < bloc.jobs.maxPage) {
                    bloc.currentPage++;
                    bloc.add(GetJobTitlteEvent());
                  }
                }
              },
            );
          },
        ),
      ],
    );
  }
}
