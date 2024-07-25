import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:institute_management_system/features/students/presentation/bloc/list_students_bloc/list_students_bloc.dart';
import '../../../../core/functions/response_dialogs.dart';
import '../../../../core/widgets/table_screen/buttons_pages_row.dart';
import '../../../drawer/presentation/bloc/drawer_bloc.dart';
import '../../data/models/filters_students_model.dart';
import 'header_list_students.dart';
import 'item_builder_student.dart';

class StudentListPageState extends StatelessWidget {
  final Size media;

  const StudentListPageState({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    ListStudentsBloc bloc = BlocProvider.of<ListStudentsBloc>(context);
    DrawerBloc drawerBloc = BlocProvider.of<DrawerBloc>(context);
    return BlocConsumer<ListStudentsBloc, ListStudentsStates>(
        listener: (context, state) {
      if (drawerBloc.statusSaveData == false) {
        currentPageStudent = 1;
        getArchivedStudent = false;
        arabicNameStudent = "";
        englishNameStudent = "";
        fatherName = "";
        motherName = "";
        createDate = "";
        educationLevel = "";
        lineNumber = "";
      }
      if (state is ListStudentsSuccessState) {
        bloc.stateButtonArrowForwardStudent = 0;
        bloc.stateButtonArrowBackStudent = 0;
        bloc.stateButtonDeleteStudent = 0;
      } else if (state is ListStudentsFailureState) {
        bloc.failureText = state.message;
      } else if (state is DeleteStudentsFailureState) {
        showErrorSnackBar(context, state.message);
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Column(
          children: [
            HeaderListStudents(media: media),
            ItemBuilderStudent(
              bloc: bloc,
              state: state,
              students: bloc.students,
            ),
            ButtonsPagesRow(
              pageNumber: currentPageStudent,
              onPresBack: () {
                if (bloc.stateButtonArrowBackStudent == 0) {
                  if (currentPageStudent > 1) {
                    drawerBloc.statusSaveData = true;
                    currentPageStudent--;
                    FiltersStudentModel filter = FiltersStudentModel(
                        pageNumber: currentPageStudent,
                        arabicNameStudent: arabicNameStudent,
                        englishNameStudent: englishNameStudent,
                        fatherName: fatherName,
                        motherName: motherName,
                        createDate: createDate,
                        educationLevel: educationLevel,
                        lineNumber: lineNumber,
                        getArchived: getArchivedStudent);
                    print("arabicNameStudent  in list : $arabicNameStudent");
                    BlocProvider.of<ListStudentsBloc>(context)
                        .add(FilterStudentsListEvent(studentsFilter2: filter));
                  }
                  bloc.stateButtonArrowBackStudent++;
                }
              },
              onPresForward: () {
                if (bloc.stateButtonArrowForwardStudent == 0) {
                  if (bloc.students.meta!.currentPage! <
                      bloc.students.meta!.lastPage!) {
                    drawerBloc.statusSaveData = true;
                    currentPageStudent++;
                    FiltersStudentModel filter = FiltersStudentModel(
                        pageNumber: currentPageStudent,
                        arabicNameStudent: arabicNameStudent,
                        englishNameStudent: englishNameStudent,
                        fatherName: fatherName,
                        motherName: motherName,
                        createDate: createDate,
                        educationLevel: educationLevel,
                        lineNumber: lineNumber,
                        getArchived: getArchivedStudent);
                    print(arabicNameStudent);
                    BlocProvider.of<ListStudentsBloc>(context)
                        .add(FilterStudentsListEvent(studentsFilter2: filter));
                  }
                  bloc.stateButtonArrowForwardStudent++;
                }
              },
            ),
          ],
        ),
      );
    });
  }
}
