import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/widgets/table_screen/buttons_pages_row.dart';
import 'package:institute_management_system/features/employees/presentation/bloc/shifts_list_bloc/shits_list_bloc.dart';
import 'package:institute_management_system/features/employees/presentation/widgets/shift_list_widgets/shift_list_builder.dart';
import 'package:institute_management_system/features/employees/presentation/widgets/shift_list_widgets/shift_list_table_header.dart';

class ShiftListBody extends StatelessWidget {
  final Size media;

  const ShiftListBody({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    ShiftListBloc bloc = BlocProvider.of<ShiftListBloc>(context);
    return Column(
      children: [
        ShiftListTableHeader(media: media),
        const ShiftListItemBuilder(),
        BlocBuilder<ShiftListBloc, ShiftListStates>(
          builder: (context, state) {
            return ButtonsPagesRow(
              pageNumber: bloc.currentPage,
              onPresBack: () {
                if (state is! ShiftListLoadingState) {
                  if (bloc.currentPage > 1) {
                    bloc.currentPage--;
                    bloc.add(GetShiftsEvent());
                  }
                }
              },
              onPresForward: () {
                if (state is! ShiftListLoadingState) {
                  if (bloc.currentPage < bloc.shifts.maxPage) {
                    bloc.currentPage++;
                    bloc.add(GetShiftsEvent());
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
