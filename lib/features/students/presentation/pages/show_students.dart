import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/features/students/presentation/bloc/list_students_bloc/list_students_bloc.dart';
import '../../../../core/constants.dart';
import '../../../../core/widgets/table_screen/table_list_buttons_appbar.dart';
import '../../../../core/widgets/table_screen/table_list_component.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';
import '../../data/models/filters_students_model.dart';
import '../widgets/student_filter_widget.dart';
import '../widgets/student_list_pages.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;

import 'add_student_page.dart';

class ShowStudentsScreen extends StatefulWidget {
  const ShowStudentsScreen({super.key});

  @override
  State<ShowStudentsScreen> createState() => _ShowStudentsScreenState();
}

class _ShowStudentsScreenState extends State<ShowStudentsScreen> {
  late TextEditingController valueSearchStudent;

  @override
  void initState() {
    super.initState();
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    valueSearchStudent = TextEditingController(text: bloc.statusSaveData?arabicNameStudent:'');
  }

  @override
  void dispose() {
    super.dispose();
    valueSearchStudent.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    Size media = screenMedia(context);
    return BlocProvider(
      create: (context) {
        if (bloc.statusSaveData == false) {
          return getit.sl<ListStudentsBloc>()
            ..add(const StudentsEvents(
              currentPage: 1,
            ));
        } else {
          return getit.sl<ListStudentsBloc>()
            ..add(
                FilterStudentsListEvent(studentsFilter2: bloc.studentsFilter));
        }
      },
      child: Scaffold(
          body: BlocBuilder<ListStudentsBloc, ListStudentsStates>(
          builder: (context, state) {
        return TableListComponent(
          label: 'اسم الطالب',
          onSubmit: () {
            bloc.statusSaveData=true;
            currentPageStudent=1;
            getArchivedStudent = false;
            arabicNameStudent = valueSearchStudent.text;
            englishNameStudent = '';
            fatherName = '';
            motherName = '';
            createDate = '';
            educationLevel = '';
            lineNumber = '';
            ListStudentsBloc blocStudents = BlocProvider.of<ListStudentsBloc>(context);
            FiltersStudentModel filter = FiltersStudentModel(
                pageNumber: 1,
                arabicNameStudent: valueSearchStudent.text,
                englishNameStudent: '',
                fatherName: '',
                motherName: '',
                createDate: '',
                educationLevel: '',
                lineNumber: '',
                getArchived: false);
                blocStudents.add(FilterStudentsListEvent(studentsFilter2: filter));
          },
          search: valueSearchStudent,
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
                      if (state is! ListStudentsLoadingState) {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return StudentFilterWidget(
                              bloc: BlocProvider.of<ListStudentsBloc>(context),
                              valueSearchStudent: valueSearchStudent,
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
                        screen: const AddStudentPage(), title: "إضافة طالب");
                    bloc.add(ChangeWidgetEvent());
                  },
                  text: 'إضافة طالب')
            ],
          ),
          widgetPage: StudentListPageState(media: media),
        );
      })
      ),
    );
  }
}
