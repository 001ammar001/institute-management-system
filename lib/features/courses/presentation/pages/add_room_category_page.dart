import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/core/functions/response_dialogs.dart';
import 'package:institute_management_system/core/utils/enums.dart';
import 'package:institute_management_system/core/widgets/buttons/submit_button.dart';
import 'package:institute_management_system/core/widgets/text_fields/enabled_text_field.dart';
import 'package:institute_management_system/core/widgets/title_back_button.dart';
import 'package:institute_management_system/features/courses/domain/entites/room_categort_entity.dart';
import 'package:institute_management_system/features/courses/presentation/bloc/rooms_and_categorys/rooms_and_categorys_bloc.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;
import '../../../../core/constants.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';

class AddRoomOrCategoryPage extends StatefulWidget {
  final RoomOrCategoryEntity? roomOrCategory;
  final SearchTypeEnum type;

  const AddRoomOrCategoryPage(
      {super.key, required this.type, this.roomOrCategory})
      : assert(type == SearchTypeEnum.category || type == SearchTypeEnum.room);

  @override
  State<AddRoomOrCategoryPage> createState() => _AddRoomOrCategoryPageState();
}

class _AddRoomOrCategoryPageState extends State<AddRoomOrCategoryPage> {
  late TextEditingController nameController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.roomOrCategory?.name ?? "",
    );
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TitleWhitBackButton(
            text: widget.roomOrCategory != null
                ? "تعديل ${widget.type.getArabicName()}"
                : "إضافة ${widget.type.getArabicName()}",
            function: () {
              screenStack.popScreen();
              bloc.add(ChangeWidgetEvent());
            },
          ),
          Expanded(
            child: Form(
              key: formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    EnabledTextField(
                      controller: nameController,
                      label: "اسم ${widget.type.getArabicName()}",
                    ),
                    BlocProvider(
                      create: (context) => getit.sl<RoomsAndCategorysBloc>(),
                      child: BlocConsumer<RoomsAndCategorysBloc,
                          RoomsAndCategorysState>(
                        listener: (context, state) {
                          if (state is RoomsAndCategorysSucessState) {
                            if (widget.roomOrCategory == null) {
                              formKey.currentState!.reset();
                            }
                            showSucessSnackBar(context);
                          } else if (state is RoomsAndCategorysFailureState) {
                            showErrorSnackBar(context, state.message);
                          }
                        },
                        builder: (context, state) {
                          return SubmitButton(
                            isLoading: state is RoomsAndCategorysLoadingState,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                final entity = RoomOrCategoryEntity(
                                  id: widget.roomOrCategory?.id,
                                  name: nameController.text,
                                );
                                if (widget.type == SearchTypeEnum.room) {
                                  BlocProvider.of<RoomsAndCategorysBloc>(
                                          context)
                                      .add(AddOrUpdateRoomEvent(room: entity));
                                } else {
                                  BlocProvider.of<RoomsAndCategorysBloc>(
                                          context)
                                      .add(AddOrUpdateCategoryEvent(
                                          category: entity));
                                }
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
      ),
    );
  }
}
