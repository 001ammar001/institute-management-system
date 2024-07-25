import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:institute_management_system/core/functions/response_dialogs.dart';
import 'package:institute_management_system/core/utils/enums.dart';
import 'package:institute_management_system/core/widgets/buttons/submit_button.dart';
import 'package:institute_management_system/core/widgets/text_fields/enabled_text_field.dart';
import 'package:institute_management_system/core/widgets/text_fields/list_disapled_text_field.dart';
import 'package:institute_management_system/core/widgets/title_back_button.dart';
import 'package:institute_management_system/features/courses/domain/entites/room_categort_entity.dart';
import 'package:institute_management_system/features/courses/domain/entites/subject_entity.dart';
import 'package:institute_management_system/features/courses/presentation/bloc/add_subject_bloc/add_subject_bloc.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;
import 'package:institute_management_system/features/search/domain/entites/search_entity.dart';

import '../../../../core/constants.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';
import 'add_room_category_page.dart';

class AddSubjectPage extends StatefulWidget {
  final SubjectEntity? subject;
  const AddSubjectPage({super.key, this.subject});

  @override
  State<AddSubjectPage> createState() => _AddSubjectPageState();
}

class _AddSubjectPageState extends State<AddSubjectPage> {
  late TextEditingController subjectNameController;
  late SearchEntity category;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    subjectNameController = TextEditingController(
      text: widget.subject?.subject ?? "",
    );
    category = SearchEntity(
      id: widget.subject?.category.id,
      name: widget.subject?.category.name,
    );

    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    subjectNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    final size = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TitleWhitBackButton(
            text: widget.subject != null ? "تعديل مادة" : "إضافة مادة",
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
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 75),
                      child: Column(
                        children: [
                          ListDisapledTextField(
                            label: "الصنف",
                            searchType: SearchTypeEnum.category,
                            searchEnity: category,
                            add: (){
                              navigator?.pop();
                              screenStack.pushScreen(
                                  screen: const AddRoomOrCategoryPage(
                                      type: SearchTypeEnum.category),
                                  title: "إضافة صنف ");
                              bloc.add(ChangeWidgetEvent());
                            },
                          ),
                          SizedBox(height: size * 0.1),
                          EnabledTextField(
                            controller: subjectNameController,
                            label: "اسم المادة",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size * 0.2),
                    BlocProvider(
                      create: (context) => getit.sl<SubjectAddBloc>(),
                      child: BlocConsumer<SubjectAddBloc, SubjectAddStates>(
                        listener: (context, state) {
                          if (state is SubjectAddUpdateSucessState) {
                            if (widget.subject == null) {
                              subjectNameController.clear();
                              category.reset();
                            }
                            showSucessSnackBar(context);
                          } else if (state is SubjectAddUpdateFailureState) {
                            showErrorSnackBar(context, state.message);
                          }
                        },
                        builder: (context, state) {
                          return SubmitButton(
                            isLoading: state is SubjectAddUpdateLoadingState,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                final entity = SubjectEntity(
                                  id: widget.subject?.id,
                                  category: RoomOrCategoryEntity(
                                      id: category.id, name: category.name),
                                  subject: subjectNameController.text,
                                );

                                BlocProvider.of<SubjectAddBloc>(context).add(
                                    AddUpdateSubjectEvent(subject: entity));
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
