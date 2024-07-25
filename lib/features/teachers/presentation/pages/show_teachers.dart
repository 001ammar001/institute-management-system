import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants.dart';
import '../../../../core/widgets/table_screen/table_list_buttons_appbar.dart';
import '../../../../core/widgets/table_screen/table_list_component.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';
import '../../data/models/filters_teachers_model.dart';
import '../bloc/list_teachers_bloc/list_teachers_bloc.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;

import '../widgets/teacher_filter_widget.dart';
import '../widgets/teacher_list_pages.dart';
import 'add_teacher_page.dart';

class ShowTeachersScreen extends StatefulWidget {
  const ShowTeachersScreen({super.key});

  @override
  State<ShowTeachersScreen> createState() => _ShowTeachersScreenState();
}

class _ShowTeachersScreenState extends State<ShowTeachersScreen> {
  late TextEditingController valueSearchTeacher;

  @override
  void initState() {
    super.initState();
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    valueSearchTeacher = TextEditingController(text: bloc.statusSaveData? nameTeacher : '' );
  }

  @override
  void dispose() {
    super.dispose();
    valueSearchTeacher.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    Size media = screenMedia(context);
    return BlocProvider(
      create: (context) {
        if (bloc.statusSaveData == false) {
          return getit.sl<ListTeachersBloc>()
            ..add(const TeachersEvents(
              currentPage: 1,
            ));
        } else {
          return getit.sl<ListTeachersBloc>()
            ..add(
                FilterTeachersListEvent(teachersFilter2: bloc.teachersFilter));
        }
      },
      child: Scaffold(
        body: BlocBuilder<ListTeachersBloc, ListTeachersStates>(
            builder: (context, state) {
          return TableListComponent(
            label: 'اسم المعلم',
            onSubmit: () {
              bloc.statusSaveData = true;
              currentPageTeacher = 1;
              getArchivedTeacher = false;
              nameTeacher = valueSearchTeacher.text;
              phoneNumberTeacher = '';
              ListTeachersBloc blocTeachers =
                  BlocProvider.of<ListTeachersBloc>(context);
              FiltersTeacherModel filter = FiltersTeacherModel(
                  pageNumber: 1,
                  name: valueSearchTeacher.text,
                  phoneNumber: '',
                  getArchived: false);
              blocTeachers
                  .add(FilterTeachersListEvent(teachersFilter2: filter));
            },
            search: valueSearchTeacher,
            function: () {
              bloc.statusSaveData = false;
              screenStack.popScreen();
              bloc.add(ChangeWidgetEvent());
            },
            buttonsNum: 2,
            media: media,
            widgetButtons: Row(
              children: [
                TableListButtonsAppBar(
                  function: () {
                    if (state is! ListTeachersLoadingState) {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return TeacherFilterWidget(
                            bloc: BlocProvider.of<ListTeachersBloc>(context),
                            valueSearchTeacher: valueSearchTeacher,
                          );
                        },
                      );
                    }
                  },
                  text: 'الفلاتر',
                ),
                const SizedBox(
                  width: 20,
                ),
                TableListButtonsAppBar(
                    function: () {
                      screenStack.pushScreen(
                          screen: const AddTeacherPage(), title: "إضافة استاذ");
                      bloc.add(ChangeWidgetEvent());
                    },
                    text: 'إضافة معلم')
              ],
            ),
            widgetPage: TeacherListPageState(media: media),
          );
        }),
      ),
    );
  }
}
