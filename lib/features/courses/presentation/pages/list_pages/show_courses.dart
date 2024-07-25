import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/widgets/table_screen/table_list_buttons_appbar.dart';
import '../../../../../core/widgets/table_screen/table_list_component.dart';
import '../../../../drawer/presentation/bloc/drawer_bloc.dart';
import '../../../data/models/filters_courses_model.dart';
import '../../bloc/list/list_courses_bloc/list_courses_bloc.dart';
import '../../widgets/course_list_widgets/course_filter_widget.dart';
import '../../widgets/course_list_widgets/course_list_pages.dart';
import 'package:institute_management_system/core/injection_container/injection_container.dart'
    as getit;

import '../add_course_page.dart';

class ShowCoursesScreen extends StatefulWidget {
  const ShowCoursesScreen({super.key});

  @override
  State<ShowCoursesScreen> createState() => _ShowCoursesScreenState();
}

class _ShowCoursesScreenState extends State<ShowCoursesScreen> {
  late TextEditingController valueSearchCourse;

  @override
  void initState() {
    super.initState();
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    valueSearchCourse =
        TextEditingController(text: bloc.statusSaveData ? subject : '');
  }

  @override
  void dispose() {
    super.dispose();
    valueSearchCourse.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    Size media = screenMedia(context);
    return BlocProvider(
      create: (context) {
        if (bloc.statusSaveData == false) {
          return getit.sl<ListCoursesBloc>()
            ..add(const CoursesEvents(currentPage: 1));
        } else {
          return getit.sl<ListCoursesBloc>()
            ..add(FilterCoursesListEvent(coursesFilter2: bloc.coursesFilter));
        }
      },
      child: Scaffold(body: BlocBuilder<ListCoursesBloc, ListCoursesStates>(
          builder: (context, state) {
        return TableListComponent(
          label: 'المادة',
          onSubmit: () {
            bloc.statusSaveData = true;
            currentPageCourse = 1;
            getArchivedCourse = false;
            subject = valueSearchCourse.text;
            statusCourse = "";
            teacher = "";
            room = "";
            startAt = "";
            endAt = "";
            ListCoursesBloc blocCourses =
                BlocProvider.of<ListCoursesBloc>(context);
            FiltersCourseModel filter = FiltersCourseModel(
              pageNumber: 1,
              subject: valueSearchCourse.text,
              getArchived: false,
              status: '',
              teacher: '',
              room: '',
              startAt: '',
              endAt: '',
            );
            blocCourses.add(FilterCoursesListEvent(coursesFilter2: filter));
          },
          search: valueSearchCourse,
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
                  if (state is! ListCoursesLoadingState) {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return CourseFilterWidget(
                          bloc: BlocProvider.of<ListCoursesBloc>(context),
                          valueSearchCourse: valueSearchCourse,
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
                        screen: const AddCoursePage(), title: "إضافة دورة");
                    bloc.add(ChangeWidgetEvent());
                  },
                  text: 'إضافة دورة')
            ],
          ),
          widgetPage: CourseListPageState(media: media),
        );
      })),
    );
  }
}
