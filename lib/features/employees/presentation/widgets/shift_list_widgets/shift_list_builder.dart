import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/constants.dart';
import 'package:institute_management_system/core/functions/response_dialogs.dart';
import 'package:institute_management_system/core/widgets/bodies_alert_dialogs/body_delete.dart';
import 'package:institute_management_system/core/widgets/buttons/resend_button.dart';
import 'package:institute_management_system/core/widgets/table_screen/icons_options.dart';
import 'package:institute_management_system/core/widgets/week_day.dart';
import 'package:institute_management_system/features/drawer/presentation/bloc/drawer_bloc.dart';
import 'package:institute_management_system/features/employees/presentation/bloc/shifts_list_bloc/shits_list_bloc.dart';
import 'package:institute_management_system/features/employees/presentation/pages/add_shift_page.dart';

class ShiftListItemBuilder extends StatelessWidget {
  const ShiftListItemBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    DrawerBloc drawerBloc = BlocProvider.of<DrawerBloc>(context);
    final shiftBloc = BlocProvider.of<ShiftListBloc>(context);
    return BlocConsumer<ShiftListBloc, ShiftListStates>(
        listener: (context, state) {
      if (state is DeleteShiftFailureState) {
        showErrorSnackBar(context, state.message);
      }
    }, builder: (context, state) {
      return Expanded(
          flex: 8,
          child: state is ShiftListSuccessState || state is PageChangedState
              ? ListView.builder(
                  itemCount: shiftBloc.shifts.entitys.length,
                  itemBuilder: (context, index) {
                    final shift = shiftBloc.shifts.entitys[index];
                    return GestureDetector(
                      onTap: () {
                        screenStack.pushScreen(
                            screen: AddShiftPage(id: shift.id),
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
                                '${shift.id}',
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                shift.name,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                convertNumbersToDays(shift.days.toList())
                                    .join(", "),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                shift.startTime,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                shift.endTime,
                              ),
                            ),
                            Expanded(
                              child: IconsRowOptions(
                                item: shiftBloc.shifts.selecetdEntitys[index],
                                checkBox: (newValue) {
                                  shiftBloc.shifts.selecetdEntitys[index] =
                                      newValue!;
                                  shiftBloc.add(CheckboxEvent());
                                },
                                delete: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  alertDialogGeneral(
                                    title: "هل أنت متأكد من حذف هذا العنصر",
                                    context: context,
                                    submitFunction: () {
                                      shiftBloc.add(
                                          DeleteShiftEvent(shiftId: shift.id!));
                                    },
                                  );
                                },
                                edit: () {
                                  screenStack.pushScreen(
                                      screen: AddShiftPage(id: shift.id!),
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
              : state is ShiftListFailureState
                  ? ReseendButton(
                      onPressed: () {
                        BlocProvider.of<ShiftListBloc>(context)
                            .add(GetShiftsEvent());
                      },
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ));
    });
  }
}
