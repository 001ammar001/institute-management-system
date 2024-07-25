import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/functions/response_dialogs.dart';
import '../../../../../core/widgets/table_screen/buttons_pages_row.dart';
import '../../../../drawer/presentation/bloc/drawer_bloc.dart';
import '../../../data/models/filters_courses_model.dart';
import '../../bloc/list/list_courses_bloc/list_courses_bloc.dart';
import 'header_list_courses.dart';
import 'item_builder_course.dart';

class CourseListPageState extends StatelessWidget {
  final Size media;

  const CourseListPageState({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    ListCoursesBloc bloc = BlocProvider.of<ListCoursesBloc>(context);
    DrawerBloc drawerBloc = BlocProvider.of<DrawerBloc>(context);
    return BlocConsumer<ListCoursesBloc, ListCoursesStates>(
        listener: (context, state) {
      if (drawerBloc.statusSaveData == false) {
        currentPageCourse = 1;
        getArchivedCourse = false;
        statusCourse = "";
        teacher = "";
        room = "";
        subject = "";
        startAt = "";
        endAt = "";
      } else if (state is ListCoursesSuccessState) {
        bloc.stateButtonArrowForwardCourse = 0;
        bloc.stateButtonArrowBackCourse = 0;
        bloc.stateButtonDeleteCourse = 0;
      } else if (state is ListCoursesFailureState) {
        bloc.failureText = state.message;
      } else if (state is DeleteCoursesFailureState) {
        showErrorSnackBar(context, state.message);
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Column(
          children: [
            HeaderListCourses(media: media),
            ItemBuilderCourse(
              bloc: bloc,
              state: state,
              courses: bloc.courses,
            ),
            ButtonsPagesRow(
              pageNumber: currentPageCourse,
              onPresBack: () {
                if (bloc.stateButtonArrowBackCourse == 0) {
                  if (currentPageCourse > 1) {
                    drawerBloc.statusSaveData = true;
                    currentPageCourse--;
                    FiltersCourseModel filter = FiltersCourseModel(
                      pageNumber: currentPageCourse,
                      getArchived: getArchivedCourse,
                      status: statusCourse,
                      teacher: teacher,
                      room: room,
                      subject: subject,
                      startAt: startAt,
                      endAt: endAt,
                    );
                    BlocProvider.of<ListCoursesBloc>(context)
                        .add(FilterCoursesListEvent(coursesFilter2: filter));
                  }
                  bloc.stateButtonArrowBackCourse++;
                }
              },
              onPresForward: () {
                if (bloc.stateButtonArrowForwardCourse == 0) {
                  if (bloc.courses.meta!.currentPage! <
                      bloc.courses.meta!.lastPage!) {
                    drawerBloc.statusSaveData = true;
                    currentPageCourse++;
                    FiltersCourseModel filter = FiltersCourseModel(
                      pageNumber: currentPageCourse,
                      getArchived: getArchivedCourse,
                      status: statusCourse,
                      teacher: teacher,
                      room: room,
                      subject: subject,
                      startAt: startAt,
                      endAt: endAt,
                    );
                    BlocProvider.of<ListCoursesBloc>(context)
                        .add(FilterCoursesListEvent(coursesFilter2: filter));
                  }
                  bloc.stateButtonArrowForwardCourse++;
                }
              },
            ),
          ],
        ),
      );
    });
  }
}
