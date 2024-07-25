import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/widgets/table_screen/buttons_pages_row.dart';
import 'package:institute_management_system/features/courses/presentation/bloc/subjects_list_bloc/subjects_list_bloc.dart';
import 'package:institute_management_system/features/courses/presentation/widgets/subjects_list_widgets/subjects_list_builder.dart';
import 'package:institute_management_system/features/courses/presentation/widgets/subjects_list_widgets/subjects_list_table_header.dart';

class SubjectsListBody extends StatelessWidget {
  final Size media;

  const SubjectsListBody({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    SubjectsListBloc bloc = BlocProvider.of<SubjectsListBloc>(context);
    return Column(
      children: [
        SubjectsListTableHeader(media: media),
        const SubjetsListItemBuilder(),
        BlocBuilder<SubjectsListBloc, SubjectsListStates>(
          builder: (context, state) {
            return ButtonsPagesRow(
              pageNumber: bloc.currentPage,
              onPresBack: () {
                if (state is! SubjectsListLoadingState) {
                  if (bloc.currentPage > 1) {
                    bloc.currentPage--;
                    bloc.add(GetSubjectsEvent());
                  }
                }
              },
              onPresForward: () {
                if (state is! SubjectsListLoadingState) {
                  if (bloc.currentPage < bloc.subjects.maxPage) {
                    bloc.currentPage++;
                    bloc.add(GetSubjectsEvent());
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
