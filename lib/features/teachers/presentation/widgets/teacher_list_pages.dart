import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/functions/response_dialogs.dart';
import '../../../../core/widgets/table_screen/buttons_pages_row.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';
import '../../data/models/filters_teachers_model.dart';
import '../bloc/list_teachers_bloc/list_teachers_bloc.dart';
import 'header_list_teachers.dart';
import 'item_builder_teacher.dart';

class TeacherListPageState extends StatelessWidget {
  final Size media;

  const TeacherListPageState({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    ListTeachersBloc bloc = BlocProvider.of<ListTeachersBloc>(context);
    DrawerBloc drawerBloc = BlocProvider.of<DrawerBloc>(context);
    return BlocConsumer<ListTeachersBloc, ListTeachersStates>(
        listener: (context, state) {
          if( drawerBloc.statusSaveData==false){
            currentPageTeacher=1;
            getArchivedTeacher = false;
            nameTeacher = "";
            phoneNumberTeacher = "";
          }
      if (state is ListTeachersSuccessState) {
        bloc.stateButtonArrowForwardTeacher = 0;
        bloc.stateButtonArrowBackTeacher = 0;
        bloc.stateButtonDeleteTeacher = 0;
      } else if (state is ListTeachersFailureState) {
        bloc.failureText = state.message;
      } else if (state is DeleteTeachersFailureState) {
        showErrorSnackBar(context, state.message);
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Column(
          children: [
            const HeaderListTeachers(),
            ItemBuilderTeacher(
              bloc: bloc,
              state: state,
              teachers: bloc.teachers,
            ),
            ButtonsPagesRow(
              pageNumber: currentPageTeacher,
              onPresBack: () {
                if (bloc.stateButtonArrowBackTeacher == 0) {
                  if (currentPageTeacher > 1) {
                    drawerBloc.statusSaveData=true;
                    currentPageTeacher--;
                    FiltersTeacherModel filter = FiltersTeacherModel(
                      pageNumber: currentPageTeacher,
                      getArchived: getArchivedTeacher,
                      name: nameTeacher,
                      phoneNumber: phoneNumberTeacher
                    );
                    BlocProvider.of<ListTeachersBloc>(context)
                        .add(FilterTeachersListEvent(teachersFilter2: filter));
                  }
                  bloc.stateButtonArrowBackTeacher++;
                }
              },
              onPresForward: () {
                if (bloc.stateButtonArrowForwardTeacher == 0) {
                  if (bloc.teachers.meta!.currentPage! <
                      bloc.teachers.meta!.lastPage!) {
                    drawerBloc.statusSaveData=true;
                    currentPageTeacher++;
                    FiltersTeacherModel filter = FiltersTeacherModel(
                        pageNumber: currentPageTeacher,
                        getArchived: getArchivedTeacher,
                        name: nameTeacher,
                        phoneNumber: phoneNumberTeacher
                    );
                    BlocProvider.of<ListTeachersBloc>(context)
                        .add(FilterTeachersListEvent(teachersFilter2: filter));
                  }
                  bloc.stateButtonArrowForwardTeacher++;
                }
              },
            ),
          ],
        ),
      );
    });
  }
}
