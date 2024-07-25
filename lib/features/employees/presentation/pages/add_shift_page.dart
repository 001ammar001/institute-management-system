import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/functions/response_dialogs.dart';
import 'package:institute_management_system/core/utils/enums.dart';
import 'package:institute_management_system/core/widgets/buttons/resend_button.dart';
import 'package:institute_management_system/core/widgets/buttons/submit_button.dart';
import 'package:institute_management_system/core/widgets/buttons/week_day_selector.dart';
import 'package:institute_management_system/core/widgets/text_fields/enabled_text_field.dart';
import 'package:institute_management_system/core/widgets/text_fields/pairs/pair_of_disabled_fields.dart';
import 'package:institute_management_system/core/widgets/title_back_button.dart';
import 'package:institute_management_system/features/employees/domain/entites/shift_entity.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;
import 'package:institute_management_system/features/employees/presentation/bloc/add_shift_bloc/add_shift_bloc.dart';
import 'package:institute_management_system/features/employees/presentation/bloc/shift_details_bloc/shift_details_bloc.dart';
import '../../../../core/constants.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';

class AddShiftPage extends StatefulWidget {
  final int? id;
  const AddShiftPage({super.key, this.id});

  @override
  State<AddShiftPage> createState() => _AddShiftPageState();
}

class _AddShiftPageState extends State<AddShiftPage> {
  late TextEditingController shiftName;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;
  late GlobalKey<FormState> formKey;

  late Set<int> selectdDays;

  @override
  void initState() {
    super.initState();
    shiftName = TextEditingController();
    startTimeController = TextEditingController();
    endTimeController = TextEditingController();
    selectdDays = {};
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    shiftName.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    final size = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocProvider(
          create: (context) {
            final bloc = getit.sl<ShiftDetailsBloc>();
            if (widget.id != null) {
              bloc.add(GetShiftDetailEvent(id: widget.id!));
            }
            return bloc;
          },
          child: BlocConsumer<ShiftDetailsBloc, ShiftDetailsStates>(
            listener: (context, state) {
              if (state is ShiftDataLoadedState) {
                _populateFileds(state.shift);
              }
            },
            builder: (context, state) {
              if (state is ShiftDataLoadingState && widget.id != null) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ShiftDataFailureState) {
                return ReseendButton(
                  message: state.message,
                  onPressed: () {
                    BlocProvider.of<ShiftDetailsBloc>(context)
                        .add(GetShiftDetailEvent(id: widget.id!));
                  },
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TitleWhitBackButton(
                    text:
                        widget.id != null ? "تعديل وردية" : "إضافة وردية جديدة",
                    function: () {
                      screenStack.popScreen();
                      bloc.add(ChangeWidgetEvent());
                    },
                  ),
                  Expanded(
                    child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            EnabledTextField(
                              controller: shiftName,
                              label: "اسم الوردية",
                            ),
                            SizedBox(height: size * 0.1),
                            PairOfDisabledField(
                              label1: "وقت البداية",
                              controller1: startTimeController,
                              label2: "وقت النهاية",
                              controller2: endTimeController,
                              type: DialogTypeEnum.time,
                            ),
                            SizedBox(height: size * 0.1),
                            WeekDaySelector(
                              days: selectdDays,
                            ),
                            SizedBox(height: size * 0.1),
                            BlocProvider(
                              create: (context) => getit.sl<AddShiftBloc>(),
                              child: BlocConsumer<AddShiftBloc, AddShiftStates>(
                                listener: (context, state) {
                                  if (state is AddUpdateShiftSucessState) {
                                    if (widget.id == null) {
                                      formKey.currentState!.reset();
                                      setState(() {
                                        selectdDays = {};
                                      });
                                    }
                                    showSucessSnackBar(context);
                                  } else if (state
                                      is AddUpdateShiftFailureState) {
                                    showErrorSnackBar(context, state.message);
                                  }
                                },
                                builder: (context, state) {
                                  return SubmitButton(
                                    isLoading:
                                        state is AddUpdateShiftLoadingState,
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        final entity = ShiftEntity(
                                            id: widget.id,
                                            name: shiftName.text,
                                            endTime: endTimeController.text,
                                            startTime: startTimeController.text,
                                            days: selectdDays);

                                        BlocProvider.of<AddShiftBloc>(context)
                                            .add(AddUpdateShiftEvent(
                                                shift: entity));
                                      }
                                    },
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _populateFileds(ShiftEntity shift) {
    selectdDays = shift.days;
    shiftName.text = shift.name;
    startTimeController.text = shift.startTime;
    endTimeController.text = shift.endTime;
  }
}
