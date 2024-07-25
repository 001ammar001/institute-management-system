import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/functions/response_dialogs.dart';
import '../../../../core/widgets/table_screen/buttons_pages_row.dart';
import '../bloc/list_employee_bloc/list_employees_bloc.dart';
import 'header_list_employees.dart';
import 'item_builder_employee.dart';

class EmployeeListPageState extends StatelessWidget {
  final Size media;

  const EmployeeListPageState({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    ListEmployeesBloc bloc = BlocProvider.of<ListEmployeesBloc>(context);
    return BlocConsumer<ListEmployeesBloc, ListEmployeesStates>(
        listener: (context, state) {
      if (state is ListEmployeesSuccessState) {
        bloc.stateButtonArrowForwardEmployee = 0;
        bloc.stateButtonArrowBackEmployee = 0 ;
        bloc.stateButtonDeleteEmployee=0;
      } else if (state is ListEmployeesFailureState) {
        bloc.failureText = state.message;
      }else if (state is DeleteEmployeesFailureState) {
        showErrorSnackBar(context, state.message);
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Column(
          children: [
            HeaderListEmployees(media: media),
            ItemBuilderEmployee(
              bloc: bloc,
              state: state,
              employees: bloc.employees,
            ),
            ButtonsPagesRow(
              pageNumber: bloc.currentPage,
              onPresBack: () {
                  if (bloc.stateButtonArrowBackEmployee == 0) {
                    if (bloc.currentPage > 1) {
                      bloc.currentPage--;
                      BlocProvider.of<ListEmployeesBloc>(context)
                          .add(EmployeesEvents(currentPage: bloc.currentPage));
                    }
                    bloc.stateButtonArrowBackEmployee++;
                  }
              },
              onPresForward: () {
                if (bloc.stateButtonArrowForwardEmployee == 0) {
                  if (bloc.employees.meta!.currentPage! <
                      bloc.employees.meta!.lastPage!) {
                    bloc.currentPage++;
                    BlocProvider.of<ListEmployeesBloc>(context)
                        .add(EmployeesEvents(currentPage: bloc.currentPage));
                  }
                  bloc.stateButtonArrowForwardEmployee++;
                }
              },
            ),
          ],
        ),
      );
    });
  }
}
